*&---------------------------------------------------------------------*
*& Include          MZFC1770_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form create_alv_object_0100
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_alv_object_0100 .

    IF go_con IS NOT INITIAL.
      RETURN.
    ENDIF.
  
    CREATE OBJECT go_con
      EXPORTING
  *     parent                      =
        container_name              = 'CON'
  *     style                       =
  *     lifetime                    = lifetime_default
  *     repid                       =
  *     dynnr                       =
  *     no_autodef_progid_dynnr     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  
    CREATE OBJECT go_alv
      EXPORTING
  *     i_shellstyle      = 0
  *     i_lifetime        =
        i_parent          = go_con
  *     i_appl_events     = SPACE
  *     i_parentdbg       =
  *     i_applogparent    =
  *     i_graphicsparent  =
  *     i_name            =
  *     i_fcat_complete   = SPACE
  *     o_previous_sral_handler =
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form SET_ALV_DISPLAY_0100
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_alv_display_0100 TABLES t_list LIKE gt_list
                                   t_fcat TYPE lvc_t_fcat
                                   t_sort TYPE lvc_t_sort
                            USING VALUE(p_stname) TYPE dd02l-tabname
                                  VALUE(ps_layo) TYPE lvc_s_layo .
  
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
  *     i_buffer_active               =
  *     i_bypassing_buffer            =
  *     i_consistency_check           =
        i_structure_name              = p_stname
  *     is_variant                    =
  *     i_save                        =
  *     i_default                     = 'X'
        is_layout                     = ps_layo
  *     is_print                      =
  *     it_special_groups             =
  *     it_toolbar_excluding          =
  *     it_hyperlink                  =
  *     it_alv_graphics               =
  *     it_except_qinfo               =
  *     ir_salv_adapter               =
      CHANGING
        it_outtab                     = t_list[]
        it_fieldcatalog               = t_fcat[]
        it_sort                       = t_sort[]
  *     it_filter                     =
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4.
    IF sy-subrc <> 0.
  *   Implement suitable error handling here
      MESSAGE a007(zmcfc17). "ALV Display Error.
    ENDIF.
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form SEARCH_SUBJECT_DATA
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM search_subject_data TABLES t_list TYPE zsfc17071_t.
  
    PERFORM get_subject_list TABLES t_list[]
                             USING zsfc17070-subid_fr zsfc17070-subid_to
                             CHANGING gv_subrc.
    IF gv_subrc <> 0.
      RETURN.
    ENDIF.
  
    CLEAR : gs_sub, gt_sub.
    LOOP AT t_list.
  
      PERFORM bring_subject_name TABLES gt_sub
                                 USING t_list-subid
                                 CHANGING t_list-subname.
      MODIFY t_list.
      CLEAR t_list.
    ENDLOOP.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form GET_SUBJECT_LIST
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      <-- GV_SUBRC
  *&---------------------------------------------------------------------*
  FORM get_subject_list TABLES t_list TYPE zsfc17071_t
                        USING VALUE(p_fid) TYPE ztfc1703-subid
                              VALUE(p_tid) TYPE ztfc1703-subid
                        CHANGING p_subrc TYPE sy-subrc.
  
    CLEAR p_subrc.
  
    SELECT subid price waers
      FROM ztfc1703
      INTO CORRESPONDING FIELDS OF TABLE t_list[]
     WHERE subid BETWEEN p_fid AND p_tid.
  
    IF sy-subrc <> 0.
      p_subrc = sy-subrc.
      MESSAGE s019(zmcfc17). "조건에 일치하는 교과목이 존재하지 않습니다.
      RETURN.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form get_subject_name
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM get_subject_name_tab .
  
    SELECT subid subname
      FROM ztfc1703_t
      INTO CORRESPONDING FIELDS OF TABLE gt_sub
     WHERE subid BETWEEN zsfc17070-subid_fr AND zsfc17070-subid_to
    AND spras = sy-langu.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form set_alv_layout_0100
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      <-- GS_LAYO
  *&---------------------------------------------------------------------*
  FORM set_alv_layout_0100  CHANGING ps_layo TYPE lvc_s_layo.
  
    CLEAR gs_layo.
    gs_layo-cwidth_opt = 'X'.
    gs_layo-zebra = 'X'.
    gs_layo-sel_mode = 'A'.
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form insert_subject
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      <-- GV_SUBRC
  *&---------------------------------------------------------------------*
  FORM insert_subject USING ps_insert TYPE zsfc17071
                      CHANGING p_subrc TYPE sy-subrc.
  
    PERFORM insert_ztfc1703 USING ps_insert-subid
                                  ps_insert-price
                                  ps_insert-waers.
    PERFORM insert_ztfc1703_t USING ps_insert-subid
                                    ps_insert-subname.
  
    COMMIT WORK.
    MESSAGE s021(zmcfc17) WITH ps_insert-subid."& 교과목 등록에 성공하였습니다.
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form get_update_record
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      <-- GV_SUBRC
  *&---------------------------------------------------------------------*
  FORM get_update_record TABLES t_list TYPE zsfc17071_t
                          CHANGING p_subrc TYPE sy-subrc.
  
    CLEAR : p_subrc, gs_list.
    DATA : lv_rowno TYPE lvc_index,
           ls_list  LIKE gs_list.
  
    PERFORM get_select_row CHANGING lv_rowno p_subrc.
    IF p_subrc <> 0.
      RETURN.
    ENDIF.
  
    READ TABLE t_list INDEX lv_rowno INTO ls_list.
  
    PERFORM get_single_subject_list USING ls_list-subid
                                    CHANGING gs_list.
  
    PERFORM get_subname USING gs_list-subid
                              sy-langu
                        CHANGING gs_list-subname.
  
    MOVE-CORRESPONDING gs_list TO zsfc17071.
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form GET_SELECT_ROW
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      <-- LV_ROWNO
  *&      <-- P_SUBRC
  *&---------------------------------------------------------------------*
  FORM get_select_row  CHANGING c_rowno
                                c_subrc.
  
    CLEAR : c_rowno, c_subrc.
  
    CALL FUNCTION 'ZFFC17_05'
      EXPORTING
        io_alv       = go_alv
      IMPORTING
        ev_rowno     = c_rowno
      EXCEPTIONS
        no_exist_row = 1
        too_many_row = 2
        OTHERS       = 3.
    IF sy-subrc = 1.
      MESSAGE s022(zmcfc17). "미선택 Error : 교과목 레코드 한건을 선택해주세요.
      c_subrc = 1.
      RETURN.
    ELSEIF sy-subrc = 2.
      MESSAGE s023(zmcfc17). "다중선택 Error : 교과목 레코드를 한건만 선택해주세요.
      c_subrc = 2.
      RETURN.
    ELSE.
      RETURN.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form UPDATE_SUBJECT_DATA
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM update_subject_data USING ps_update TYPE zsfc17071.
  
    CALL FUNCTION 'ZFFC17_08'
      EXPORTING
        is_update       = ps_update
              .
  
  *
  *  DATA : lv_subname TYPE ztfc1703_t-subname,
  *         ls_texttab TYPE ztfc1703_t,
  *         lv_subrc type sy-subrc.
  *
  *  perform update_ztfc1703 using ps_update-subid
  *                                ps_update-price
  *                                PS_UPDATE-waers
  *                          changing lv_subrc.
  *
  *  IF lv_subrc <> 0.
  *    RETURN.
  *  ENDIF.
  *
  *  PERFORM get_subname USING ps_update-subid
  *                      CHANGING lv_subname.
  *
  *  IF sy-subrc = 0.
  *    PERFORM update_ztfc1703_t USING ps_update-subid
  *                                    ps_update-subname.
  *  ELSE.
  *    PERFORM insert_ztfc1703_t USING ps_update-subid
  *                                    ps_update-subname.
  *  ENDIF.
  *
  *  COMMIT WORK.
  *  MESSAGE s025(zmcfc17) WITH ps_update-subid.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form insert_ztfc1703
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM insert_ztfc1703 USING VALUE(p_subid) TYPE ztfc1703-subid
                             VALUE(p_price) TYPE ztfc1703-price
                             VALUE(p_waers) TYPE ztfc1703-waers.
  
    DATA : lv_subrc TYPE sy-subrc.
  
    CALL FUNCTION 'ZFFC17_03'
      EXPORTING
        iv_subid = p_subid
        iv_price = p_price
        iv_waers = p_waers
      IMPORTING
        ev_subrc = lv_subrc.
    IF lv_subrc <> 0.
      MESSAGE a020(zmcfc17) WITH p_subid. "& 교과목 등록에 실패하였습니다.
      RETURN.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form insert_ztfc1703_t
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM insert_ztfc1703_t USING VALUE(p_subid) TYPE ztfc1703-subid
                               VALUE(p_subname) TYPE ztfc1703_t-subname.
  
    DATA : lv_subrc TYPE sy-subrc.
  
    CALL FUNCTION 'ZFFC17_04'
      EXPORTING
        iv_subid   = p_subid
        iv_langu   = sy-langu
        iv_subname = p_subname
      IMPORTING
        ev_subrc   = lv_subrc.
  
    IF lv_subrc <> 0.
      MESSAGE a020(zmcfc17) WITH p_subid. "& 교과목 등록에 실패하였습니다.
      RETURN.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form SET_ALV_SORT_0100
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM set_alv_sort_0100 TABLES t_sort TYPE lvc_t_sort.
  
    CLEAR : t_sort, t_sort[].
    t_sort-spos = 1.
    t_sort-fieldname = 'SUBID'.
    t_sort-up = 'X'.
    APPEND t_sort.
    CLEAR t_sort.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form GET_TEXTTAB_DATA
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> GS_LIST_SUBID
  *&      <-- GS_SUB
  *&---------------------------------------------------------------------*
  FORM get_texttab_data  USING    p_subid
                                  p_langu type sy-langu
                         CHANGING ps_sub TYPE ztfc1703_t.
  
    CLEAR ps_sub.
    ps_sub-subid = p_subid.
    PERFORM get_subname USING p_subid
                              p_langu
                        CHANGING ps_sub-subname.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form UPDATE_ZTFC1703_T
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM update_ztfc1703_t USING p_subid TYPE ztfc1703-subid
                               p_subname TYPE ztfc1703_t-subname.
  
    CALL FUNCTION 'ZFFC17_06'
      EXPORTING
        iv_subid      = p_subid
        iv_langu      = sy-subrc
        iv_subname    = p_subname
      EXCEPTIONS
        failed_update = 1
        OTHERS        = 2.
  
    IF sy-subrc <> 0.
      MESSAGE a020(zmcfc17) WITH p_subid. "& 교과목 변경을 실패하였습니다.
      RETURN.
    ENDIF.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form get_subname
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> p_subid
  *&      <-- p_subname
  *&---------------------------------------------------------------------*
  FORM get_subname  USING    VALUE(p_subid) TYPE ztfc1703-subid
                             value(p_langu) type ztfc1703_t-spras
                    CHANGING p_subname TYPE ztfc1703_t-subname.
  
    CALL FUNCTION 'ZFFC17_02'
      EXPORTING
        iv_subid   = p_subid
        iv_langu   = p_langu
      IMPORTING
        ev_subname = p_subname.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form bring_subject_name
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> GT_SUB
  *&      --> GS_LIST_SUBID
  *&---------------------------------------------------------------------*
  FORM bring_subject_name  TABLES   t_sub LIKE gt_sub
                           USING    VALUE(p_subid) TYPE ztfc1703-subid
                           CHANGING c_subname TYPE ztfc1703_t-subname.
  
  
    READ TABLE t_sub WITH KEY subid = p_subid
                              spras = sy-langu.
    IF sy-subrc <> 0.
      PERFORM get_texttab_data USING p_subid
                                     sy-langu
                               CHANGING t_sub.
      APPEND t_sub.
    ENDIF.
  
    c_subname = t_sub-subname.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form get_SINGLE_subject_list
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> LS_LIST_SUBID
  *&      <-- GS_LIST
  *&---------------------------------------------------------------------*
  FORM get_single_subject_list  USING    VALUE(p_subid) TYPE ztfc1703-subid
                                CHANGING ps_list TYPE zsfc17071.
  
    SELECT SINGLE subid price waers
      FROM ztfc1703
      INTO CORRESPONDING FIELDS OF ps_list
     WHERE subid = p_subid.
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form update_ztfc1703
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *&      --> PS_UPDATE_SUBID
  *&      --> PS_UPDATE_PRICE
  *&      <-- LV_SUBRC
  *&---------------------------------------------------------------------*
  FORM update_ztfc1703  USING    value(p_subid) type ztfc1703-subid
                                 value(p_price) type ztfc1703-price
                                 value(p_waers) type ztfc1703-waers
                        CHANGING p_subrc.
    CALL FUNCTION 'ZFFC17_07'
      EXPORTING
        iv_subid            = p_subid
        iv_price            = p_price
        iv_waers            = p_waers
     EXCEPTIONS
       FAILED_UPDATE       = 1
       OTHERS              = 2
              .
    IF sy-subrc <> 0.
      message a024(zmcfc17) with p_subid. "& 교과목 변경을 실패하였습니다.
      return.
    ENDIF.
  
  ENDFORM.