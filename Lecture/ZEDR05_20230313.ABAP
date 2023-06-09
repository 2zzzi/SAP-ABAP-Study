*&---------------------------------------------------------------------*
*& Report ZEDR05_20230313
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230313.

*DATA : GV_NUM1 TYPE P VALUE '1234'.
*DATA : GV_NUM2 TYPE P DECIMALS 2 VALUE '12.34'.
*
*DATA : GV_NUM3 TYPE I VALUE 1234.
*
*DATA : GV_NUM4 TYPE N VALUE 1234.
*DATA : GV_NUM5 TYPE N LENGTH 2 VALUE 1234.
*DATA : GV_NUM6 TYPE N LENGTH 3 VALUE 1234.
*DATA : GV_NUM7 TYPE N LENGTH 4 VALUE 1234.
*
*    WRITE : GV_NUM1.
*    WRITE : / GV_NUM2.
*    WRITE : / GV_NUM3.
*    WRITE : / GV_NUM4.
*    WRITE : / GV_NUM5.
*    WRITE : / GV_NUM6.
*    WRITE : / GV_NUM7.
*
*
*DATA : GV_TEXT1 VALUE 'A'.
*DATA : GV_TEXT2 LENGTH 3 TYPE C VALUE 'ABC'.
*DATA : GV_TEXT3(5) TYPE C VALUE 'ABCDE'.
*DATA : GV_TEXT4 TYPE STRING VALUE 'ABCDE'.
*DATA : GV_LEN TYPE I.
*
*DATA : GV_TIME TYPE T.
*DATA : GV_DATE TYPE D.
*
*GV_TIME = SY-UZEIT.
*GV_DATE = SY-DATUM.
*GV_LEN = STRLEN( GV_TEXT3 ).
*
*WRITE : GV_TEXT1.
*WRITE : / GV_TEXT2.
*WRITE : / GV_TEXT3.
*WRITE : / GV_TEXT4.
*WRITE : / GV_LEN.
*WRITE : / GV_TIME.
*WRITE : / GV_DATE.



*DATA : TEXT1 TYPE STRING,
*      TEXT2(4) TYPE C.
*
*WRITE / 'SYS-SUBRC에 대한 실습 - ABAP에서 B를 찾으면 B를 리턴'.
*
*TEXT1 = 'ABAP'.
*TEXT2 = 'B'.
*
*FIND TEXT2 IN TEXT1.
*
*IF SY-SUBRC = 0.
*  WRITE / TEXT2.
*  ENDIF.
*
*WRITE / .
*WRITE / 'REPLACE - TEXT1을 TEXT2로 대체'.
*
*TEXT1 = 'ABAP'.
*TEXT2 = 'BBAP'.
*
*REPLACE TEXT1 IN TEXT1 WITH TEXT2.
*WRITE / TEXT1.
*
*WRITE / .
*WRITE / 'TRANSLATE - 대소문자 변경'.
*  TEXT1 = 'ABAP'.
*  TEXT2 = 'abap'.
*
*  TRANSLATE TEXT1 TO LOWER CASE.
*  TRANSLATE TEXT2 TO UPPER CASE.
*  WRITE / TEXT1.
*  WRITE / TEXT2.
*
*WRITE / .
*WRITE / 'SHIFT - 왼쪽으로 한자리 옮기기'.
*DATA TEXT3(5) TYPE C.
*  TEXT1 = ' ABAP'.
*  TEXT3 = ' ABAP'.
*
*  SHIFT TEXT1.
*  WRITE / TEXT1.
*  WRITE / TEXT3.
*
*WRITE / .
*WRITE / 'CONDENSE - 띄어쓰기 없애기'.
*  DATA : TEXT4 TYPE STRING,
*        TEXT5(8) TYPE C,
*        TEXT6(8) TYPE C.
*
*  TEXT4 = 'AB   AP'.
*  TEXT5 = 'AB   AP'.
*  TEXT6 = 'AB   AP'.
*
*  CONDENSE TEXT4.
*  CONDENSE TEXT5 NO-GAPS.
*
*  WRITE / TEXT4.
*  WRITE / TEXT5.
*  WRITE / TEXT6.
*
*
*WRITE / .
*WRITE / 'OVERLAY - CHAR 빈곳을 채우고 채워져있는 곳을 덮어쓰지 않음'.
*  DATA : TEXT7 TYPE STRING,
*        TEXT8(8) TYPE C.
*  TEXT7 = ' B P'.
*  TEXT8 = 'AAAA'.
*
*  OVERLAY TEXT7 WITH TEXT8.
*
*  WRITE / TEXT7.
*  WRITE / TEXT8.
*
*WRITE / .
*WRITE / 'CONCATENATE - 합쳐서 INTO 뒤의 변수로 '.
*  DATA : TEXT9 TYPE STRING,
*        TEXT10 LENGTH 4 TYPE C,
*        TEXT11 LENGTH 4 TYPE C.
*
*  TEXT9 = 'AB'.
*  TEXT10 = 'AP'.
*
*  CONCATENATE TEXT9 TEXT10 INTO TEXT11.
*
*  WRITE / TEXT9.
*  WRITE / TEXT10.
*  WRITE / TEXT11.
*
*
*WRITE / .
*WRITE / 'SPLIT - AT 00을 기준으로 나눠 INTO 뒤 두 변수에 삽입'.
*  TEXT9 = 'AB+AP'.
*  SPLIT TEXT9 AT '+' INTO TEXT10 TEXT11.
*
*  WRITE / TEXT9.
*  WRITE / TEXT10.
*  WRITE / TEXT11.

