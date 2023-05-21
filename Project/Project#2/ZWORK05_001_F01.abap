*&---------------------------------------------------------------------*
*&  Include           ZWOKR05_001_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  TASK_RESULT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM TASK_RESULT1 .

  "select info1 and join info2
  SELECT A~MANDT
    A~ZEMPNO
    B~ZEMPNAME
    A~ZDEPTNR
    A~ZFRDATE
    A~ZTODATE
    A~ZRANKCODE
    A~ZEMPDATE
    A~ZRETDATE
    A~ZRETIRE_FG
    B~ZGENDER
    B~ZADDRESS
    A~ERNAM
    A~ERDAT
    A~DRZET
    A~AENAM
    A~AEDAT
    A~AEZET
    INTO CORRESPONDING FIELDS OF TABLE GT_RESULT1
    FROM ZWORK05_001_1_1 AS A
    LEFT OUTER JOIN ZWORK05_001_1_2 AS B
    ON A~ZEMPNO = B~ZEMPNO
    WHERE ZFRDATE <= S_ZDATE-LOW
    AND ZTODATE >= S_ZDATE-HIGH
    AND A~ZEMPNO IN S_ZEMPNO
    AND A~ZDEPTNR IN S_ZDEPT.

  "select salary1
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY1
    FROM ZWORK05_001_2 AS A
    WHERE ZEMPNO IN S_ZEMPNO.


  LOOP AT GT_RESULT1 INTO GS_RESULT1.

    "join result1 and salary1
    LOOP AT GT_SALARY1 INTO GS_SALARY1.
      IF GS_SALARY1-ZEMPNO EQ GS_RESULT1-ZEMPNO.
        GS_RESULT1-ZBANKNR = GS_SALARY1-ZBANKNR.
        GS_RESULT1-ZAMTNR = GS_SALARY1-ZAMTNR.

        MODIFY GT_RESULT1 FROM GS_RESULT1
          TRANSPORTING ZBANKNR ZAMTNR
          WHERE ZEMPNO = GS_RESULT1-ZEMPNO.
      ENDIF.
    ENDLOOP.

    "deptname modify
    CASE GS_RESULT1-ZDEPTNR.
      WHEN 'SS0001'.
        GS_RESULT1-ZDEPTNAME = '회계팀'.
      WHEN 'SS0002'.
        GS_RESULT1-ZDEPTNAME = '구매팀'.
      WHEN 'SS0003'.
        GS_RESULT1-ZDEPTNAME = '인사팀'.
      WHEN 'SS0004'.
        GS_RESULT1-ZDEPTNAME = '영업팀'.
      WHEN 'SS0005'.
        GS_RESULT1-ZDEPTNAME = '생산팀'.
      WHEN 'SS0006'.
        GS_RESULT1-ZDEPTNAME = '관리팀'.
    ENDCASE.

    "bankname modify
    CASE GS_RESULT1-ZBANKNR.
      WHEN '001'.
        GS_RESULT1-ZBANKNAME = '신한'.
      WHEN '002'.
        GS_RESULT1-ZBANKNAME = '우리'.
      WHEN '003'.
        GS_RESULT1-ZBANKNAME = '하나'.
      WHEN '004'.
        GS_RESULT1-ZBANKNAME = '국민'.
      WHEN '005'.
        GS_RESULT1-ZBANKNAME = '카카오'.
    ENDCASE.

    "rankname modify
    CASE GS_RESULT1-ZRANKCODE.
      WHEN 'A'.
        GS_RESULT1-ZRANKNAME = '인턴'.
      WHEN 'B'.
        GS_RESULT1-ZRANKNAME = '사원'.
      WHEN 'C'.
        GS_RESULT1-ZRANKNAME = '대리'.
      WHEN 'D'.
        GS_RESULT1-ZRANKNAME = '과장'.
      WHEN 'E'.
        GS_RESULT1-ZRANKNAME = '차장'.
      WHEN 'F'.
        GS_RESULT1-ZRANKNAME = '부장'.
      WHEN 'G'.
        GS_RESULT1-ZRANKNAME = '임원'.
    ENDCASE.

    "retire status modify
    IF GS_RESULT1-ZRETDATE NE '00000000'.
      IF GS_RESULT1-ZRETDATE < SY-DATUM.
        GS_RESULT1-ZRETIRE_FG = 'X'.
        MODIFY GT_RESULT1 FROM GS_RESULT1
        TRANSPORTING ZRETIRE_FG.
      ENDIF.
    ENDIF.

    CASE GS_RESULT1-ZRETIRE_FG.
      WHEN 'X'.
        GS_RESULT1-ZRETIRE_NAME = '퇴사'.
      WHEN OTHERS.
        GS_RESULT1-ZRETIRE_NAME = '재직'.
    ENDCASE.

    "modify all
    MODIFY GT_RESULT1 FROM GS_RESULT1
    TRANSPORTING ZDEPTNAME ZBANKNAME ZRANKNAME ZRETIRE_NAME
    WHERE ZEMPNO = GS_RESULT1-ZEMPNO.

    CLEAR : GS_RESULT1.
  ENDLOOP.

  DELETE GT_RESULT1 WHERE ZRETIRE_FG EQ P_FG.


ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_RESULT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_RESULT1 .

  WRITE : /,/,/.
  WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.
  WRITE :/ '|',(10)'사원번호' CENTERED,
          '|',(6)'이름' CENTERED,
          '|','부서코드' CENTERED,
          '|','부서명' CENTERED,
          '|','직급' CENTERED,
          '|',(13)'입사날짜' CENTERED,
          '|','퇴사상태' CENTERED,
          '|','성별' CENTERED,
          '|',(16)'주소' CENTERED,
          '|','은행코드' CENTERED,
          '|','은행명' CENTERED,
          '|',(20)'계좌번호' CENTERED ,'|'.
  WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.
  LOOP AT GT_RESULT1 INTO GS_RESULT1.
    "zempno converse Alpha
    GV_ZEMPNO = GS_RESULT1-ZEMPNO.
    CONCATENATE GS_RESULT1-ZEMPDATE(4) GS_RESULT1-ZEMPDATE+4(2) GS_RESULT1-ZEMPDATE+6(2) INTO GV_DPDATE SEPARATED BY '.'.
    "Print Report
    WRITE :/ '|', (10) GV_ZEMPNO CENTERED,
             '|', (6) GS_RESULT1-ZEMPNAME CENTERED,
             '|', (8) GS_RESULT1-ZDEPTNR CENTERED,
             '|', (6) GS_RESULT1-ZDEPTNAME CENTERED,
             '|', (4) GS_RESULT1-ZRANKNAME CENTERED,
             '|', (13) GV_DPDATE CENTERED,
             '|', (8) GS_RESULT1-ZRETIRE_NAME CENTERED,
             '|', (4) GS_RESULT1-ZGENDER CENTERED,
             '|', (16) GS_RESULT1-ZADDRESS CENTERED,
             '|', (8) GS_RESULT1-ZBANKNR CENTERED,
             '|', (6) GS_RESULT1-ZBANKNAME CENTERED,
             '|', GS_RESULT1-ZAMTNR CENTERED, '|'.
    WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TASK_RESULT2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM TASK_RESULT2 .
  "select info1 and join info2
  SELECT
    A~ZEMPNO
    B~ZEMPNAME
    A~ZDEPTNR
    A~ZFRDATE
    A~ZTODATE
    A~ZRANKCODE
    A~ZEMPDATE
    A~ZRETDATE
    A~ZRETIRE_FG
    INTO CORRESPONDING FIELDS OF TABLE GT_RESULT2
    FROM ZWORK05_001_1_1 AS A
    LEFT OUTER JOIN ZWORK05_001_1_2 AS B
    ON A~ZEMPNO = B~ZEMPNO
    WHERE ZFRDATE <= S_ZDATE-LOW
    AND ZTODATE >= S_ZDATE-HIGH
    AND A~ZEMPNO IN S_ZEMPNO.

  "select salary1
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY1
    FROM ZWORK05_001_2
    WHERE ZEMPNO IN S_ZEMPNO
    AND ZCONTYEAR = P_YEAR.

  "select eval
  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_EVAL
    FROM ZWORK05_001_3
    WHERE ZEMPNO IN S_ZEMPNO
    AND ZEVALYEAR = P_YEAR.

  SELECT *
    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY2
    FROM ZWORK05_001_4
    WHERE ZEMPNO IN S_ZEMPNO
    AND ZSALYEAR = P_YEAR.


  LOOP AT GT_RESULT2 INTO GS_RESULT2.

    LOOP AT GT_SALARY1 INTO GS_SALARY1.
      IF GS_RESULT2-ZEMPNO EQ GS_SALARY1-ZEMPNO.
        GS_RESULT2-ZCONTAMT = GS_SALARY1-ZCONTAMT.
      ENDIF.
    ENDLOOP.

    LOOP AT GT_EVAL INTO GS_EVAL.
      IF GS_RESULT2-ZEMPNO EQ GS_EVAL-ZEMPNO.
        GS_RESULT2-ZVALRANK = GS_EVAL-ZEVALRANK.
      ENDIF.
    ENDLOOP.

    LOOP AT GT_SALARY2 INTO GS_SALARY2.
      IF GS_RESULT2-ZEMPNO EQ GS_SALARY2-ZEMPNO.
        CASE P_MONTH.
          WHEN '01'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_01.
          WHEN '02'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_02.
          WHEN '03'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_03.
          WHEN '04'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_04.
          WHEN '05'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_05.
          WHEN '06'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_06.
          WHEN '07'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_07.
          WHEN '08'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_08.
          WHEN '09'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_09.
          WHEN '10'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_10.
          WHEN '11'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_11.
          WHEN '12'.
            GS_RESULT2-PAYOUT = GS_SALARY2-MONTH_12.
        ENDCASE.
      ENDIF.
    ENDLOOP.

    "rankname modify to wa
    CASE GS_RESULT2-ZRANKCODE.
      WHEN 'A'.
        GS_RESULT2-ZRANKNAME = '인턴'.
      WHEN 'B'.
        GS_RESULT2-ZRANKNAME = '사원'.
      WHEN 'C'.
        GS_RESULT2-ZRANKNAME = '대리'.
      WHEN 'D'.
        GS_RESULT2-ZRANKNAME = '과장'.
      WHEN 'E'.
        GS_RESULT2-ZRANKNAME = '차장'.
      WHEN 'F'.
        GS_RESULT2-ZRANKNAME = '부장'.
      WHEN 'G'.
        GS_RESULT2-ZRANKNAME = '임원'.
    ENDCASE.

    "retire status modify to wa
    IF GS_RESULT2-ZRETDATE NE '00000000'.
      IF GS_RESULT2-ZRETDATE < SY-DATUM.
        GS_RESULT2-ZRETIRE_FG = 'X'.
      ENDIF.
    ENDIF.

    CASE GS_RESULT2-ZRETIRE_FG.
      WHEN 'X'.
        GS_RESULT2-ZRETIRE_NAME = '퇴사'.
      WHEN OTHERS.
        GS_RESULT2-ZRETIRE_NAME = '재직'.
    ENDCASE.

    "modify to itab
    MODIFY GT_RESULT2 FROM GS_RESULT2 TRANSPORTING PAYOUT ZCONTAMT ZVALRANK ZRANKNAME ZRETIRE_FG ZRETIRE_NAME.

    CLEAR : GS_RESULT2.

  ENDLOOP.

  DELETE GT_RESULT2 WHERE ZRETIRE_FG EQ P_FG.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  CHECK_AUTHO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM CHECK_AUTHO .

  SELECT SINGLE *
    FROM ZWORK05_001_5
    INTO CORRESPONDING FIELDS OF GS_AUTHO
    WHERE ZID = SY-UNAME.

