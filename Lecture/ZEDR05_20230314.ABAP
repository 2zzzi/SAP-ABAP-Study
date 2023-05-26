*&---------------------------------------------------------------------*
*& Report ZEDR05_20230314
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zedr05_20230314.

**1번 실습
*data : gs_sflight type sflight.
*
*select single * from sflight
*  into gs_sflight
*  where carrid = 'AA'
*  and connid = '0017'.
*
*write gs_sflight-carrid.
*write / gs_sflight-connid.
*write / gs_sflight-fldate.
*write / gs_sflight-currency.
*
**2번 실습
*data : gv_carrid   type sflight-carrid,
*       gv_connid   type sflight-connid,
*       gv_fldate   type sflight-fldate,
*       gv_currency type sflight-currency.
*
*gv_carrid = 'AA'.
*gv_connid = '0017'.
*gv_fldate = sy-datum.
*gv_currency = 'USD'.
*
*write / gv_carrid.
*write / gv_connid.
*write / gv_fldate.
*write / gv_currency.
*
*3번 실습
*data : gs_zeds05_001 type zeds05_001.
*
*gs_zeds05_001-zcode = 'SSU-01'.
*gs_zeds05_001-zkname = '강동원'.
*gs_zeds05_001-zename = 'DONG'.
*gs_zeds05_001-zgubun = 'M'.
*
*write / gs_zeds05_001-zcode.
*write / gs_zeds05_001-zkname.
*write / gs_zeds05_001-zename.
*write / gs_zeds05_001-zgubun.

DATA : GV_ZED05 TYPE ZTG05_ZED05.
DATA : GV_TITLE TYPE ZTG05_TITLE.

GV_ZED05-ZCODE = 'SSU-01'.
GV_ZED05-ZKNAME = '강동원'.
GV_ZED05-ZENAME = 'DONG'.
GV_ZED05-ZGUBUN = 'M'.

GV_TITLE = '경영학과'.

WRITE :/ GV_ZED05-ZCODE.
WRITE :/ GV_ZED05-ZKNAME.
WRITE :/ GV_ZED05-ZENAME.
WRITE :/ GV_ZED05-ZGUBUN.
WRITE :/ GV_TITLE.