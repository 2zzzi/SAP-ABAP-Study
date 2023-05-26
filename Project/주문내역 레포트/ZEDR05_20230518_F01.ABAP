*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230518_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  SET_DATE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_DATE .
*  clear : s_zddate, S_ZDDATE[],
  CONCATENATE SY-DATUM(4) '0101' INTO GV_FRDATE.
  CONCATENATE SY-DATUM(6) '01' INTO GV_TODATE.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'
    EXPORTING
      DAY_IN            = GV_TODATE
    IMPORTING
      LAST_DAY_OF_MONTH = GV_TODATE.

  S_ZJDATE-LOW = GV_FRDATE.
  S_ZJDATE-HIGH = GV_TODATE.
  S_ZJDATE-SIGN = 'I'.
  S_ZJDATE-OPTION = 'BT'.

  S_ZDDATE-LOW = GV_FRDATE.
  S_ZDDATE-HIGH = GV_TODATE.
  S_ZDDATE-SIGN = 'I'.
  S_ZDDATE-OPTION = 'BT'.

  APPEND S_ZJDATE.
  APPEND S_ZDDATE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SCREEN .
  LOOP AT SCREEN.
    IF P_R1 = 'X'.
      IF SCREEN-GROUP1 = 'M1'.
        SCREEN-ACTIVE = '1'.
      ELSEIF SCREEN-GROUP1 = 'M2'.
        SCREEN-ACTIVE = '0'.
      ENDIF.

    ELSEIF P_R2 = 'X'.
      IF SCREEN-GROUP1 = 'M2'.
        SCREEN-ACTIVE = '1'.
      ELSEIF SCREEN-GROUP1 = 'M1'.
        SCREEN-ACTIVE = '0'.
      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CHECK_VAILD_INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CHECK_VAILD_INPUT .

  IF S_ZORDNO IS INITIAL.
    IF  S_ZID IS INITIAL.
      MESSAGE I000.
      STOP.
    ENDIF.
  ENDIF.

  IF S_ZID IS NOT INITIAL.
    IF P_R1 = 'X'.
      IF S_ZJDATE[] IS INITIAL.
        MESSAGE I000.
        STOP.
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  RET_CHECK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM RET_CHECK .

  IF P_R1 = 'X'.
    R_OFG-SIGN = 'I'.
    R_OFG-OPTION = 'EQ'.
    R_OFG-LOW = '1'.
    APPEND R_OFG.

    IF P_CHECK = 'X'.
      R_OFG-LOW = '2'.
      APPEND R_OFG.
    ENDIF.

  ELSEIF P_R2 = 'X'.
    R_DFG-SIGN = 'I'.
    R_DFG-OPTION = 'EQ'.
    R_DFG-LOW = ' '.
    APPEND R_DFG.

    IF P_CHECK = 'X'.
      R_DFG-LOW = 'X'.
      APPEND R_DFG.
    ENDIF.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA_R1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SELECT_DATA_R1 .

  SELECT *
    FROM ZEDT00_004
    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER
    WHERE ZORDNO IN S_ZORDNO
    AND ZIDCODE IN S_ZID
    AND ZMATNR IN S_ZMATNR
    AND ZJDATE IN S_ZJDATE
    AND ZSALE_FG IN R_OFG.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA_R2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SELECT_DATA_R2 .

  SELECT *
    FROM ZEDT00_005
    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY
    WHERE ZORDNO IN S_ZORDNO
    AND ZIDCODE IN S_ZID
    AND ZMATNR IN S_ZMATNR
    AND ZDDATE IN S_ZDDATE
    AND ZFLAG IN R_DFG.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA_R1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA_R1 .

  CLEAR : GS_ORDER, GS_0100.

  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_0100.

    PERFORM ZMTART_NAME USING GS_ORDER-ZMTART
                        CHANGING GS_0100-ZMAT_NAME.

    IF GS_ORDER-ZSALE_FG = '1'. "매출구분
      GS_0100-ZSALE_NAME = '매출'.
      GS_0100-ICON = '@08@'.
    ELSEIF GS_ORDER-ZSALE_FG = '2'.
      GS_0100-ZSALE_NAME = '반품'.
      GS_0100-ICON = '@0A@'.
    ENDIF.

    IF P_CHECK = 'X'.
      PERFORM ZRET_NAME USING GS_ORDER-ZRET_FG
                        CHANGING GS_0100-ZRET_NAME.
    ENDIF.

    APPEND GS_0100 TO GT_0100.
    CLEAR : GS_ORDER, GS_0100.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ZMTART_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_ORDER_ZMART  text
