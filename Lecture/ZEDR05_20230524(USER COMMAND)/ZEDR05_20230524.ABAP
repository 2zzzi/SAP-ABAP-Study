*&---------------------------------------------------------------------*
*& Report ZEDR05_20230524
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230524 MESSAGE-ID ZMED05.

INCLUDE ZEDR05_20230524_TOP.
INCLUDE ZEDR05_20230524_SCR.
INCLUDE ZEDR05_20230524_F01.
INCLUDE ZEDR05_20230524_PBO.
INCLUDE ZEDR05_20230524_PAI.

START-OF-SELECTION.
  PERFORM SELECT_DATA.

IF S_ZCODE IS INITIAL.
  MESSAGE I000.
  EXIT.
ENDIF.

IF GT_STUDENT[] IS NOT INITIAL.
  CALL SCREEN 100.

ELSE.
  MESSAGE I001.
  EXIT.
ENDIF.