*  IF GS_AUTHO IS INITIAL.
*    MESSAGE I002.
*    EXIT.
*  ENDIF.

  IF GS_AUTHO-ZFRDATE <= SY-DATUM AND GS_AUTHO-ZTODATE >= SY-DATUM.
    IF GS_AUTHO-ZLEVEL1 = 'X'.
      GV_AUTHO_LEVEL1 = 'X'.
    ENDIF.

    IF GS_AUTHO-ZLEVEL2 = 'X'.
      GV_AUTHO_LEVEL2 = 'X'.
    ENDIF.

  ELSE.
    MESSAGE I003.
    EXIT.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_RESULT2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_RESULT2 .
  WRITE : /,/,/.
  WRITE :/ '----------------------------------------------------------------------------------------------------------------------'.
  WRITE :/ '|',(10)'사원번호' CENTERED,
          '|',(6)'이름' CENTERED,
          '|','부서코드' CENTERED,
          '|','직급' CENTERED,
          '|',(14)'입사날짜' CENTERED,
          '|','퇴사상태' CENTERED,
          '|',(16) '계약금액' CENTERED,
          '|','평가등급' CENTERED,
          '|',(16) '지급액(월)' CENTERED ,'|'.
  WRITE :/ '----------------------------------------------------------------------------------------------------------------------'.
  LOOP AT GT_RESULT2 INTO GS_RESULT2.
    CONCATENATE GS_RESULT2-ZEMPDATE(4) GS_RESULT2-ZEMPDATE+4(2) GS_RESULT2-ZEMPDATE+6(2) INTO GV_DPDATE SEPARATED BY '.'.
    GV_ZEMPNO = GS_RESULT2-ZEMPNO.

    GV_ZCAMT = GS_RESULT2-ZCONTAMT * C_KRWRATE.
    GV_ZPAMT = GS_RESULT2-PAYOUT * C_KRWRATE.

    WRITE :/ '|', GV_ZEMPNO CENTERED,
            '|', (6) GS_RESULT2-ZEMPNAME CENTERED,
            '|', (8) GS_RESULT2-ZDEPTNR CENTERED,
            '|', (4) GS_RESULT2-ZRANKNAME CENTERED,
            '|', (14) GV_DPDATE CENTERED,
            '|', (8) GS_RESULT2-ZRETIRE_NAME CENTERED,
            '|', (16) GV_ZCAMT CENTERED,
            '|', (8) GS_RESULT2-ZVALRANK CENTERED,
            '|', (16) GV_ZPAMT CENTERED, '|'.
    WRITE :/ '----------------------------------------------------------------------------------------------------------------------'.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  TASK_RESULT3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM TASK_RESULT3 .

  SELECT
    A~ZEMPNO
    B~ZEMPNAME
    A~ZDEPTNR
    A~ZEMPDATE
    A~ZRETDATE
    A~ZRETIRE_FG
  INTO CORRESPONDING FIELDS OF TABLE GT_RESULT3
  FROM ZWORK05_001_1_1 AS A
  LEFT OUTER JOIN ZWORK05_001_1_2 AS B
  ON A~ZEMPNO = B~ZEMPNO
  WHERE A~ZEMPNO IN S_ZEMPNO.

  "select contamt and zcontamt into gt_task3.
  SELECT A~ZEMPNO
    A~ZCONTAMT
    B~ZEVALRANK
    INTO CORRESPONDING FIELDS OF TABLE GT_TASK3
    FROM ZWORK05_001_2 AS A
    LEFT OUTER JOIN ZWORK05_001_3 AS B
    ON A~ZEMPNO = B~ZEMPNO
    WHERE A~ZEMPNO IN S_ZEMPNO
    AND ZCONTYEAR = P_YEAR.

  LOOP AT GT_RESULT3 INTO GS_RESULT3.

    IF GS_RESULT3-ZRETDATE NE '00000000'.
      IF GS_RESULT3-ZRETDATE < SY-DATUM.
        GS_RESULT2-ZRETIRE_FG = 'X'.
      ENDIF.
    ENDIF.

    LOOP AT GT_TASK3 INTO GS_TASK3.
      IF GS_RESULT3-ZEMPNO = GS_TASK3-ZEMPNO.
        CASE GS_TASK3-ZEVALRANK.
          WHEN 'A'.
            GV_SPOINT = '1000'.
          WHEN 'B'.
            GV_SPOINT = '500'.
          WHEN OTHERS.
            GV_SPOINT = '0'.
        ENDCASE.

        GS_RESULT3-ZPAMT = ( GS_TASK3-ZCONTAMT / 12 ) + GV_SPOINT.

        CASE P_MONTH.
          WHEN '01'.
            UPDATE ZWORK05_001_4
            SET MONTH_01 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '02'.
            UPDATE ZWORK05_001_4
            SET MONTH_02 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '03'.
            UPDATE ZWORK05_001_4
            SET MONTH_03 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '04'.
            UPDATE ZWORK05_001_4
            SET MONTH_04 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '05'.
            UPDATE ZWORK05_001_4
            SET MONTH_05 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '06'.
            UPDATE ZWORK05_001_4
            SET MONTH_06 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '07'.
            UPDATE ZWORK05_001_4
            SET MONTH_07 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '08'.
            UPDATE ZWORK05_001_4
            SET MONTH_08 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '09'.
            UPDATE ZWORK05_001_4
            SET MONTH_09 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '10'.
            UPDATE ZWORK05_001_4
            SET MONTH_10 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '11'.
            UPDATE ZWORK05_001_4
            SET MONTH_11 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
          WHEN '12'.
            UPDATE ZWORK05_001_4
            SET MONTH_12 = GS_RESULT3-ZPAMT
                AENAM = SY-UNAME
                AEDAT = SY-DATUM
                AEZET = SY-UZEIT
            WHERE ZEMPNO = GS_RESULT3-ZEMPNO.
        ENDCASE.

        GS_RESULT3-ZFLAG = 'X'.
        MODIFY GT_RESULT3 FROM GS_RESULT3 TRANSPORTING ZPAMT ZFLAG.

      ENDIF.

    ENDLOOP.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DISPLAY_RESULT3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DISPLAY_RESULT3 .

  WRITE : /,/,/.
  WRITE :/ '----------------------------------------------------------------'.
  WRITE :/ '|',(10)'사원번호' CENTERED,
          '|',(6)'이름' CENTERED,
          '|','부서코드' CENTERED,
          '|',(16) '지급액(월)' CENTERED,
          '|', '지급처리' CENTERED , '|'.
  WRITE :/ '----------------------------------------------------------------'.
  LOOP AT GT_RESULT3 INTO GS_RESULT3.
    GV_ZEMPNO = GS_RESULT3-ZEMPNO.
    GV_ZPAMT = GS_RESULT3-ZPAMT * C_KRWRATE.

    WRITE :/ '|', GV_ZEMPNO CENTERED,
            '|', (6) GS_RESULT3-ZEMPNAME CENTERED,
            '|', (8) GS_RESULT3-ZDEPTNR CENTERED,
            '|', (16) GV_ZPAMT CENTERED,
            '|', (8) GS_RESULT3-ZFLAG CENTERED ,'|'.
    WRITE :/ '----------------------------------------------------------------'.

  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_RESULT1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ALV_RESULT1 .

  PERFORM TASK_RESULT1.
  PERFORM FIELD_CATALOG1.
  IF GT_RESULT1[] IS INITIAL.
    MESSAGE I001.
    EXIT.
  ELSE.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        IT_FIELDCAT = GT_FIELDCAT
      TABLES
        T_OUTTAB    = GT_RESULT1.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG1 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SELTEXT_M = '사원번호'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNAME'.
  GS_FIELDCAT-SELTEXT_M = '이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNR'.
  GS_FIELDCAT-SELTEXT_M = '부서코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNAME'.
  GS_FIELDCAT-SELTEXT_M = '부서명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZRANKNAME'.
  GS_FIELDCAT-SELTEXT_M = '직급'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZEMPDATE'.
  GS_FIELDCAT-SELTEXT_M = '입사일자'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZRETIRE_NAME'.
  GS_FIELDCAT-SELTEXT_M = '퇴사상태'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 8.
  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.
  GS_FIELDCAT-SELTEXT_M = '성별'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 9.
  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.
  GS_FIELDCAT-SELTEXT_M = '주소'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 10.
  GS_FIELDCAT-FIELDNAME = 'ZBANKNR'.
  GS_FIELDCAT-SELTEXT_M = '은행코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 11.
  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.
  GS_FIELDCAT-SELTEXT_M = '은행명'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 12.
  GS_FIELDCAT-FIELDNAME = 'ZAMTNR'.
  GS_FIELDCAT-SELTEXT_M = '계좌번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.



ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_RESULT2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ALV_RESULT2 .

  PERFORM TASK_RESULT2.
  PERFORM FIELD_CATALOG2.
  IF GT_RESULT2[] IS INITIAL.
    MESSAGE I001.
    EXIT.
  ELSE.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        IT_FIELDCAT = GT_FIELDCAT
      TABLES
        T_OUTTAB    = GT_RESULT2.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG2
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG2 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SELTEXT_M = '사원번호'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNAME'.
  GS_FIELDCAT-SELTEXT_M = '이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNR'.
  GS_FIELDCAT-SELTEXT_M = '부서코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZRANKNAME'.
  GS_FIELDCAT-SELTEXT_M = '직급'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZEMPDATE'.
  GS_FIELDCAT-SELTEXT_M = '입사일자'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZRETIRE_NAME'.
  GS_FIELDCAT-SELTEXT_M = '퇴사상태'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZCONTAMT'.
  GS_FIELDCAT-SELTEXT_M = '계약금액'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 8.
  GS_FIELDCAT-FIELDNAME = 'ZVALRANK'.
  GS_FIELDCAT-SELTEXT_M = '평가등급'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 9.
  GS_FIELDCAT-FIELDNAME = 'PAYOUT'.
  GS_FIELDCAT-SELTEXT_M = '지급액(월)'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_RESULT3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM ALV_RESULT3 .

  PERFORM TASK_RESULT3.
  PERFORM FIELD_CATALOG3.
  IF GT_RESULT3[] IS INITIAL.
    MESSAGE I001.
    EXIT.
  ELSE.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        IT_FIELDCAT = GT_FIELDCAT
      TABLES
        T_OUTTAB    = GT_RESULT3.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM FIELD_CATALOG3 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNO'.
  GS_FIELDCAT-SELTEXT_M = '사원번호'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZEMPNAME'.
  GS_FIELDCAT-SELTEXT_M = '이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZDEPTNR'.
  GS_FIELDCAT-SELTEXT_M = '부서코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZPAMT'.
  GS_FIELDCAT-SELTEXT_M = '지급액(월)'.
  GS_FIELDCAT-CURRENCY = 'KRW'.
  GS_FIELDCAT-OUTPUTLEN = 15.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZFLAG'.
  GS_FIELDCAT-SELTEXT_M = '지급처리'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.