*      <--P_GS_0100_ZMAT_NAME  text
*----------------------------------------------------------------------*
FORM ZMTART_NAME  USING    P_GS_ORDER_ZMART
                  CHANGING P_GS_0100_ZMAT_NAME.

  CASE P_GS_ORDER_ZMART.
    WHEN '001'.
      P_GS_0100_ZMAT_NAME = '식품'.
    WHEN '002'.
      P_GS_0100_ZMAT_NAME = '상품'.
    WHEN '003'.
      P_GS_0100_ZMAT_NAME = '제품'.
    WHEN '004'.
      P_GS_0100_ZMAT_NAME = '의류'.
    WHEN '005'.
      P_GS_0100_ZMAT_NAME = '도서'.
    WHEN '006'.
      P_GS_0100_ZMAT_NAME = '서비스'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ZRET_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_ORDER_ZRET_FG  text
*      <--P_GS_0100_ZRET_NAME  text
*----------------------------------------------------------------------*
FORM ZRET_NAME  USING    P_GS_ORDER_ZRET_FG
                CHANGING P_GS_0100_ZRET_NAME.

  CASE P_GS_ORDER_ZRET_FG.
    WHEN '1'.
      P_GS_0100_ZRET_NAME = '단순변심'.
    WHEN '2'.
      P_GS_0100_ZRET_NAME = '제품하자'.
    WHEN '3'.
      P_GS_0100_ZRET_NAME = '배송문제'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GC_DOCKING  text
*      -->P_GC_GRID0100  text
*----------------------------------------------------------------------*
FORM CREATE_OBJECT  USING    P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER
                             P_GRID TYPE REF TO CL_GUI_ALV_GRID.

  CREATE OBJECT P_DOCKING
    EXPORTING
*     PARENT    =
      REPID     = SY-REPID
      DYNNR     = SY-DYNNR
*     SIDE      = DOCK_AT_LEFT
      EXTENSION = 2000
*     STYLE     =
*     LIFETIME  = lifetime_default
*     CAPTION   =
*     METRIC    = 0
*     RATIO     =
*     NO_AUTODEF_PROGID_DYNNR     =
*     NAME      =
*    EXCEPTIONS
*     CNTL_ERROR                  = 1
*     CNTL_SYSTEM_ERROR           = 2
*     CREATE_ERROR                = 3
*     LIFETIME_ERROR              = 4
*     LIFETIME_DYNPRO_DYNPRO_LINK = 5
*     OTHERS    = 6
    .
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT P_GRID
    EXPORTING
*     I_SHELLSTYLE      = 0
*     I_LIFETIME        =
      I_PARENT = P_DOCKING
