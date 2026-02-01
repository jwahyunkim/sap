*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTION_03_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTION_03_KJH.

TYPES: BEGIN OF TY_SCARR.
         INCLUDE TYPE SCARR.
       TYPES: END OF TY_SCARR.

DATA GT_LIST TYPE TABLE OF TY_SCARR.

DATA LT_SCARR TYPE SCARR.

SELECT-OPTIONS SO_ID FOR LT_SCARR-CARRID NO INTERVALS.

SELECT *
  FROM SCARR
  INTO TABLE GT_LIST
  WHERE CARRID IN SO_ID.

*-------------------------------------*
DATA:
  GR_SALV TYPE REF TO CL_SALV_TABLE.

DATA:
  LO_COLUMNS TYPE REF TO CL_SALV_COLUMNS_TABLE.

CL_SALV_TABLE=>FACTORY(
  IMPORTING
    R_SALV_TABLE = GR_SALV
  CHANGING
    T_TABLE = GT_LIST
).

LO_COLUMNS = GR_SALV->GET_COLUMNS( ).
LO_COLUMNS->SET_OPTIMIZE( ).

GR_SALV->DISPLAY( ).
*-------------------------------------*