*&---------------------------------------------------------------------*
*& Report ZEDR05_20230418
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230418 MESSAGE-ID ZMED05.

TABLES : ZEDT05_001.
TABLES : ZEDT05_002.

DATA : BEGIN OF GS_ZEDT05_002.
  INCLUDE TYPE ZEDT05_002.
DATA : END OF GS_ZEDT05_002.
DATA : GT_ZEDT05_002 LIKE TABLE OF GS_ZEDT05_002.

SELECT * FROM ZEDT05_002 INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT05_002.

DATA : BEGIN OF GS_STUDENT.
  INCLUDE TYPE ZEDT05_001.
DATA : END OF GS_STUDENT.
DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  SELECT-OPTIONS : S_ZCODE FOR ZEDT05_001-ZCODE MATCHCODE OBJECT ZSH05_003.
  PARAMETERS : P_ZPERNR LIKE ZEDT05_001-ZPERNR MODIF ID M1.
  PARAMETERS : P_ZGUBUN LIKE ZEDT05_001-ZGUBUN DEFAULT 'M' MODIF ID M2.
SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.
  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.
  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.
SELECTION-SCREEN END OF BLOCK B2.

AT SELECTION-SCREEN OUTPUT.
  PERFORM SET_SCREEN.

START-OF-SELECTION.

IF S_ZCODE IS INITIAL.
  MESSAGE I000.
*  MESSAGE E000.
  EXIT.
ENDIF.

PERFORM SELECT_DATA.
IF GT_STUDENT[] IS INITIAL.
  MESSAGE I001.
  EXIT.
ENDIF.

PERFORM WRITE_DATA.
*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SELECT_DATA .
  SELECT * FROM ZEDT05_001
    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT
    WHERE ZCODE IN S_ZCODE
    AND ZGUBUN = P_ZGUBUN.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  WRITE_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM WRITE_DATA .
  LOOP AT GT_STUDENT INTO GS_STUDENT.
    WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.
    CLEAR GS_STUDENT.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_SCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM SET_SCREEN .
  LOOP AT SCREEN.
    IF SCREEN-GROUP1 = 'M2'.
      IF P_R1 = 'X'.
        SCREEN-ACTIVE = '1'.
        SCREEN-DISPLAY_3D = '0'.
        SCREEN-INTENSIFIED = '0'.
      ELSEIF P_R2 = 'X'.
        SCREEN-ACTIVE = '0'.
      ENDIF.
*    ELSEIF SCREEN-GROUP1 = 'M1'.
*      IF P_R1 = 'X'.
*        SCREEN-DISPLAY_3D = '1'.
*        SCREEN-INTENSIFIED = '1'.
*        SCREEN-INVISIBLE = '1'.
*      ENDIF.
    ENDIF.
    MODIFY SCREEN.
  ENDLOOP.
ENDFORM.