*&---------------------------------------------------------------------*
*& Report ZEDR05_20230404
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230404.

**"1,2번 테이블
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZGUBUN TYPE C,
*  ZGNAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'M'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZGUBUN = 'M'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-03'.
*GS_STUDENT-ZKNAME = '손예진'.
*GS_STUDENT-ZENAME = 'SON'.
*GS_STUDENT-ZGUBUN = 'F'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR GS_STUDENT.
*
*"1. AT FIRST
*LOOP AT GT_STUDENT INTO GS_STUDENT.
*  GS_STUDENT-ZGNAME = '성별구분'.
*
*  AT FIRST.
*
*    BREAK-POINT.
*
*    GS_STUDENT-ZGNAME = '변경사항'.
*    MODIFY GT_STUDENT FROM GS_STUDENT TRANSPORTING ZGNAME WHERE ZCODE = GS_STUDENT-ZCODE.
*  ENDAT.
*
*  BREAK-POINT.
*
*  CLEAR GS_STUDENT.
*ENDLOOP.

*"2. AT LAST
*LOOP AT GT_STUDENT INTO GS_STUDENT.
*  GS_STUDENT-ZGNAME = '성별구분'.
*
*  BREAK-POINT.
*
*  AT LAST.
*
*  BREAK-POINT.
*
*    GS_STUDENT-ZGNAME = '변경사항'.
*
*  BREAK-POINT.
*  ENDAT.
*
*  BREAK-POINT.
*
*  CLEAR GS_STUDENT.
*
*ENDLOOP.

*"3,4번 테이블
*data : BEGIN OF GS_STUDENT,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 10,
*  ZENAME TYPE C LENGTH 10,
*  ZGUBUN TYPE C,
*  ZGNAME TYPE C LENGTH 10,
*END OF GS_STUDENT.
*
*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'M'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'F'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'A'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-02'.
*GS_STUDENT-ZKNAME = '이제훈'.
*GS_STUDENT-ZENAME = 'LEE'.
*GS_STUDENT-ZGUBUN = 'M'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동원'.
*GS_STUDENT-ZENAME = 'KANG'.
*GS_STUDENT-ZGUBUN = 'M'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*CLEAR : GS_STUDENT.
*GS_STUDENT-ZCODE = 'SSU-01'.
*GS_STUDENT-ZKNAME = '강동동'.
*GS_STUDENT-ZENAME = 'DONG'.
*GS_STUDENT-ZGUBUN = 'F'.
*APPEND GS_STUDENT TO GT_STUDENT.
*
*
*SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGUBUN.
*CLEAR GS_STUDENT.

"3. AT NEW FIELD - 필드의 새로운 값이 들어올 때 수행
*LOOP AT GT_STUDENT INTO GS_STUDENT.
*
*  BREAK-POINT.
*
*  GS_STUDENT-ZGNAME = '성별구분'.
*
*  AT NEW ZENAME.
*
*    BREAK-POINT.
*
*    GS_STUDENT-ZGNAME = '변경사항'.
*
*    BREAK-POINT.
*
*  ENDAT.
*
*  BREAK-POINT.
*
*  CLEAR GS_STUDENT.
*
*ENDLOOP.

*"4. AT END OF FIELD
*LOOP AT   GT_STUDENT INTO GS_STUDENT.
*  GS_STUDENT-ZGNAME = '성별구분'.
*
*  AT END OF ZENAME.
*    GS_STUDENT-ZGNAME = '변경사항'.
*  ENDAT.
*
*  CLEAR GS_STUDENT.
*
*ENDLOOP.


data : BEGIN OF GS_STUDENT,
  ZCODE TYPE C LENGTH 10,
  ZKNAME TYPE C LENGTH 10,
  ZENAME TYPE C LENGTH 10,
  ZGUBUN TYPE C,
  ZGNAME TYPE C LENGTH 10,
END OF GS_STUDENT.

DATA : GS_STUDENT2 LIKE GS_STUDENT.
DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

CLEAR : GS_STUDENT.
GS_STUDENT-ZCODE = 'SSU-01'.
GS_STUDENT-ZKNAME = '강동원'.
GS_STUDENT-ZENAME = 'DONG'.
GS_STUDENT-ZGUBUN = 'M'.
APPEND GS_STUDENT TO GT_STUDENT.

CLEAR : GS_STUDENT.
GS_STUDENT-ZCODE = 'SSU-02'.
GS_STUDENT-ZKNAME = '이제훈'.
GS_STUDENT-ZENAME = 'LEE'.
GS_STUDENT-ZGUBUN = 'M'.
APPEND GS_STUDENT TO GT_STUDENT.

CLEAR : GS_STUDENT.
GS_STUDENT-ZCODE = 'SSU-03'.
GS_STUDENT-ZKNAME = '손예진'.
GS_STUDENT-ZENAME = 'SON'.
GS_STUDENT-ZGUBUN = 'F'.
APPEND GS_STUDENT TO GT_STUDENT.

CLEAR GS_STUDENT.

"1. AT FIRST
LOOP AT GT_STUDENT INTO GS_STUDENT.

  MOVE-CORRESPONDING GS_STUDENT TO GS_STUDENT2.
  GS_STUDENT2-ZGNAME = '성별구분'.
  MODIFY GT_STUDENT FROM GS_STUDENT2 INDEX SY-TABIX.
  AT FIRST.

    BREAK-POINT.

    GS_STUDENT2-ZGNAME = '변경사항'.
    MODIFY GT_STUDENT FROM GS_STUDENT2 INDEX SY-TABIX.
  ENDAT.

  BREAK-POINT.

  CLEAR GS_STUDENT.
ENDLOOP.