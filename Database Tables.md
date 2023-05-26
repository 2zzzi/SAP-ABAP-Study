# Database Tables

---

## ZEDT05_001

### 학생정보 데이터

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZCODE | X | X | ZCODE05 | CHAR | 10 | 학생코드 |
| ZPERNR | X | X | ZPERNR05 | CHAR | 10 | 출석번호 |
| ZKNAME |  |  | ZKNAME05 | CHAR | 20 | 국문 이름 |
| ZENAME |  |  | ZENAME05 | CHAR | 20 | 영문 이름 |
| ZGUBUN |  |  | ZGUBUN05 | CHAR | 1 | 성별 |
| ZTEL |  |  | ZTEL05 | CHAR | 16 | 전화번호 |

## ZEDT05_002

입학정보 데이터

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZCODE | X | X | ZCODE05 | CHAR | 10 | 학생코드 |
| ZPERNR | X | X | ZPERNR05 | CHAR | 10 | 출석번호 |
| ZMAJOR |  |  | ZMAJOR05 | CHAR | 1 | 전공 |
| ZMNAME |  |  | ZMNAME05 | CHAR | 20 | 전공 명 |
| ZSUM |  |  | ZSUM05 | CURR | 13 | 입학 등록금 |
| ZWAERS |  |  | WAERS | CUKY | 5 | Currency Key |
| ZFLAG |  |  |  | CHAR | 1 | 장학여부 |

## ZEDT05_003

### Search Help 성별

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZGUBUN | X | X | ZGUBUN05 | CHAR | 1 | 성별 |
| ZGUBUN_NAME |  |  | ZKNAME05 | CHAR | 20 | 국문 이름 |

## ZEDT05_004

주문관리 데이터

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZORDNO | X | X | ZORDNO05 | CHAR | 10 | 주문번호 |
| ZID | X | X | ZID05 | CHAR | 10 | 회원 아이디 |
| ZMATNR | X | X | ZMATNR05 | CHAR | 10 | 제품번호 |
| ZMTART |  |  | ZMTART05 | CHAR | 3 | 제품 유형 |
| ZMATNAME |  |  | ZMATNAME05 | CHAR | 20 | 제품 명 |
| ZVOLUM |  |  | ZVOLUM05 | CHAR | 3 | 수량 |
| VRKME |  |  | VRKME | UNIT | 3 | Sales Unit |
| ZNSAMT |  |  | ZNSAMT05 | CURR | 13 | 판매금액 |
| ZSLAMT |  |  | ZSLAMT05 | CURR | 13 | 매출 금액 |
| ZDCAMT |  |  | ZDCAMT05 | CURR | 13 | 할인 금액 |
| ZDC_FG |  |  | ZDC_FG05 | CHAR | 1 | 할인 구분 |
| ZSALE_FG |  |  | ZSALE_FG05 | CHAR | 1 | 매출 구분 |
| ZRET_FG |  |  | ZRET_FG05 | CHAR | 1 | 반품구분 |
| ZJDATE |  |  | ZJDATE05 | DATS | 8 | 판매 일자 |
| ZRDATE |  |  | ZRDATE05 | DATS | 8 | 반품 일자 |

## ZEDT05_005

주문관리 데이터

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZORDNO | X | X | ZORDNO05 | CHAR | 10 | 주문번호 |
| ZID | X | X | ZID05 | CHAR | 10 | 회원 아이디 |
| ZMATNR | X | X | ZMATNR05 | CHAR | 10 | 제품번호 |
| ZMTART |  |  | ZMTART05 | CHAR | 3 | 제품 유형 |
| ZMATNAME |  |  | ZMATNAME05 | CHAR | 20 | 제품 명 |
| ZVOLUM |  |  | ZVOLUM05 | CHAR | 3 | 수량 |
| VRKME |  |  | VRKME | UNIT | 3 | Sales Unit |
| ZSLAMT |  |  | ZSLAMT05 | CURR | 13 | 매출 금액 |
| ZDFLAG |  |  | ZDFLAG05 | CHAR | 1 | 배송현황 |
| ZDGUBUN |  |  | ZDGUBUN05 | CHAR | 2 | 배송 지역 |
| ZDDATE |  |  | ZDDATE05 | DATS | 8 | 배송 일자 |
| ZRDATE |  |  | ZRDATE05 | DATS | 8 | 반품 일자 |
| ZFLAG |  |  |  | CHAR | 1 | 반품 처리 |

## ZEDT05_006

### Search Help 지역 구분

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZDGUBUN | X | X | ZDGUBUN05 | CHAR | 1 | 배송지역 |
| ZDGUBUN_NAME |  |  | ZDGUBUNNAME05 | CHAR | 10 | 지역명 |

## ZEDT05_007

### 성적 관리 테이블

| Field | key | Inital Values | Data element | Data Type | length | Short description |
| --- | --- | --- | --- | --- | --- | --- |
| MANDT | X | X | MANDT | CLNT | 3 | CLIENT |
| ZCODE | X | X | ZCODE05 | CHAR | 10 | 학생코드 |
| ZPERNR | X | X | ZPERNR05 | CHAR | 10 | 출석번호 |
| ZSCHOOL | X | X | ZSCHOOL05 | CHAR | 1 | 학적구분 |
| ZSEM | X | X | ZSEM05 | CHAR | 1 | 학기구분 |
| ZEXAM | X | X | ZEXAM05 | CHAR | 1 | 시험구분 |
| ZMAJOR |  |  | ZMAJOR05 | CHAR | 1 | 전공 |
| ZMNAME |  |  | ZMNAME05 | CHAR | 20 | 전공 명 |
| ZSUM |  |  | ZSUM05 | CURR | 13 | 입학 등록금 |
| ZGRADE |  |  | ZGRADE05 | CHAR | 1 | 성적 |
| ZEGUBUN |  |  | ZEGUBUN05 | CHAR | 1 | 장학 구분 |
| ZAMOUNT |  |  | ZAMOUNT05 | CURR | 13 | 납부 액 |