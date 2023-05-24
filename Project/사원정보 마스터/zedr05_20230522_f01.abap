*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230522_F01
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

  S_ZDATE-LOW = SY-DATUM(6) && '01'.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'
    EXPORTING
      DAY_IN            = S_ZDATE-LOW
    IMPORTING
      LAST_DAY_OF_MONTH = S_ZDATE-LOW.

  APPEND S_ZDATE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  VAILD_INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM VAILD_INPUT .
  IF S_ZDATE[] IS INITIAL.
    MESSAGE I000.
    STOP.
  ENDIF.

  IF S_ZEMPNO IS INITIAL.
    IF S_ZDEPT IS INITIAL.
      MESSAGE I000.
      STOP.
    ENDIF.
  ENDIF.

  R_FG-SIGN = 'I'.
  R_FG-OPTION = 'EQ'.
  R_FG-LOW = ' '.
  APPEND R_FG.

  IF P_CHECK = 'X'.
    R_FG-LOW = 'X'.
    APPEND R_FG.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  VALID_AUTHO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM VALID_AUTHO .
  SELECT SINGLE *
    FROM ZWORK05_001_5
    INTO CORRESPONDING FIELDS OF GS_AUTHO
    WHERE ZID = SY-UNAME.

  IF GS_AUTHO-ZFRDATE <= SY-DATUM AND GS_AUTHO-ZTODATE >= SY-DATUM.
    IF GS_AUTHO-ZLEVEL1 NE 'X'.
      MESSAGE I003.
      STOP.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SELECT_DATA .

  SELECT *
     INTO CORRESPONDING FIELDS OF TABLE GT_INFO_JOIN
     FROM ZWORK05_001_1_1 AS A
     LEFT OUTER JOIN ZWORK05_001_1_2 AS B
     ON A~ZEMPNO = B~ZEMPNO
     WHERE A~ZEMPNO IN S_ZEMPNO
     AND ZDEPTNR IN S_ZDEPT
     AND ZFRDATE <= S_ZDATE-LOW
     AND ZTODATE >= S_ZDATE-LOW
     AND ZRETIRE_FG IN R_FG.

  IF GT_INFO_JOIN[] IS NOT INITIAL.
    SELECT * FROM ZWORK05_001_2
      INTO CORRESPONDING FIELDS OF TABLE GT_SAL1
      FOR ALL ENTRIES IN GT_INFO_JOIN
      WHERE ZEMPNO = GT_INFO_JOIN-ZEMPNO
      AND ZCONTSTDATE <= S_ZDATE-LOW
      AND ZCONTENDDATE >= S_ZDATE-LOW.

    SELECT * FROM ZWORK05_001_3
      INTO CORRESPONDING FIELDS OF TABLE GT_EVAL
      FOR ALL ENTRIES IN GT_INFO_JOIN
      WHERE ZEMPNO = GT_INFO_JOIN-ZEMPNO
      AND ZEVALDATEFR <= S_ZDATE-LOW
      AND ZEVALDATETO >=  S_ZDATE-LOW.
  ENDIF.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA_1 .

  CLEAR : GS_INFO_JOIN , GS_RESULT1.

  LOOP AT GT_INFO_JOIN INTO GS_INFO_JOIN.

    PERFORM DEPT_NAME USING GS_INFO_JOIN-ZDEPTNR
                      CHANGING GS_INFO_JOIN-ZDEPTNAME.

    PERFORM RANK_NAME USING GS_INFO_JOIN-ZRANKCODE
                      CHANGING GS_INFO_JOIN-ZRANKNAME.

    PERFORM GENDER_NAME USING GS_INFO_JOIN-ZGENDER
                        CHANGING GS_INFO_JOIN-ZGUBUNNAME.

    PERFORM ICON USING GS_INFO_JOIN-ZRANKCODE
                       GS_INFO_JOIN-ZRETIRE_FG
                 CHANGING GS_INFO_JOIN-ICON.

    MOVE-CORRESPONDING GS_INFO_JOIN TO GS_RESULT1.
    APPEND GS_RESULT1 TO GT_RESULT1.

    CLEAR : GS_INFO_JOIN.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DEPT_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_INFO_JOIN_DEPTNR  text
