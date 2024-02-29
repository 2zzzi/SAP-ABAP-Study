*&---------------------------------------------------------------------*
*& Include          MZFC1770_I01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANC'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'ENTER'.


    WHEN 'SEARCH'.
      PERFORM search_subject_data TABLES gt_list.

    WHEN 'INSERT'.
      CLEAR zsfc17071.
      zsfc17071-waers = 'KRW'.
      CALL SCREEN 200.
      PERFORM search_subject_data TABLES gt_list.

    WHEN 'UPDATE'.
      CLEAR zsfc17071.
      PERFORM get_update_record TABLES gt_list
                                CHANGING gv_subrc.
      IF gv_subrc <> 0.
        RETURN.
      ENDIF.
      CALL SCREEN 300.
      PERFORM search_subject_data TABLES gt_list.

    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'ENTER'.

    WHEN 'SAVE'.
      PERFORM insert_subject USING zsfc17071
                             CHANGING gv_subrc.
      IF gv_subrc <> 0.
        RETURN.
      ENDIF.


    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0300 INPUT.

  CASE ok_code.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'ENTER'.

    WHEN 'UPDATE'.
      PERFORM update_subject_data USING zsfc17071.

    WHEN OTHERS.

  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHANGE_PARAMETERS  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE change_parameters INPUT.

  CLEAR : gt_list.
  IF zsfc17070-subid_fr > zsfc17070-subid_to.
    MESSAGE s026(zmcfc17). "조건의 범위를 다시 설정해주세요.
  ENDIF.

ENDMODULE.