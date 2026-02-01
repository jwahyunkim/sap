*&---------------------------------------------------------------------*
*& Report ZSELECT_05_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_05_KJH.

DATA: BEGIN OF GT_LIST OCCURS 0,
  URL TYPE S_CARRURL,
  MANDT TYPE S_MANDT,
  CARRID TYPE S_CARR_ID,
  CARRNAME TYPE S_CARRNAME,
  CURRCODE TYPE S_CURRCODE,
END OF GT_LIST.



* SELECT
*-------------------------------------*
SELECT URL, MANDT, CARRID, CARRNAME, CURRCODE
  FROM SCARR
  INTO TABLE @GT_LIST.



*-------------------------------------*


DATA:
  GR_SALV TYPE REF TO CL_SALV_TABLE.

DATA:
  COLUMNS TYPE REF TO CL_SALV_COLUMNS_TABLE.

CL_SALV_TABLE=>FACTORY(
  IMPORTING
    R_SALV_TABLE = GR_SALV
  CHANGING
    T_TABLE = GT_LIST[]
).

COLUMNS = GR_SALV->GET_COLUMNS( ).
COLUMNS->SET_OPTIMIZE( ).

GR_SALV->DISPLAY( ).