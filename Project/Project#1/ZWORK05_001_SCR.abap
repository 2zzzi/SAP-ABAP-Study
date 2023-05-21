*&---------------------------------------------------------------------*
*&  Include           ZWORK05_001_SCR
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
"Select Radiobutton
PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1. "사원 정보
PARAMETERS : P_R2 RADIOBUTTON GROUP R1.                              "평가 확인
PARAMETERS : P_R3 RADIOBUTTON GROUP R1.                              "연봉 지급
SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.
"Deafult
SELECT-OPTIONS : S_ZEMPNO FOR GS_INFO1-ZEMPNO DEFAULT '1' TO '9999999999' OBLIGATORY.

"M1
SELECT-OPTIONS : S_ZDATE FOR GS_INFO1-ZFRDATE MODIF ID M1 OBLIGATORY.
SELECT-OPTIONS : S_ZDEPT FOR GS_INFO1-ZDEPTNR NO INTERVALS NO-EXTENSION MODIF ID M1.

"M2
PARAMETERS : P_YEAR LIKE GS_SALARY2-ZSALYEAR DEFAULT sy-datum(4) MODIF ID M2 OBLIGATORY.
PARAMETERS : P_MONTH TYPE C LENGTH 2 DEFAULT sy-datum+4(2) MODIF ID M2 OBLIGATORY.

"M3
PARAMETERS : P_FG AS CHECKBOX DEFAULT 'X' MODIF ID M3.
SELECTION-SCREEN END OF BLOCK B2.

INITIALIZATION.
  CONCATENATE SY-DATUM(4) '0101' INTO GV_ZFRDATE.
  CONCATENATE SY-DATUM(4) '1231' INTO GV_ZTODATE.
  S_ZDATE-LOW = GV_ZFRDATE.
  S_ZDATE-HIGH = GV_ZTODATE.
  APPEND S_ZDATE.
*&---------------------------------------------------------------------*
*&      Form  SET_SCREEN1000
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SCREEN1000 .
  LOOP AT SCREEN.
    IF P_R1 ='X'.
      IF SCREEN-GROUP1 = 'M2'.
        SCREEN-ACTIVE = '0'.
      ELSE.
        SCREEN-ACTIVE = '1'.
      ENDIF.
    ELSEIF P_R2 = 'X'.
      IF SCREEN-GROUP1 = 'M1'.
        SCREEN-ACTIVE = '0'.
      ELSE.
        SCREEN-ACTIVE = '1'.
      ENDIF.
    ELSEIF P_R3 = 'X'.
      IF SCREEN-GROUP1 = 'M1'.
        SCREEN-ACTIVE = '0'.
      ENDIF.
      IF SCREEN-GROUP1 = 'M3'.
        SCREEN-ACTIVE = '0'.
      ENDIF.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.
ENDFORM.