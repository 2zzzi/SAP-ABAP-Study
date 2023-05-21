*&---------------------------------------------------------------------*
*& Report ZWORK05_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZWORK05_001 MESSAGE-ID ZMED05.

INCLUDE ZWORK05_001_TOP.
INCLUDE ZWORK05_001_SCR.
INCLUDE ZWOKR05_001_F01.


AT SELECTION-SCREEN OUTPUT.
  PERFORM SET_SCREEN1000.

START-OF-SELECTION.
  PERFORM CHECK_AUTHO.
  IF P_R1 = 'X'.
    PERFORM TASK_RESULT1.
    IF GT_RESULT1[] IS INITIAL.
      MESSAGE I001.
      EXIT.
    ELSE.
      PERFORM DISPLAY_RESULT1.
    ENDIF.

  ELSEIF P_R2 = 'X'.
    IF GV_AUTHO_LEVEL1 = 'X'.
      PERFORM TASK_RESULT2.
      IF GT_RESULT2[] IS INITIAL.
        MESSAGE I001.
        EXIT.
      ELSE.
        PERFORM DISPLAY_RESULT2.
      ENDIF.
    ELSE.
      MESSAGE I002.
      EXIT.
    ENDIF.

  ELSEIF P_R3 = 'X'.
    IF GV_AUTHO_LEVEL2 = 'X'.
      PERFORM TASK_RESULT3.
      IF GT_RESULT3[] IS INITIAL.
        MESSAGE I001.
        EXIT.
      ELSE.
        PERFORM DISPLAY_RESULT3.
      ENDIF.
    ELSE.
      MESSAGE I002.
      EXIT.
    ENDIF.
  ENDIF.