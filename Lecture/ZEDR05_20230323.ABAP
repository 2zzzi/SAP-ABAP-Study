*&---------------------------------------------------------------------*
*& Report ZEDR05_20230323
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230323.

*구조체를 선언한 후 인터널테이블 선언---------------------------------------*
DATA : GS_STUDENT TYPE ZEDT05_001. "구조체 선언
DATA : GT_STUDENT like table of gs_student. "인터널 테이블 선언

"헤더에 데이터 추가
GS_STUDENT-ZCODE = 'SSU-01'.
Gs_STUDENT-ZPERNR = '0000000001'.
Gs_STUDENT-ZKNAME = '이지훈'.
Gs_STUDENT-ZENAME = 'LEE'.
Gs_STUDENT-ZGUBUN = 'M'.
Gs_STUDENT-ZTEL = '010-0000-0000'.

"인터널테이블에 적재
APPEND GS_STUDENT TO GT_STUDENT.

BREAK-POINT.
*
*"헤더에 데이터 추가
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZPERNR = '0000000002'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'M'.
*GS_STUDENT-ZTEL = '010-0000-0001'.
*
*"인터널테이블에 적재
*APPEND GS_STUDENT TO GT_STUDENT.
*
*BREAK-POINT.

**구조체와 인터널테이블 함께 선언하기---------------------------------*
**DATA : GT_STUDENT TYPE ZEDT05_001 OCCURS 0 WITH HEADER LINE.
**DATA : GT_STUDENT LIKE ZEDT05_001 OCCURS 0 WITH HEADER LINE.
**DATA : GT_STUDENT TYPE TABLE OF ZEDT05_001 WITH HEADER LINE.
*DATA : GT_STUDENT LIKE TABLE OF ZEDT05_001 WITH HEADER LINE.
*
*
*"헤더에 데이터 추가
*GT_STUDENT-ZCODE = 'SSU-01'.
*GT_STUDENT-ZPERNR = '0000000001'.
*GT_STUDENT-ZKNAME = '이지훈'.
*GT_STUDENT-ZENAME = 'LEE'.
*GT_STUDENT-ZGUBUN = 'M'.
*GT_STUDENT-ZTEL = '010-0000-0000'.
*
*APPEND GT_STUDENT.
*
*GT_STUDENT-ZCODE = 'SSU-02'.
*GT_STUDENT-ZPERNR = '0000000002'.
*GT_STUDENT-ZKNAME = '강동원'.
*GT_STUDENT-ZENAME = 'DONG'.
*GT_STUDENT-ZGUBUN = 'M'.
*GT_STUDENT-ZTEL = '010-0000-0001'.
*
*APPEND GT_STUDENT.
*
*BREAK-POINT.

**-------------------------로컬테이블을 이용한 인터널테이블 생성----------------------*
**-------------------------TYPES을 통한 구조체 선언 후 인터널테이블 생성-----------------*
*TYPES : BEGIN OF S_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF S_STUDENT.
*
*DATA : GT_STUDENT TYPE STANDARD TABLE OF S_STUDENT WITH HEADER LINE.
*
*GT_STUDENT-ZCODE = 'SSU-01'.
*GT_STUDENT-ZKNAME = '이지훈'.
*GT_STUDENT-ZENAME = 'LEE'.
*
*APPEND GT_STUDENT.
*
*BREAK-POINT.

***-------------------------로컬테이블 데이터를 이용한 인터널테이블 생성----------------------*
*DATA : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE STANDARD TABLE OF GS_STUDENT WITH HEADER LINE.
*
*GT_STUDENT-ZCODE = 'SSU-01'.
*GT_STUDENT-ZKNAME = '이지훈'.
*GT_STUDENT-ZENAME = 'LEE'.
*
*BREAK-POINT.
*
*APPEND GT_STUDENT.
*
*BREAK-POINT.

****------------------------Global ABAP Dictionary Type을 이용한 인터널테이블 생성----------------------*
*DATA : GT_SCARR TYPE TABLE OF SCARR.
*DATA : GS_SCARR LIKE LINE OF GT_SCARR.
*
*GS_SCARR-CARRID ='AA'.
*GS_SCARR-CARRNAME = 'AMERICAN AIR'.
*
*BREAK-POINT.
*
*APPEND GS_SCARR TO GT_SCARR.
*
*BREAK-POINT.

***------------------------헤더 라인이 기본으로 포함된 인터널테이블 생성----------------------*
*DATA : BEGIN OF GT_STUDENT OCCURS 0,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*END OF GT_STUDENT.
*
*BREAK-POINT.
*
*GT_STUDENT-ZCODE = 'SSU-01'.
*GT_STUDENT-ZKNAME = '이지훈'.
*GT_STUDENT-ZENAME = 'LEE'.
*
*BREAK-POINT.
*
*APPEND GT_STUDENT.
*
*BREAK-POINT.