*WRITE / .
*WRITE / '18PAGE 연산자'.
*
*DATA : GV_NUM1 TYPE I VALUE 5,
*      GV_NUM2 TYPE I VALUE 3,
*      GV_NUM3 TYPE I .
*
*GV_NUM3 = GV_NUM1 + GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 - GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 * GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 / GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 DIV GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 MOD GV_NUM2.
*WRITE / GV_NUM3.
*
*GV_NUM3 = GV_NUM1 ** GV_NUM2.
*WRITE / GV_NUM3.


**TYPE 선언
*TYPES T_HELLO(20) TYPE C.
*
*DATA GV_TEXT1 TYPE T_HELLO.
*DATA GV_TEXT2 LIKE GV_TEXT1.
*
*GV_TEXT1 = '안녕하세요'.
*GV_TEXT2 = '반갑습니다'.
*
*WRITE / GV_TEXT1.
*WRITE / GV_TEXT2.
*


*"구조체 선언
*TYPES : BEGIN OF T_ZEDT05,
*  ZCODE TYPE C LENGTH 10,
*  ZKNAME TYPE C LENGTH 20,
*  ZENAME TYPE C LENGTH 20,
*  END OF T_ZEDT05.
*
*TYPES : BEGIN OF T_ZEDT05_02.
*  INCLUDE TYPE T_ZEDT05.
*  TYPES : TITLE TYPE C LENGTH 10,
*          GRADE TYPE C LENGTH 1,
*  END OF T_ZEDT05_02.
*
*DATA : GS_ZEDT05 TYPE T_ZEDT05_02.
*
*GS_ZEDT05-ZCODE = 'SSU-01'.
*GS_ZEDT05-ZKNAME = '강동원'.
*GS_ZEDT05-ZENAME = 'DONG'.
*GS_ZEDT05-TITLE = '경영학과'.
*GS_ZEDT05-GRADE = '3'.
*
*
*WRITE : / GS_ZEDT05-ZCODE.
*WRITE : / GS_ZEDT05-ZKNAME.
*WRITE : / GS_ZEDT05-ZENAME.
*WRITE : / GS_ZEDT05-TITLE.
*WRITE : / GS_ZEDT05-GRADE.

"구조체와 변수 선언을 함께
DATA : BEGIN OF GS_ZEDT05,
  ZCODE TYPE C LENGTH 10,
  ZKNAME TYPE C LENGTH 20,
  ZENAME TYPE C LENGTH 20,
  END OF GS_ZEDT05.

DATA : BEGIN OF GS_ZEDT05_02.
  INCLUDE STRUCTURE GS_ZEDT05.
  DATA : TITLE TYPE C LENGTH 10,
          GRADE TYPE C LENGTH 1,
  END OF GS_ZEDT05_02.

GS_ZEDT05_02-ZCODE = 'SSU-01'.
GS_ZEDT05_02-ZKNAME = '강동원'.
GS_ZEDT05_02-ZENAME = 'DONG'.
GS_ZEDT05_02-TITLE = '경영학과'.
GS_ZEDT05_02-GRADE = '3'.


WRITE : / GS_ZEDT05_02-ZCODE.
WRITE : / GS_ZEDT05_02-ZKNAME.
WRITE : / GS_ZEDT05_02-ZENAME.
WRITE : / GS_ZEDT05_02-TITLE.
WRITE : / GS_ZEDT05_02-GRADE.