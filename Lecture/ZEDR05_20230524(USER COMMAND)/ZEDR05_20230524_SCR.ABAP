*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230524_SCR
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  SELECT-OPTIONS : S_ZCODE FOR GS_STUDENT-ZCODE DEFAULT 'SSU-00' TO 'SSU-99'.
  SELECT-OPTIONS : S_ZPERNR FOR GS_STUDENT-ZPERNR.
  SELECT-OPTIONS : S_ZGUBUN FOR GS_STUDENT-ZGUBUN NO INTERVALS NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK B1.