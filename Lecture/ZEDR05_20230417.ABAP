*&---------------------------------------------------------------------*
*& Report ZEDR05_20230417
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230417.

*PARAMETERS : P_ZCODE LIKE ZEDT05_001-ZCODE.
*PARAMETERS : P_ZCODE LIKE ZEDT05_001-ZCODE LOWER CASE.
*PARAMETERS : P_ZCODE LIKE ZEDT05_001-ZCODE OBLIGATORY. "보통 입력되지 않았을 때 EXIT문을 자주 사용함.
*PARAMETERS : P_ZCODE LIKE ZEDT05_001-ZCODE VISIBLE LENGTH 5. "ZCODE LEIGTH가 10으로 설정되어 있기 때문에 그 이상으로는 안보여줌

*PARAMETERS : P_ZPERNR TYPE C LENGTH 10.
*PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY. "보여주지 않겠다.

*PARAMETERS : P_ZNUM TYPE P DECIMALS 2.
*PARAMETERS : P_ZGUBUN LIKE ZEDT05_001-ZGUBUN DEFAULT 'M'.

*"CHECK BOX
*PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.
*IF Z_CHECK = 'X'.
*  WRITE :/ '학생 데이터 출력'.
*ELSE.
*  WRITE :/ '대학원 학생 데이터 출력'.
*
*ENDIF.

"RADIO BUTTON
*PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.
*PARAMETERS : P_R1 RADIOBUTTON GROUP R1.
*PARAMETERS : P_R2 RADIOBUTTON GROUP R1.
*
*IF P_R1 = 'X'.
*  WRITE :/ '학생 데이터 출력'.
*ELSEIF P_R2 = 'X'.
*  WRITE :/ '대학원 학생 데이터 출력'.
*ENDIF.


*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
  PARAMETERS : P_ZCODE LIKE ZEDT05_001-ZCODE OBLIGATORY.
  PARAMETERS : P_ZGUBUN LIKE ZEDT05_001-ZGUBUN DEFAULT 'M'.
SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.
SELECTION-SCREEN BEGIN OF LINE. "한줄로 만들겠다!
  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.
SELECTION-SCREEN POSITION 3. "라디오 버튼 위치를 어디서 시작하겠다.
SELECTION-SCREEN COMMENT (5) FOR FIELD P_R1. "필드명을 적을건데 LENGTH를 요만큼 할거다.
  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.
SELECTION-SCREEN POSITION 11. "숫자 알아서 잘 조절해야함.
SELECTION-SCREEN COMMENT (5) FOR FIELD P_R2.
SELECTION-SCREEN END OF LINE. " 한줄 여기서 끝!
SELECTION-SCREEN END OF BLOCK B2.

IF P_R1 = 'X'.
  WRITE :/ '학생 데이터 출력'.
ELSEIF P_R2 = 'X'.
  WRITE :/ '대학원 학생 데이터 출력'.
ENDIF.

DATA : BEGIN OF GS_STUDENT.
  INCLUDE TYPE ZEDT05_001.
DATA : END OF GS_STUDENT.
DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

PERFORM SELECT_DATA.
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
    WHERE ZCODE = P_ZCODE
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