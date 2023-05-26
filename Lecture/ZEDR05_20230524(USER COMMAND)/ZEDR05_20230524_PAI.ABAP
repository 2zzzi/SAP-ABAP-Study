*&---------------------------------------------------------------------*
*&  Include           ZEDR05_20230524_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.
    WHEN 'APND'.
      CLEAR : GS_STUDENT.
      GS_STUDENT-ZCODE = 'SSU-99'.
      GS_STUDENT-ZPERNR = '000000099'.
      GS_STUDENT-ZKNAME = '도레미'.
      GS_STUDENT-ZENAME = 'DO'.
      GS_STUDENT-ZGUBUN = 'F'.
      GS_STUDENT-ZTEL = '010-2222-3333'.
      APPEND GS_STUDENT TO GT_STUDENT.

    WHEN 'SAVE'.
      MODIFY ZEDT05_001 FROM TABLE GT_STUDENT.

      IF SY-SUBRC = 0.
        MESSAGE '성공' TYPE 'S'.
      ELSE.
        MESSAGE '실패' TYPE 'S'.
      ENDIF.



  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.
    WHEN 'BACK' OR 'CANC'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

ENDMODULE.