*&---------------------------------------------------------------------*
*& Report ZSELECT_09_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_09_KJH.


DATA:
  GT_LIST TYPE TABLE OF SFLIGHT.
*--------------------------------------------------------------------*

SELECT *
  FROM SFLIGHT
  INTO TABLE GT_LIST[]
  WHERE PRICE BETWEEN 400 AND 1000.



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