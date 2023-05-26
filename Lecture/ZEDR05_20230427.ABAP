*&---------------------------------------------------------------------*
*& Report ZEDR05_20230427
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230427.

TABLES : SFLIGHT.

DATA : GS_SFLIGHT LIKE SFLIGHT.
DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.
DATA : GT_ALV_SFLIGHT LIKE TABLE OF GS_SFLIGHT.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.


PERFORM SELECT_DATA.
PERFORM FIELD_CATALOG.

MOVE-CORRESPONDING GT_SFLIGHT TO GT_ALV_SFLIGHT.

PERFORM ALV_DISPLAY.


*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       SFLIGHT DATA 가져오기
*----------------------------------------------------------------------*
FORM SELECT_DATA .
  SELECT * FROM SFLIGHT
    INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT
    WHERE CARRID = 'AA'.
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
    T_OUTTAB = GT_ALV_SFLIGHT
    .
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

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'CARRID'.
  GS_FIELDCAT-SELTEXT_M = '항공코드'.
  GS_FIELDCAT-KEY = 'X'.
  GS_FIELDCAT-JUST = 'L'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'CONNID'.
  GS_FIELDCAT-SELTEXT_M = '편명'.
  GS_FIELDCAT-JUST = 'C'.
  GS_FIELDCAT-NO_OUT = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'PRICE'.
  GS_FIELDCAT-SELTEXT_M = '가격'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-JUST = 'R'.
  GS_FIELDCAT-DO_SUM = 'X'.
  GS_FIELDCAT-NO_ZERO = 'X'.
  GS_FIELDCAT-NO_SIGN = 'X'.
  GS_FIELDCAT-OUTPUTLEN = 20.
  GS_FIELDCAT-EMPHASIZE = 'X'.
  GS_FIELDCAT-EDIT = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'FLDATE'.
  GS_FIELDCAT-SELTEXT_M = '날짜'.
  GS_FIELDCAT-OUTPUTLEN = 10.
  GS_FIELDCAT-EDIT_MASK = '____/__/__'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.


ENDFORM.