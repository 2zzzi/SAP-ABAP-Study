*&---------------------------------------------------------------------*
*& Report ZEDR05_20230328
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230328.


**---------------------INTERNAL TABLE 정렬-------------------------------*
*"SORT : 인터널테이블내의 정이된 키값으로 정렬
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-03'.
*GS_STUDENT-ZKNAME = '송중기'.
*GS_STUDENT-ZENAME = 'SONG'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-04'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*BREAK-POINT.
*" 키값이 없으므로 구조체의 첫 필드인 ZCODE을 기준으로 디폴트 오름차순 정리
*SORT GT_STUDENT.
*BREAK-POINT.
*
*"ASCENDING : 오름차순. 1,2,3,4...
*SORT GT_STUDENT ASCENDING.
*BREAK-POINT.
*
*"DESCENDING : 내림차순 ...4,3,2,1
*SORT GT_STUDENT DESCENDING.
*BREAK-POINT.
*
*"ZKNAME을 기준으로 디폴트 오름차순 정리
*SORT GT_STUDENT BY ZKNAME.
*BREAK-POINT.
*
*"ZKNAME을 키값으로 내림차순
*SORT GT_STUDENT BY ZKNAME DESCENDING.
*BREAK-POINT.
*
*"ZKNAME으리 1차로 내림차순을 하되 같은 순위인 부분은 ZCODE로 내림차순 정리
*SORT GT_STUDENT BY ZKNAME ZCODE DESCENDING.
*BREAK-POINT.

*---------------------INTERNAL TABLE LINE 삽입------------------------------*

*"INSERT : 인터널테이블에 데이터 삽입.
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*CLEAR GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*INSERT GS_STUDENT INTO TABLE GT_STUDENT.
*
*CLEAR GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*"INDEX를 1로 설정, INDEX 설정시 INTO TABLE 이 아닌 INTO 만 적는다.
*INSERT GS_STUDENT INTO GT_STUDENT INDEX 1.
*
*CLEAR GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-03'.
*GS_STUDENT-ZKNAME = '송중기'.
*GS_STUDENT-ZENAME = 'SONG'.
*INSERT GS_STUDENT INTO TABLE GT_STUDENT.
*BREAK-POINT.

*"APPEND : 가장 마지막 라인에 삽입
*"APPEND는 INSERT와 다르게 INTO 가 아닌 TO를 통해 삽입한다.
*
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-03'.
*GS_STUDENT-ZKNAME = '송중기'.
*GS_STUDENT-ZENAME = 'SONG'.
*APPEND GS_STUDENT TO GT_STUDENT.
*BREAK-POINT.

*"COLLECT - 필드의 캐릭터값이 모두 같은 값이 있으면 숫자타입은 SUM 수행, 같은값이 없으면 데이터 추가
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZSUM TYPE I,
*  ZFLAG TYPE C,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZSUM = '10000'.
*GS_STUDENT-ZFLAG = 'M'.
*COLLECT GS_STUDENT INTO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZSUM = '10000'.
*GS_STUDENT-ZFLAG = 'M'.
*COLLECT GS_STUDENT INTO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZSUM = '10000'.
*GS_STUDENT-ZFLAG = 'M'.
*COLLECT GS_STUDENT INTO GT_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-03'.
*GS_STUDENT-ZKNAME = '송중기'.
*GS_STUDENT-ZENAME = 'SONG'.
*GS_STUDENT-ZFLAG = 'M'.
*COLLECT GS_STUDENT INTO GT_STUDENT.
*
*BREAK-POINT.

*----------------------Internal table 제어문-----------------------------*

*"if
*DATA : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZGUBUN TYPE C,
*  ZGNAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZGUBUN = 'F'.
*
*IF GS_STUDENT-ZGUBUN EQ 'M'.
*  GS_STUDENT-ZGNAME = '남자'.
*ELSEIF GS_STUDENT-ZGUBUN EQ 'F'.
*  GS_STUDENT-ZGNAME = '여자'.
*ELSE.
*  GS_STUDENT-ZGNAME ='기타'.
*ENDIF.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*BREAK-POINT.

*"if - AND - ENDIF
*DATA : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZGUBUN TYPE C,
*  ZGNAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZGUBUN = 'M'.
*
*IF ( GS_STUDENT-ZKNAME EQ '이제훈' ) AND ( GS_STUDENT-ZGUBUN EQ 'M' ).
*  GS_STUDENT-ZGNAME = '남자이제훈'.
*ENDIF.
*
*APPEND GS_STUDENT TO GT_STUDENT.
*
*BREAK-POINT.

*"if - OR - ENDIF
*DATA : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZGUBUN TYPE C,
*  ZGNAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZGUBUN = 'M'.
*
*IF ( GS_STUDENT-ZKNAME EQ '이제훈' ) OR ( GS_STUDENT-ZGUBUN EQ 'F' ).
*  GS_STUDENT-ZGNAME = 'ABAP'.
*ENDIF.
*
*APPEND GS_STUDENT TO GT_STUDENT.
*
*BREAK-POINT.

*------------------------실습-----------------------------*
"1번
DATA GV_NUM1 TYPE I VALUE 100.
DATA GV_NUM2 TYPE I VALUE 120.

WRITE : '**1번 - IF문에 WRITE문 출력'.
WRITE : / GV_NUM1.
WRITE : / GV_NUM2.

IF GV_NUM1 < GV_NUM2.
  WRITE : / 'GV_NUM1이 GV_NUM2보다 작습니다.'.
ENDIF.

"2번
DATA GV_NUM3 TYPE I VALUE 110.

WRITE : /.
WRITE : / '**2번 - IF문에 WRITE문 출력'.
WRITE : / GV_NUM1.
WRITE : / GV_NUM2.
WRITE : / GV_NUM3.
IF ( GV_NUM1 < GV_NUM2 ) AND ( GV_NUM1 < GV_NUM3 ).
  WRITE : / 'GV_NUM1이 GV_NUM2, GV_NUM3보다 작습니다.'.
ENDIF.

"3번
WRITE : /.
WRITE : / '**3번 - ELSE문에 WRITE문 출력'.
WRITE : / GV_NUM1.
WRITE : / GV_NUM2.
IF GV_NUM1 > GV_NUM2.
  WRITE : / 'GV_NUM1이 GV_NUM2보다 작습니다.'.
ELSE.
  WRITE : / 'GV_NUM2이 GV_NUM1보다 큽니다.'.
ENDIF.

"4번
WRITE : /.
WRITE : / '**4번 - NUM1, NUM2, NUM3 모든 변수를 사용하여 WRITE 문 출력'.
IF ( GV_NUM1 > GV_NUM2 ) AND ( GV_NUM1 > GV_NUM3 ).
  WRITE : /'GV_NUM1 이' .
  WRITE : GV_NUM1.
  WRITE : '가장 큰 수입니다.'.
ELSEIF ( GV_NUM2 > GV_NUM1 ) AND ( GV_NUM2 > GV_NUM3 ).
  WRITE : /'GV_NUM2 이' .
  WRITE : GV_NUM2.
  WRITE : '가장 큰 수입니다.'.
ELSEIF ( GV_NUM3 > GV_NUM1 ) AND ( GV_NUM3 > GV_NUM2 ).
  WRITE : /'GV_NUM3 이' .
  WRITE : GV_NUM3.
  WRITE : '가장 큰 수입니다.'.

ENDIF.