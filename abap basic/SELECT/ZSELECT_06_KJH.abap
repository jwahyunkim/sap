*&---------------------------------------------------------------------*
*& Report ZSELECT_06_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_06_KJH.

DATA: BEGIN OF GT_LIST OCCURS 0,
  CARRID   TYPE S_CARR_ID,
  CARRNAME TYPE S_CARRNAME,
  CURRCODE TYPE S_CURRCODE,
  URL_NEW  TYPE S_CARRURL,
END OF GT_LIST.


* SELECT
*-------------------------------------*
SELECT
  CARRID
  CARRNAME
  CURRCODE
  URL AS URL_NEW
  FROM SCARR
  INTO CORRESPONDING FIELDS OF TABLE GT_LIST.
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