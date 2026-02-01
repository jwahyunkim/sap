*&---------------------------------------------------------------------*
*& Report ZSELECT_10_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_10_KJH.

DATA:
  GT_LIST TYPE TABLE OF SCUSTOM.
*--------------------------------------------------------------------*

SELECT *
  FROM SCUSTOM
  INTO TABLE GT_LIST[]
  WHERE NAME LIKE '%Canada%'.



*--------------------------------------------------------------------*
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
*--------------------------------------------------------------------*