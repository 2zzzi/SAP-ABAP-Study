*&---------------------------------------------------------------------*
*& Report ZEDR05_20230428
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230428.

TABLES : ZEDT05_001, ZEDT05_002.


DATA : BEGIN OF GS_STUDENT.
    INCLUDE TYPE ZEDT05_001.
DATA : ZSUM LIKE ZEDT05_002-ZSUM.
DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.
DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

PERFORM SELECT_DATA_JOIN.
PERFORM FIELD_CATALOG.
PERFORM ALV_DISPLAY.

*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA_JOIN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM SELECT_DATA_JOIN .
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT
    FROM ZEDT05_001 AS A
    INNER JOIN ZEDT05_002 AS B
    ON A~ZCODE = B~ZCODE.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZCODE'.
  GS_FIELDCAT-SELTEXT_M = '학생코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.
  GS_FIELDCAT-SELTEXT_M = '출석번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.
  GS_FIELDCAT-SELTEXT_M = '이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.
  GS_FIELDCAT-SELTEXT_M = '성별'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZSUM'.
  GS_FIELDCAT-SELTEXT_M = '입학등록금'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

FORM ALV_DISPLAY .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      IT_FIELDCAT = GT_FIELDCAT
    TABLES
      T_OUTTAB    = GT_STUDENT.

ENDFORM.