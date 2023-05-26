*&---------------------------------------------------------------------*
*& Report ZEDR05_20230508
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230508 MESSAGE-ID ZMED05.

INCLUDE ZEDR05_20230508_TOP.
INCLUDE ZEDR05_20230508_SCR.
INCLUDE ZEDR05_20230508_F01.
INCLUDE ZEDR05_20230508_PBO.
INCLUDE ZEDR05_20230508_PAI.

START-OF-SELECTION.
  PERFORM SELECT_DATA.

IF GT_SFLIGHT[] IS NOT INITIAL.
  CALL SCREEN 100.
ELSE.
  MESSAGE I000.
  EXIT.
ENDIF.