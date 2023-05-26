*&---------------------------------------------------------------------*
*& Report ZEDR05_20230501
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEDR05_20230501 MESSAGE-ID ZMED05.

*DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.
*DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.
*
*DATA : BEGIN OF GT_SFLIGHT OCCURS 0,
*         CARRID LIKE SFLIGHT-CARRID,
*         CONNID LIKE SFLIGHT-CONNID,
*         FLDATE LIKE SFLIGHT-FLDATE,
*         PRICE  LIKE SFLIGHT-PRICE,
*       END OF GT_SFLIGHT.
*
*SELECT  CARRID
*        CONNID
*        FLDATE
*        PRICE
*  FROM SFLIGHT
*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT.
*
*CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*  EXPORTING
*    I_PROGRAM_NAME       = SY-REPID
*    I_INTERNAL_TABNAME = 'GT_SFLIGHT'
*    I_INCLNAME           = SY-REPID
*  CHANGING
*    CT_FIELDCAT          = GT_FIELDCAT.
*
*CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*  EXPORTING
*    IT_FIELDCAT = GT_FIELDCAT
*  TABLES
*    T_OUTTAB    = GT_SFLIGHT.


TABLES : ZEDT05_001.

DATA : BEGIN OF GS_STUDENT,
*  CHECKBOX TYPE C,
         COLOR  TYPE C LENGTH 4,
         ZCODE  LIKE ZEDT05_001-ZCODE,
         ZPERNR LIKE ZEDT05_001-ZPERNR,
         ZKNAME LIKE ZEDT05_001-ZKNAME,
         ZENAME LIKE ZEDT05_001-ZENAME,
         ZGUBUN LIKE ZEDT05_001-ZGUBUN,
         ZTEL   LIKE ZEDT05_001-ZTEL,
       END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.
DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.
SELECT-OPTIONS : S_ZCODE FOR ZEDT05_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99'.
SELECT-OPTIONS : S_ZPERNR FOR ZEDT05_001-ZPERNR DEFAULT '1' TO '99'.
SELECTION-SCREEN END OF BLOCK B1.

START-OF-SELECTION.
IF S_ZCODE IS INITIAL.
  IF S_ZPERNR IS INITIAL.
     MESSAGE I000.
     EXIT.
  ENDIF.
ENDIF.

PERFORM DATA_SELECT.
PERFORM MODIFY_DATA.
PERFORM FIELD_CATALOG.
PERFORM ALV_DISPLAY.


*&---------------------------------------------------------------------*
*&      Form  FIELD_CATALOG
*&---------------------------------------------------------------------*
*       GT_STUDENT에 대한 GT_FIELDCAT 설정
*----------------------------------------------------------------------*
FORM FIELD_CATALOG .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.
  "체크박스
*  GS_FIELDCAT-COL_POS = 1.
*  GS_FIELDCAT-FIELDNAME = 'CHECKBOX'.
*  GS_FIELDCAT-SELTEXT_M = '체크'.
*  GS_FIELDCAT-CHECKBOX = 'X'.
*  GS_FIELDCAT-EDIT = 'X'.
*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  "신호등
  GS_FIELDCAT-COL_POS = 1.
  GS_FIELDCAT-FIELDNAME = 'COLOR'.
  GS_FIELDCAT-SELTEXT_M = '신호등'.
  GS_FIELDCAT-ICON = 'X'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 2.
  GS_FIELDCAT-FIELDNAME = 'ZCODE'.
  GS_FIELDCAT-SELTEXT_M = '학생코드'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 3.
  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.
  GS_FIELDCAT-SELTEXT_M = '출석번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 4.
  GS_FIELDCAT-FIELDNAME = 'ZKNAME'.
  GS_FIELDCAT-SELTEXT_M = '한글이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 5.
  GS_FIELDCAT-FIELDNAME = 'ZENAME'.
  GS_FIELDCAT-SELTEXT_M = '영문이름'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 6.
  GS_FIELDCAT-FIELDNAME = 'ZGUBUN'.
  GS_FIELDCAT-SELTEXT_M = '성별'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.
  GS_FIELDCAT-COL_POS = 7.
  GS_FIELDCAT-FIELDNAME = 'ZTEL'.
  GS_FIELDCAT-SELTEXT_M = '전화번호'.
  APPEND GS_FIELDCAT TO GT_FIELDCAT.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  ALV_DISPLAY
*&---------------------------------------------------------------------*
*       ALV DISPLAY
*----------------------------------------------------------------------*
FORM ALV_DISPLAY .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      IT_FIELDCAT = GT_FIELDCAT
    TABLES
      T_OUTTAB    = GT_STUDENT.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  DATA_SELECT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM DATA_SELECT .

  SELECT *
    FROM ZEDT05_001
    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT
    WHERE ZCODE IN S_ZCODE
    AND ZPERNR IN S_ZPERNR.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  MODIFY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM MODIFY_DATA .
  LOOP AT GT_STUDENT INTO GS_STUDENT.
    IF GS_STUDENT-ZTEL IS INITIAL.
      GS_STUDENT-COLOR = '@0A@'.
    ELSE.
      GS_STUDENT-COLOR = '@0V@'.
    ENDIF.

    MODIFY GT_STUDENT FROM GS_STUDENT.
  ENDLOOP.
ENDFORM.