*      <--P_GS_INFO_JOIN_DEPTNAME  text
*----------------------------------------------------------------------*
FORM DEPT_NAME  USING    P_GS_INFO_JOIN_DEPTNR
                CHANGING P_GS_INFO_JOIN_DEPTNAME.

  CASE P_GS_INFO_JOIN_DEPTNR.
    WHEN 'SS0001'.
      P_GS_INFO_JOIN_DEPTNAME = '회계팀'.
    WHEN 'SS0002'.
      P_GS_INFO_JOIN_DEPTNAME = '구매팀'.
    WHEN 'SS0003'.
      P_GS_INFO_JOIN_DEPTNAME = '인사팀'.
    WHEN 'SS0004'.
      P_GS_INFO_JOIN_DEPTNAME = '영업팀'.
    WHEN 'SS0005'.
      P_GS_INFO_JOIN_DEPTNAME = '생산팀'.
    WHEN 'SS0006'.
      P_GS_INFO_JOIN_DEPTNAME = '관리팀'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  RANK_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_INFO_JOIN_ZRANKCODE  text
*      <--P_GS_INFO_JOIN_ZRANKNAME  text
*----------------------------------------------------------------------*
FORM RANK_NAME  USING    P_GS_INFO_JOIN_ZRANKCODE
                CHANGING P_GS_INFO_JOIN_ZRANKNAME.

  CASE P_GS_INFO_JOIN_ZRANKCODE.
    WHEN 'A'.
      P_GS_INFO_JOIN_ZRANKNAME = '인턴'.
    WHEN 'B'.
      P_GS_INFO_JOIN_ZRANKNAME = '사원'.
    WHEN 'C'.
      P_GS_INFO_JOIN_ZRANKNAME = '대리'.
    WHEN 'D'.
      P_GS_INFO_JOIN_ZRANKNAME = '과장'.
    WHEN 'E'.
      P_GS_INFO_JOIN_ZRANKNAME = '차장'.
    WHEN 'F'.
      P_GS_INFO_JOIN_ZRANKNAME = '부장'.
    WHEN 'G'.
      P_GS_INFO_JOIN_ZRANKNAME = '임원'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  GENDER_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_INFO_JOIN_ZGENDER  text
*      <--P_GS_INFO_JOIN_ZGUBUNNAME  text
*----------------------------------------------------------------------*
FORM GENDER_NAME  USING    P_GS_INFO_JOIN_ZGENDER
                  CHANGING P_GS_INFO_JOIN_ZGUBUNNAME.

  CASE P_GS_INFO_JOIN_ZGENDER.
    WHEN 'M'.
      P_GS_INFO_JOIN_ZGUBUNNAME = '남자'.
    WHEN 'F'.
      P_GS_INFO_JOIN_ZGUBUNNAME = '여자'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA_2 .

  CLEAR : GS_EVAL.

  LOOP AT GT_EVAL INTO GS_EVAL.
    MOVE-CORRESPONDING GS_EVAL TO GS_RESULT2.

    PERFORM DEPT_NAME USING GS_EVAL-ZDEPTNR
                      CHANGING GS_RESULT2-ZDEPTNAME.

    APPEND GS_RESULT2 TO GT_RESULT2.

  ENDLOOP.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA_3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA_3 .

  CLEAR : GS_SAL1, GS_RESULT3.

  LOOP AT GT_SAL1 INTO GS_SAL1.

    MOVE-CORRESPONDING GS_SAL1 TO GS_RESULT3.

    PERFORM BANK_NAME USING GS_SAL1-ZBANKNR
                      CHANGING GS_RESULT3-ZBANKNAME.

    APPEND GS_RESULT3 TO GT_RESULT3.
    CLEAR : GS_SAL1.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  BANK_NAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_SAL1_ZBANKNR  text
