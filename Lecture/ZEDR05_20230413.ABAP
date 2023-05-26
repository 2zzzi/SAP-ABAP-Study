*&---------------------------------------------------------------------*
*& Report ZEDR05_20230413
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230413.

DATA : BEGIN OF GS_STUDENT.
    INCLUDE TYPE ZEDT05_001.
DATA : END OF GS_STUDENT.
DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.


*PERFORM GET_DATA CHANGING GT_STUDENT.
PERFORM GET_DATA.

  LOOP AT GT_STUDENT INTO GS_STUDENT.
    WRITE :/ GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.
  ENDLOOP.
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*FORM GET_DATA CHANGING PT_STUDENT LIKE GT_STUDENT.
FORM GET_DATA .

  DATA : LS_STUDENT LIKE GS_STUDENT.

  LS_STUDENT-ZCODE = 'SSU-01'.

  SELECT SINGLE ZKNAME FROM ZEDT05_001
    INTO LS_STUDENT-ZKNAME
    WHERE ZCODE = LS_STUDENT-ZCODE.
  APPEND LS_STUDENT TO GT_STUDENT.

  LS_STUDENT-ZCODE = 'SSU-02'.

  SELECT SINGLE ZKNAME FROM ZEDT05_001
    INTO LS_STUDENT-ZKNAME
    WHERE ZCODE = LS_STUDENT-ZCODE.
  APPEND LS_STUDENT TO GT_STUDENT.


ENDFORM.

*DO 2 TIMES.
*  PERFORM SY-INDEX OF SUBR1 SUBR2.
*ENDDO.
*
**&---------------------------------------------------------------------*
**&      Form  SUBR1
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM SUBR1 .
*  WRITE :/ SY-INDEX, '번째 서브루틴'.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  SUBR2
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM SUBR2 .
*  WRITE :/ SY-INDEX, '번째 서브루틴'.
*ENDFORM.