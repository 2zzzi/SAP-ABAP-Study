*&---------------------------------------------------------------------*
*& Include MZFC1770_TOP                             - Module Pool      SAPMZFC1770
*&---------------------------------------------------------------------*
PROGRAM sapmzfc1770.

"Common Variable
DATA : ok_code  TYPE sy-ucomm,
       gv_subrc TYPE sy-subrc.

"ALV Variable
DATA : go_con TYPE REF TO cl_gui_custom_container,
       go_alv TYPE REF TO cl_gui_alv_grid.

DATA : gs_layo TYPE lvc_s_layo,
       gt_fcat TYPE lvc_t_fcat,
       gs_fcat TYPE lvc_s_fcat,
       gt_sort TYPE lvc_t_sort,
       gs_sort TYPE lvc_s_sort.

"100 Condition
TABLES zsfc17070.

"100 Display
DATA : gs_list TYPE zsfc17071,
       gt_list LIKE TABLE OF gs_list.

"200 Insert
TABLES zsfc17071.

"Subject Text Table
DATA : gt_sub TYPE TABLE OF ztfc1703_t,
       gs_sub LIKE LINE OF gt_sub.