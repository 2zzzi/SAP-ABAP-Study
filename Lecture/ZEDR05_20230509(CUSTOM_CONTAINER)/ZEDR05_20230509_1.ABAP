*&---------------------------------------------------------------------*
*& Report ZEDR05_20230509_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230509_1 MESSAGE-ID ZMED05.

INCLUDE ZEDR05_20230509_1_TOP.
INCLUDE ZEDR05_20230509_1_SCR.
INCLUDE ZEDR05_20230509_1_F01.
INCLUDE ZEDR05_20230509_1_PBO.
INCLUDE ZEDR05_20230509_1_PAI.

START-OF-SELECTION.
  IF S_ZCODE IS NOT INITIAL.
    PERFORM SELECT_DATA.
  ELSE.
    MESSAGE I000.
    EXIT.
  ENDIF.

  IF GT_STUDENT[] IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE I001.
    EXIT.
  ENDIF.