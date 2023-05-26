*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230503_SCR
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  SELECT-OPTIONS : S_ZCODE FOR ZEDT05_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99'.
  SELECT-OPTIONS : S_ZPERNR FOR ZEDT05_001-ZPERNR.
  SELECT-OPTIONS : S_ZGUBUN FOR ZEDT05_001-ZGUBUN NO INTERVALS NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK B1.