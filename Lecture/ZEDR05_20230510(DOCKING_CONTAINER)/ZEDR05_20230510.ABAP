*&---------------------------------------------------------------------*
*& Report ZEDR05_20230510
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230510 MESSAGE-ID ZMED05.

INCLUDE ZEDR05_20230510_TOP.
INCLUDE ZEDR05_20230510_SCR.
INCLUDE ZEDR05_20230510_F01.
INCLUDE ZEDR05_20230510_PBO.
INCLUDE ZEDR05_20230510_PAI.

START-OF-SELECTION.
IF S_ZCODE IS NOT INITIAL.
  PERFORM SELECT_DATA.

  IF GT_STUDENT[] IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE I001.
    EXIT.
  ENDIF.
ELSE.
  MESSAGE I000.
  EXIT.
ENDIF.