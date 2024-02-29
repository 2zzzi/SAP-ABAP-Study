*&---------------------------------------------------------------------*
*& Module Pool      SAPMZFC1770
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INCLUDE mzfc1770_top                            .    " Global Data

INCLUDE mzfc1770_o01                            .  " PBO-Modules
INCLUDE mzfc1770_i01                            .  " PAI-Modules
INCLUDE mzfc1770_f01                            .  " FORM-Routines

LOAD-OF-PROGRAM.
  PERFORM set_alv_layout_0100 CHANGING gs_layo.
  PERFORM set_alv_sort_0100 TABLES gt_sort.