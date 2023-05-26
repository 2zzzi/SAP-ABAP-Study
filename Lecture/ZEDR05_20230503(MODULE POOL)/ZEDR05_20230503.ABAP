*&---------------------------------------------------------------------*
*& Report ZEDR05_20230503
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230503 MESSAGE-ID ZEMD05.

INCLUDE ZEDR05_20230503_TOP.
INCLUDE ZEDR05_20230503_SCR.
INCLUDE ZEDR05_20230503_F01.
INCLUDE ZEDR05_20230503_PBO.
INCLUDE ZEDR05_20230503_PAI.

START-OF-SELECTION.
IF S_ZCODE IS INITIAL.
  IF S_ZPERNR IS INITIAL.
    MESSAGE I000.
    EXIT.
  ENDIF.
ENDIF.

PERFORM SELECT_DATA.

IF GT_STUDENT[] IS NOT INITIAL.
  CALL SCREEN 100.
ELSE.
  MESSAGE I000.
  EXIT.
ENDIF.