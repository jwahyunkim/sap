*&---------------------------------------------------------------------*
*& Report ZLOOP_01_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_01_KJH.
DATA GT_LIST TYPE TABLE OF SCARR.
DATA LT_SCARR TYPE TABLE OF SCARR.

SELECT *
  FROM SCARR
  INTO TABLE LT_SCARR.
*  WHERE CARRID = 'AA'.



LOOP AT LT_SCARR INTO DATA(LS_SCARR).
*  IF LS_SCARR-CARRID CP 'A*'.
    LS_SCARR-URL = 'TEST1'.

*  ENDIF.
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