*&---------------------------------------------------------------------*
*& Report ZEDR05_20230426
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230426 MESSAGE-ID ZMED05 .

TABLES : ZEDT05_001.

DATA : GS_STUDENT LIKE ZEDT05_001.
DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  SELECT-OPTIONS : S_ZCODE FOR ZEDT05_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99'.
  SELECT-OPTIONS : S_ZPERNR FOR ZEDT05_001-ZPERNR.
  SELECT-OPTIONS : S_ZGUBUN FOR ZEDT05_001-ZGUBUN NO INTERVALS NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK B1.

START-OF-SELECTION.
  IF S_ZCODE IS INITIAL.
    IF S_ZPERNR IS INITIAL.
      MESSAGE I000.
      EXIT.
    ENDIF.
  ENDIF.

  PERFORM SELECT_DATA.
  PERFORM FIELD_CATALOG.
  PERFORM ALV_DISPLAY.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       ZEDT05_001 테이블의 데이터를 인터널테이블로
*----------------------------------------------------------------------*
FORM SELECT_DATA .
  SELECT * FROM ZEDT05_001
    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT
    WHERE ZCODE IN S_ZCODE
    AND ZPERNR IN S_ZPERNR
    AND ZGUBUN IN S_ZGUBUN.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_DISPLAY
*&---------------------------------------------------------------------*
*       ABAP LIST VIEWR 사용 PERFORM
*----------------------------------------------------------------------*
FORM ALV_DISPLAY .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK              = ' '
*     I_BYPASSING_BUFFER             =
*     I_BUFFER_ACTIVE  = ' '
*     I_CALLBACK_PROGRAM             = ' '
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
*      I_STRUCTURE_NAME = 'ZEDT05_001'
*     IS_LAYOUT        =
     IT_FIELDCAT      = GT_FIELDCAT
*     IT_EXCLUDING     =
*     IT_SPECIAL_GROUPS              =
*     IT_SORT          =
*     IT_FILTER        =
*     IS_SEL_HIDE      =
*     I_DEFAULT        = 'X'
*     I_SAVE           = ' '
*     IS_VARIANT       =
*     IT_EVENTS        =
*     IT_EVENT_EXIT    =
*     IS_PRINT         =
*     IS_REPREP_ID     =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE              = 0
*     IR_SALV_LIST_ADAPTER           =
*     IT_EXCEPT_QINFO  =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    TABLES
      T_OUTTAB         = GT_STUDENT
* EXCEPTIONS
*     PROGRAM_ERROR    = 1
*     OTHERS           = 2
    .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG
*&---------------------------------------------------------------------*
*       ALV의 FIELD CATALOG 설정
*----------------------------------------------------------------------*
FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZCODE'.
  GS_FIELDCAT-SELTEXT_M = '학생코드(ST)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.
  GS_FIELDCAT-SELTEXT_M = '출석번호(PN)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.
  GS_FIELDCAT-SELTEXT_M = '한글이름(KN)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZENAME'.
  GS_FIELDCAT-SELTEXT_M = '영어이름(EN)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.
  GS_FIELDCAT-SELTEXT_M = '성별구분(G)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZTEL'.
  GS_FIELDCAT-SELTEXT_M = '전화번호(TEL)'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.