*     I_APPL_EVENTS     = space
*     I_PARENTDBG       =
*     I_APPLOGPARENT    =
*     I_GRAPHICSPARENT  =
*     I_NAME   =
*     I_FCAT_COMPLETE   = SPACE
*    EXCEPTIONS
*     ERROR_CNTL_CREATE = 1
*     ERROR_CNTL_INIT   = 2
*     ERROR_CNTL_LINK   = 3
*     ERROR_DP_CREATE   = 4
*     OTHERS   = 5
    .
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ICON'.
  GS_FIELDCAT-COLTEXT = '구분'.
  GS_FIELDCAT-ICON = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.
  GS_FIELDCAT-SCRTEXT_M = '주문번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.
  GS_FIELDCAT-SCRTEXT_M = '회원ID'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.
  GS_FIELDCAT-SCRTEXT_M = '제품번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.
  GS_FIELDCAT-SCRTEXT_M = '제품명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.
  GS_FIELDCAT-SCRTEXT_M = '제품유형'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.
  GS_FIELDCAT-SCRTEXT_M = '수량'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 8.
  GS_FIELDCAT-FIELDNAME = 'VRKME'.
  GS_FIELDCAT-SCRTEXT_M = '단위'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 9.
  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.
  GS_FIELDCAT-SCRTEXT_M = '판매금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-DO_SUM = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 10.
  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.
  GS_FIELDCAT-SCRTEXT_M = '매출금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-DO_SUM = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 11.
  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.
  GS_FIELDCAT-SCRTEXT_M = '할인금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-DO_SUM = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 12.
  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.
  GS_FIELDCAT-SCRTEXT_M = '매출구분'.
  GS_FIELDCAT-EMPHASIZE = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 13.
  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.
  GS_FIELDCAT-SCRTEXT_M = '판매일자'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  IF P_CHECK = 'X'.
    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 14.
    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.
    GS_FIELDCAT-SCRTEXT_M = '반품구분'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 15.
    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.
    GS_FIELDCAT-SCRTEXT_M = '반품일자'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_SORT_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SORT_0100 .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZORDNO'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_LAYOUT_0100 .

  CLEAR : GS_LAYOUT.
  GS_LAYOUT-ZEBRA = 'X'.

  CLEAR : GS_VARIANT.
  GS_VARIANT-USERNAME = SY-UNAME.
  GS_VARIANT-REPORT = SY-REPID.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CALL_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CALL_0100 .

  CALL METHOD GC_GRID0100->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
*     I_BUFFER_ACTIVE =
*     I_BYPASSING_BUFFER            =
*     I_CONSISTENCY_CHECK           =
*     I_STRUCTURE_NAME              =
      IS_VARIANT      = GS_VARIANT
      I_SAVE          = 'A'
*     I_DEFAULT       = 'X'
      IS_LAYOUT       = GS_LAYOUT
*     IS_PRINT        =
*     IT_SPECIAL_GROUPS             =
*     IT_TOOLBAR_EXCLUDING          =
*     IT_HYPERLINK    =
*     IT_ALV_GRAPHICS =
*     IT_EXCEPT_QINFO =
*     IR_SALV_ADAPTER =
    CHANGING
      IT_OUTTAB       = GT_0100
      IT_FIELDCATALOG = GT_FIELDCAT
      IT_SORT         = GT_SORT
*     IT_FILTER       =
*    EXCEPTIONS
*     INVALID_PARAMETER_COMBINATION = 1
*     PROGRAM_ERROR   = 2
*     TOO_MANY_LINES  = 3
*     OTHERS          = 4
    .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA_R2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA_R2 .

  CLEAR : GS_DELIVERY, GS_0200.

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_0200.

    PERFORM ZMTART_NAME USING GS_DELIVERY-ZMATNR
                        CHANGING GS_0200-ZMAT_NAME.

    PERFORM ZDFLAG_NAME USING GS_DELIVERY-ZDFLAG
                        CHANGING GS_0200-ZDFLAG_NAME.

    PERFORM ZDGUBUN_NAME USING GS_DELIVERY-ZDGUBUN
                         CHANGING GS_0200-ZDGUBUN_NAME.

    IF GS_0200-ZFLAG ='X'.
      GS_0200-ICON = '@0A@'.
    ELSE.
      GS_0200-ICON = '@08@'.
    ENDIF.

    APPEND GS_0200 TO GT_0200.
    CLEAR : GS_DELIVERY, GS_0200.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ICON'.
  GS_FIELDCAT-COLTEXT = '구분'.
  GS_FIELDCAT-ICON = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.
  GS_FIELDCAT-SCRTEXT_M = '주문번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.
  GS_FIELDCAT-SCRTEXT_M = '회원ID'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.
  GS_FIELDCAT-SCRTEXT_M = '제품번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.
  GS_FIELDCAT-SCRTEXT_M = '제품명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.
  GS_FIELDCAT-SCRTEXT_M = '제품유형'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.
  GS_FIELDCAT-SCRTEXT_M = '수량'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 8.
  GS_FIELDCAT-FIELDNAME = 'VRKME'.
  GS_FIELDCAT-SCRTEXT_M = '단위'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 9.
  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.
  GS_FIELDCAT-SCRTEXT_M = '매출금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-DO_SUM = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 10.
  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.
  GS_FIELDCAT-SCRTEXT_M = '배송현황'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 11.
  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.
  GS_FIELDCAT-SCRTEXT_M = '배송지역'.
  GS_FIELDCAT-EMPHASIZE = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 12.
  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.
  GS_FIELDCAT-SCRTEXT_M = '배송일자'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  IF P_CHECK = 'X'.
    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 13.
    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.
    GS_FIELDCAT-SCRTEXT_M = '반품일자'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.

    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 14.
    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.
    GS_FIELDCAT-SCRTEXT_M = '반품체크'.
    GS_FIELDCAT-EMPHASIZE = 'X'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ZDFLAG_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_DELIVERY  text
