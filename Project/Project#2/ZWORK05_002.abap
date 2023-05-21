*&---------------------------------------------------------------------*
*& Report ZWORK05_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZWORK05_002 MESSAGE-ID ZMED05.

INCLUDE ZWORK05_001_TOP.
INCLUDE ZWORK05_001_SCR.
INCLUDE ZWOKR05_001_F01.


AT SELECTION-SCREEN OUTPUT.
  PERFORM SET_SCREEN1000.

START-OF-SELECTION.
  PERFORM CHECK_AUTHO.
  IF P_R1 = 'X'.
    PERFORM ALV_RESULT1.

  ELSEIF P_R2 = 'X'.
    IF GV_AUTHO_LEVEL1 = 'X'.
      PERFORM ALV_RESULT2.
    else.
      MESSAGE i002.
      EXIT.
    ENDIF.

  ELSEIF p_r3 = 'X'.
    IF GV_AUTHO_LEVEL2 = 'X'.
      perform ALV_result3.
    else.
      MESSAGE i002.
      exit.
    ENDIF.

  ENDIF.