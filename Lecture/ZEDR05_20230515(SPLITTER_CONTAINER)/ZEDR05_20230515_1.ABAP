*&---------------------------------------------------------------------*
*& Report ZEDR05_20230515_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230515_1 MESSAGE-ID ZMED05.

INCLUDE ZEDR05_20230515_1_TOP.
INCLUDE ZEDR05_20230515_1_SCR.
INCLUDE ZEDR05_20230515_1_F01.
INCLUDE ZEDR05_20230515_1_PBO.
INCLUDE ZEDR05_20230515_1_PAI.


START-OF-SELECTION.
IF S_ZCODE IS INITIAL.
  IF S_ZPERNR IS INITIAL.
    MESSAGE I000.
    EXIT.
  ENDIF.
ENDIF.

PERFORM SELECT_DATA.

IF GT_STUDENT[] IS NOT INITIAL.
  IF GT_GRADE[] IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE I000.
    EXIT.
  ENDIF.
ELSE.
  MESSAGE I000.
  EXIT.
ENDIF.