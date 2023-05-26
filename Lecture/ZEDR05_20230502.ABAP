*&---------------------------------------------------------------------*
*& Report ZEDR05_20230502
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230502.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.
DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.
DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.
DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.
DATA : GT_SORT TYPE SLIS_SORTINFO_ALV OCCURS 0.

DATA : BEGIN OF GT_SFLIGHT OCCURS 0,
         CARRID LIKE SFLIGHT-CARRID,
         CONNID LIKE SFLIGHT-CONNID,
         FLDATE LIKE SFLIGHT-FLDATE,
         PRICE  LIKE SFLIGHT-PRICE,
       END OF GT_SFLIGHT.



PERFORM SELECT_DATA.
PERFORM ALV_DATA.


*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SELECT_DATA .

  SELECT  CARRID
          CONNID
          FLDATE
          PRICE
    FROM SFLIGHT
    INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ALV_DATA .

  PERFORM FIELD_CATALOG.
  PERFORM LAYOUT_SET.
  PERFORM SORT_SET.
  PERFORM ALV_DISPLAY.

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
  GS_FIELDCAT-SELTEXT_M = 'CARRID'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'CONNID'.
  GS_FIELDCAT-SELTEXT_M = 'CONNID'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'FLDATE'.
  GS_FIELDCAT-SELTEXT_M = 'FLDATE'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'PRICE'.
  GS_FIELDCAT-SELTEXT_M = 'PRICE'.
  GS_FIELDCAT-DO_SUM = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_DISPLAY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ALV_DISPLAY .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      IT_FIELDCAT = GT_FIELDCAT
      IS_LAYOUT   = GS_LAYOUT
      IT_SORT     = GT_SORT
    TABLES
      T_OUTTAB    = GT_SFLIGHT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  LAYOUT_SET
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM LAYOUT_SET .

*  GS_LAYOUT-NO_COLHEAD = 'X'.
*  GS_LAYOUT-ZEBRA = 'X'.
*  GS_LAYOUT-NO_VLINE = 'X'.
*  GS_LAYOUT-NO_HLINE = 'X'.
*  GS_LAYOUT-EDIT = 'X'. " 모든 필드를 에딧할 수 있음. 필드카타로그의 에딧과는 조금 차이가 있죠?
  GS_LAYOUT-TOTALS_BEFORE_ITEMS = 'X'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SORT_SET
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SORT_SET .

  GS_SORT-SPOS = 1.
  GS_SORT-FIELDNAME = 'CARRID'.
  GS_SORT-UP = 'X'.
  GS_SORT-SUBTOT = 'X'.
  APPEND GS_SORT TO GT_SORT.

ENDFORM.