*      <--P_GS_0200_ZDFLAG_NAME  text
*----------------------------------------------------------------------*
FORM ZDFLAG_NAME  USING    P_GS_DELIVERY_ZDFLAG
                  CHANGING P_GS_0200_ZDFLAG_NAME.

  CASE P_GS_DELIVERY_ZDFLAG.
    WHEN '1'.
      P_GS_0200_ZDFLAG_NAME = '배송시작'.
    WHEN '2'.
      P_GS_0200_ZDFLAG_NAME = '배송완료'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ZDGUBUN_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_DELIVERY_ZDGUBUN  text
*      <--P_GS_0200_ZDGUBUN_NAME  text
*----------------------------------------------------------------------*
FORM ZDGUBUN_NAME  USING    P_GS_DELIVERY_ZDGUBUN
                   CHANGING P_GS_0200_ZDGUBUN_NAME.

  CASE P_GS_DELIVERY_ZDGUBUN.
    WHEN '1'.
      P_GS_0200_ZDGUBUN_NAME = '서울'.
    WHEN '2'.
      P_GS_0200_ZDGUBUN_NAME = '경기도'.
    WHEN '3'.
      P_GS_0200_ZDGUBUN_NAME = '충청북도'.
    WHEN '4'.
      P_GS_0200_ZDGUBUN_NAME = '충청남도'.
    WHEN '5'.
      P_GS_0200_ZDGUBUN_NAME = '경상북도'.
    WHEN '6'.
      P_GS_0200_ZDGUBUN_NAME = '경상남도'.
    WHEN '7'.
      P_GS_0200_ZDGUBUN_NAME = '강원도'.
    WHEN '8'.
      P_GS_0200_ZDGUBUN_NAME = '제주도'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_SORT_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SORT_0200 .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZORDNO'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_LAYOUT_0200 .

  CLEAR : GS_LAYOUT.
  GS_LAYOUT-ZEBRA = 'X'.

  CLEAR : GS_VARIANT.
  GS_VARIANT-USERNAME = SY-UNAME.
  GS_VARIANT-REPORT = SY-REPID.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CALL_0200
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CALL_0200 .

  CALL METHOD GC_GRID0200->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
*     I_BUFFER_ACTIVE =
*     I_BYPASSING_BUFFER            =
*     I_CONSISTENCY_CHECK           =
*     I_STRUCTURE_NAME              =
      IS_VARIANT      = GS_VARIANT
      I_SAVE          = 'A'
*     I_DEFAULT       = 'X'
      IS_LAYOUT       = GS_LAYOUT
*     IS_PRINT        =
*     IT_SPECIAL_GROUPS             =
*     IT_TOOLBAR_EXCLUDING          =
*     IT_HYPERLINK    =
*     IT_ALV_GRAPHICS =
*     IT_EXCEPT_QINFO =
*     IR_SALV_ADAPTER =
    CHANGING
      IT_OUTTAB       = GT_0200
      IT_FIELDCATALOG = GT_FIELDCAT
      IT_SORT         = GT_SORT
*     IT_FILTER       =
*    EXCEPTIONS
*     INVALID_PARAMETER_COMBINATION = 1
*     PROGRAM_ERROR   = 2
*     TOO_MANY_LINES  = 3
*     OTHERS          = 4
    .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


ENDFORM.