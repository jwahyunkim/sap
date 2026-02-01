*&---------------------------------------------------------------------*
*& Report ZSELECT_00_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_00_KJH.

DATA: GS_SCARR TYPE TABLE OF SCARR,
      GT_LIST TYPE TABLE OF SCARR.

SELECT *
  FROM SCARR
  INTO TABLE GS_SCARR.


LOOP AT GS_SCARR INTO DATA(LS_SCARR).
  APPEND LS_SCARR TO GT_LIST.
ENDLOOP.

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