*      <--P_GS_RESULT3_ZBANNAME  text
*----------------------------------------------------------------------*
FORM BANK_NAME  USING    P_GS_SAL1_ZBANKNR
                CHANGING P_GS_RESULT3_ZBANNAME.

  CASE P_GS_SAL1_ZBANKNR.
    WHEN '001'.
      P_GS_RESULT3_ZBANNAME = '신한'.
    WHEN '002'.
      P_GS_RESULT3_ZBANNAME = '우리'.
    WHEN '003'.
      P_GS_RESULT3_ZBANNAME = '하나'.
    WHEN '004'.
      P_GS_RESULT3_ZBANNAME = '국민'.
    WHEN '005'.
      P_GS_RESULT3_ZBANNAME = '카카오'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CREATE_OBJECT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING
    EXPORTING
      REPID     = SY-REPID
      DYNNR     = SY-DYNNR
      EXTENSION = 2000.

  CREATE OBJECT GC_SPLITTER1
    EXPORTING
      PARENT  = GC_DOCKING
      ROWS    = 2
      COLUMNS = 1.

  CALL METHOD GC_SPLITTER1->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GC_CONTAINER1.

  CALL METHOD GC_SPLITTER1->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GC_CONTAINER2.

  CREATE OBJECT GC_SPLITTER2
    EXPORTING
      PARENT  = GC_CONTAINER1
      ROWS    = 1
      COLUMNS = 2.

  CALL METHOD GC_SPLITTER2->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GC_CONTAINER3.

  CALL METHOD GC_SPLITTER2->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 2
    RECEIVING
      CONTAINER = GC_CONTAINER4.

  CREATE OBJECT GC_GRID1
    EXPORTING
      I_PARENT = GC_CONTAINER2.

  CREATE OBJECT GC_GRID2
    EXPORTING
      I_PARENT = GC_CONTAINER3.

  CREATE OBJECT GC_GRID3
    EXPORTING
      I_PARENT = GC_CONTAINER4.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG .

  PERFORM FIELDCAT_1.
  PERFORM FIELDCAT_2.
  PERFORM FIELDCAT_3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDCAT_1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDCAT_1 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ICON'.
  GS_FIELDCAT-SCRTEXT_M = '구분'.
  GS_FIELDCAT-ICON = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SCRTEXT_M = '사원번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNAME'.
  GS_FIELDCAT-SCRTEXT_M = '사원이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNAME'.
  GS_FIELDCAT-SCRTEXT_M = '부서'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZFRDATE'.
  GS_FIELDCAT-SCRTEXT_M = '시작날짜'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZTODATE'.
  GS_FIELDCAT-SCRTEXT_M = '종료날짜'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZRANKNAME'.
  GS_FIELDCAT-SCRTEXT_M = '직급'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 8.
  GS_FIELDCAT-FIELDNAME = 'ZGUBUNNAME'.
  GS_FIELDCAT-SCRTEXT_M = '성별'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 9.
  GS_FIELDCAT-FIELDNAME = 'ZEMPDATE'.
  GS_FIELDCAT-SCRTEXT_M = '입사일자'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 10.
  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.
  GS_FIELDCAT-SCRTEXT_M = '주소'.
  GS_FIELDCAT-OUTPUTLEN = '18'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  IF P_CHECK = 'X'.
    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 11.
    GS_FIELDCAT-FIELDNAME = 'ZRETDATE'.
    GS_FIELDCAT-SCRTEXT_M = '퇴사일자'.
    GS_FIELDCAT-OUTPUTLEN = '10'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

    CLEAR : GS_FIELDCAT.
    GS_FIELDCAT-COL_POS = 12.
    GS_FIELDCAT-FIELDNAME = 'ZRETIRE_FG'.
    GS_FIELDCAT-SCRTEXT_M = '퇴사구분'.
    GS_FIELDCAT-OUTPUTLEN = '8'.
    APPEND GS_FIELDCAT TO GT_FIELDCAT1.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDCAT_2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDCAT_2 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SCRTEXT_M = '사원번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNAME'.
  GS_FIELDCAT-SCRTEXT_M = '사원명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZEVALYEAR'.
  GS_FIELDCAT-SCRTEXT_M = '연도'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZEVALDATEFR'.
  GS_FIELDCAT-SCRTEXT_M = '시작일자'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZEVALDATETO'.
  GS_FIELDCAT-SCRTEXT_M = '종료일자'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZEVALRANK'.
  GS_FIELDCAT-SCRTEXT_M = '평가'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELDCAT_3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELDCAT_3 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SCRTEXT_M = '사원번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZCONTYEAR'.
  GS_FIELDCAT-SCRTEXT_M = '연도'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZCONTSTDATE'.
  GS_FIELDCAT-SCRTEXT_M = '시작일자'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZCONTENDDATE'.
  GS_FIELDCAT-SCRTEXT_M = '종료일자'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZCONTAMT'.
  GS_FIELDCAT-SCRTEXT_M = '계약금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-DO_SUM = 'X'.
  GS_FIELDCAT-OUTPUTLEN = '15'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.
  GS_FIELDCAT-SCRTEXT_M = '은행명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZAMTNR'.
  GS_FIELDCAT-SCRTEXT_M = '계좌번호'.
  GS_FIELDCAT-OUTPUTLEN = '10'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SORT .

  PERFORM SORT1.
  PERFORM SORT2.
  PERFORM SORT3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SORT1 .

  CLEAR : GS_SORT, GT_SORT1.
  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZEMPNO'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT1.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SORT2 .

  CLEAR : GS_SORT, GT_SORT2.
  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZEMPNO'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT2.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SORT3 .

  CLEAR : GS_SORT, GT_SORT3.
  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZEMPNO'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_LAYOUT .

  CLEAR : GS_LAYOUT, GS_VARIANT.
  GS_LAYOUT-ZEBRA = 'X'.
  GS_VARIANT-USERNAME = SY-UNAME.
  GS_VARIANT-REPORT = SY-REPID.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CALL_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CALL_ALV .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_VARIANT      = GS_VARIANT
      I_SAVE          = 'A'
      IS_LAYOUT       = GS_LAYOUT
    CHANGING
      IT_OUTTAB       = GT_RESULT1
      IT_FIELDCATALOG = GT_FIELDCAT1
      IT_SORT         = GT_SORT1.

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_VARIANT      = GS_VARIANT
      I_SAVE          = 'A'
      IS_LAYOUT       = GS_LAYOUT
    CHANGING
      IT_OUTTAB       = GT_RESULT2
      IT_FIELDCATALOG = GT_FIELDCAT2
      IT_SORT         = GT_SORT2.

  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
      IS_VARIANT      = GS_VARIANT
      I_SAVE          = 'A'
      IS_LAYOUT       = GS_LAYOUT
    CHANGING
      IT_OUTTAB       = GT_RESULT3
      IT_FIELDCATALOG = GT_FIELDCAT3
      IT_SORT         = GT_SORT3.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ICON
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_INFO_JOIN_ZRANKCODE  text
*      -->P_GS_INFO_JOIN_ZRETIRE_FG  text
*      <--P_GS_INFO_JOIN_ICON  text
*----------------------------------------------------------------------*
FORM ICON  USING    P_GS_INFO_JOIN_ZRANKCODE
                    P_GS_INFO_JOIN_ZRETIRE_FG
           CHANGING P_GS_INFO_JOIN_ICON.

  IF P_GS_INFO_JOIN_ZRANKCODE = 'A'.
    P_GS_INFO_JOIN_ICON = '@09@'.
  ELSEIF P_GS_INFO_JOIN_ZRETIRE_FG = 'X'.
    P_GS_INFO_JOIN_ICON = '@0A@'.
  ELSE.
    P_GS_INFO_JOIN_ICON = '@08@'.
  ENDIF.

ENDFORM.