*&---------------------------------------------------------------------*
*&  Include           ZWORK05_001_TOP
*&---------------------------------------------------------------------*

DATA : GS_INFO1 TYPE ZWORK05_001_1_1.
DATA : GT_INFO1 LIKE TABLE OF GS_INFO1.

DATA : GS_INFO2 TYPE ZWORK05_001_1_2.
DATA : GT_INFO2 LIKE TABLE OF GS_INFO2.

DATA : GS_SALARY1 TYPE ZWORK05_001_2.
DATA : GT_SALARY1 LIKE TABLE OF GS_SALARY1.

DATA : GS_EVAL TYPE ZWORK05_001_3.
DATA : GT_EVAL LIKE TABLE OF GS_EVAL.

DATA : GS_SALARY2 TYPE ZWORK05_001_4.
DATA : GT_SALARY2 LIKE TABLE OF GS_SALARY2.

DATA : GS_AUTHO TYPE ZWORK05_001_5.
DATA : GT_AUTHO LIKE TABLE OF GS_AUTHO.

DATA : BEGIN OF GS_RESULT1.
    INCLUDE TYPE ZWORK05_001_1_1.
DATA : ZEMPNAME     LIKE GS_INFO2-ZEMPNAME,
       ZDEPTNAME    TYPE ZWORK05_001_S1-ZDEPTNAME,
       ZRANKNAME    TYPE ZWORK05_001_S3-ZRANKNAME,
       ZRETIRE_NAME TYPE ZWORK05_001_S2-ZRETIRE_NAME,
       ZGENDER      LIKE GS_INFO2-ZGENDER,
       ZADDRESS     LIKE GS_INFO2-ZADDRESS,
       ZBANKNR      LIKE GS_SALARY1-ZBANKNR,
       ZBANKNAME    TYPE ZWORK05_001_S4-ZBANKNAME,
       ZAMTNR       LIKE GS_SALARY1-ZAMTNR,
       END OF GS_RESULT1.
DATA : GT_RESULT1 LIKE TABLE OF GS_RESULT1.

DATA : GV_ZEMPNO TYPE C LENGTH 10.
DATA : GV_DPDATE TYPE C LENGTH 11.

DATA : BEGIN OF GS_RESULT2,
         ZEMPNO       LIKE GS_INFO1-ZEMPNO,
         ZEMPNAME     LIKE GS_INFO2-ZEMPNAME,
         ZDEPTNR      LIKE GS_INFO1-ZDEPTNR,
         ZFRDATE      LIKE GS_INFO1-ZFRDATE,
         ZTODATE      LIKE GS_INFO1-ZTODATE,
         ZRANKCODE    LIKE GS_INFO1-ZRANKCODE,
         ZRANKNAME    TYPE ZWORK05_001_S3-ZRANKNAME,
         ZEMPDATE     LIKE GS_INFO1-ZEMPDATE,
         ZRETDATE     LIKE GS_INFO1-ZRETDATE,
         ZRETIRE_FG   LIKE GS_INFO1-ZRETIRE_FG,
         ZRETIRE_NAME TYPE ZWORK05_001_S2-ZRETIRE_NAME,
         ZCONTAMT     LIKE GS_SALARY1-ZCONTAMT,
         ZVALRANK     LIKE GS_EVAL-ZEVALRANK,
         PAYOUT       LIKE GS_SALARY1-ZCONTAMT,
       END OF GS_RESULT2.
DATA : GT_RESULT2 LIKE TABLE OF GS_RESULT2.

DATA : BEGIN OF GS_RESULT3,
         ZEMPNO     LIKE GS_INFO1-ZEMPNO,
         ZEMPNAME   LIKE GS_INFO2-ZEMPNAME,
         ZDEPTNR    LIKE GS_INFO1-ZDEPTNR,
         ZEMPDATE   LIKE GS_INFO1-ZEMPDATE,
         ZRETDATE   LIKE GS_INFO1-ZRETDATE,
         ZRETIRE_FG LIKE GS_INFO1-ZRETIRE_FG,
         ZPAMT      LIKE GS_SALARY1-ZCONTAMT,
         ZFLAG      TYPE C,
       END OF GS_RESULT3.
DATA : GT_RESULT3 LIKE TABLE OF GS_RESULT3.

DATA : BEGIN OF GS_TASK3,
         ZEMPNO    LIKE GS_INFO1-ZEMPNO,
         ZCONTAMT  LIKE GS_SALARY1-ZCONTAMT,
         ZEVALRANK LIKE GS_EVAL-ZEVALRANK,
       END OF GS_TASK3.
DATA : GT_TASK3 LIKE TABLE OF GS_TASK3.

DATA : GV_ZFRDATE TYPE DATUM,
       GV_ZTODATE TYPE DATUM.

DATA : GV_AUTHO_LEVEL1(1),
       GV_AUTHO_LEVEL2(2).

CONSTANTS : C_KRWRATE TYPE I VALUE '100'.

DATA : GV_ZCAMT TYPE P LENGTH 15,
       GV_ZPAMT TYPE P LENGTH 15.

DATA : GV_SPOINT TYPE I.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,
       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.