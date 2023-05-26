*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230515_1_F01
*&---------------------------------------------------------------------*
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
    FROM ZEDT05_001
    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT
    WHERE ZCODE IN S_ZCODE
    OR ZPERNR IN S_ZPERNR.

  SELECT *
    FROM ZEDT05_002
    INTO CORRESPONDING FIELDS OF TABLE GT_GRADE
    WHERE ZCODE IN S_ZCODE
    OR ZPERNR IN S_ZPERNR.

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

  CREATE OBJECT GC_SPLITTER
    EXPORTING
*     LINK_DYNNR        =
*     LINK_REPID        =
*     SHELLSTYLE        =
*     LEFT    =
*     TOP     =
*     WIDTH   =
*     HEIGHT  =
*     METRIC  = cntl_metric_dynpro
*     ALIGN   = 15
      PARENT  = GC_DOCKING
      ROWS    = 2
      COLUMNS = 1
*     NO_AUTODEF_PROGID_DYNNR =
*     NAME    =
*    EXCEPTIONS
*     CNTL_ERROR        = 1
*     CNTL_SYSTEM_ERROR = 2
*     OTHERS  = 3
    .
  IF SY-SUBRC <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CALL METHOD GC_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 1
      COLUMN    = 1
    RECEIVING
      CONTAINER = GC_CONTAINER1.

  CALL METHOD GC_SPLITTER->GET_CONTAINER
    EXPORTING
      ROW       = 2
      COLUMN    = 1
    RECEIVING
      CONTAINER = GC_CONTAINER2.

  CREATE OBJECT GC_GRID1
    EXPORTING
*     I_SHELLSTYLE      = 0
*     I_LIFETIME        =
      I_PARENT = GC_CONTAINER1
*     I_APPL_EVENTS     = space
*     I_PARENTDBG       =
*     I_APPLOGPARENT    =
*     I_GRAPHICSPARENT  =
*     I_NAME   =
*     I_FCAT_COMPLETE   = SPACE
*  EXCEPTIONS
*     ERROR_CNTL_CREATE = 1
*     ERROR_CNTL_INIT   = 2
*     ERROR_CNTL_LINK   = 3
*     ERROR_DP_CREATE   = 4
*     OTHERS   = 5
    .
  IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CREATE OBJECT GC_GRID2
    EXPORTING
*     I_SHELLSTYLE      = 0
*     I_LIFETIME        =
      I_PARENT = GC_CONTAINER2
*     I_APPL_EVENTS     = space
*     I_PARENTDBG       =
*     I_APPLOGPARENT    =
*     I_GRAPHICSPARENT  =
*     I_NAME   =
*     I_FCAT_COMPLETE   = SPACE
*  EXCEPTIONS
*     ERROR_CNTL_CREATE = 1
*     ERROR_CNTL_INIT   = 2
*     ERROR_CNTL_LINK   = 3
*     ERROR_DP_CREATE   = 4
*     OTHERS   = 5
    .
  IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.






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

  PERFORM CONTAINER1_FIELD.
  PERFORM CONTAINER2_FIELD.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONTAINER1_FIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CONTAINER1_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZCODE'.
  GS_FIELDCAT-SCRTEXT_M = '학생코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.
  GS_FIELDCAT-SCRTEXT_M = '출석번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.
  GS_FIELDCAT-SCRTEXT_M = '국문명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZENAME'.
  GS_FIELDCAT-SCRTEXT_M = '영문명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.
  GS_FIELDCAT-SCRTEXT_M = '성별'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZTEL'.
  GS_FIELDCAT-SCRTEXT_M = '전화번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONTAINER2_FIELD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CONTAINER2_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZCODE'.
  GS_FIELDCAT-SCRTEXT_M = '학생코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.
  GS_FIELDCAT-SCRTEXT_M = '출석번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZMNAME'.
  GS_FIELDCAT-SCRTEXT_M = '수업명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

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

  PERFORM CONTAINER1_SORT.
  PERFORM CONTAINER2_SORT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONTAINER1_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CONTAINER1_SORT .

  CLEAR : GS_SORT, GT_SORT1.
  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZCODE'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT1.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CONTAINER2_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CONTAINER2_SORT .

  CLEAR : GS_SORT, GT_SORT2.
  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'ZCODE'.
  GS_SORT-UP = 'X'.
  APPEND GS_SORT TO GT_SORT2.

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

  CLEAR GS_LAYOUT.
  GS_LAYOUT-ZEBRA = 'X'.

  CLEAR GS_VARIANT.
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
*      I_BUFFER_ACTIVE               =
*      I_BYPASSING_BUFFER            =
*      I_CONSISTENCY_CHECK           =
*      I_STRUCTURE_NAME              =
      IS_VARIANT                    = GS_VARIANT
      I_SAVE                        = 'A'
*      I_DEFAULT                     = 'X'
      IS_LAYOUT                     = GS_LAYOUT
*      IS_PRINT                      =
*      IT_SPECIAL_GROUPS             =
*      IT_TOOLBAR_EXCLUDING          =
*      IT_HYPERLINK                  =
*      IT_ALV_GRAPHICS               =
*      IT_EXCEPT_QINFO               =
*      IR_SALV_ADAPTER               =
    CHANGING
      IT_OUTTAB                     = GT_STUDENT
      IT_FIELDCATALOG               = GT_FIELDCAT1
      IT_SORT                       = GT_SORT1
*      IT_FILTER                     =
*    EXCEPTIONS
*      INVALID_PARAMETER_COMBINATION = 1
*      PROGRAM_ERROR                 = 2
*      TOO_MANY_LINES                = 3
*      OTHERS                        = 4
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY
    EXPORTING
*      I_BUFFER_ACTIVE               =
*      I_BYPASSING_BUFFER            =
*      I_CONSISTENCY_CHECK           =
*      I_STRUCTURE_NAME              =
      IS_VARIANT                    = GS_VARIANT
      I_SAVE                        = 'A'
*      I_DEFAULT                     = 'X'
*      IS_LAYOUT                     =
*      IS_PRINT                      =
*      IT_SPECIAL_GROUPS             =
*      IT_TOOLBAR_EXCLUDING          =
*      IT_HYPERLINK                  =
*      IT_ALV_GRAPHICS               =
*      IT_EXCEPT_QINFO               =
*      IR_SALV_ADAPTER               =
    CHANGING
      IT_OUTTAB                     = GT_GRADE
      IT_FIELDCATALOG               = GT_FIELDCAT2
      IT_SORT                       = GT_SORT2
*      IT_FILTER                     =
*    EXCEPTIONS
*      INVALID_PARAMETER_COMBINATION = 1
*      PROGRAM_ERROR                 = 2
*      TOO_MANY_LINES                = 3
*      OTHERS                        = 4
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


ENDFORM.