*&---------------------------------------------------------------------*
*& Report ZTYPES_01_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_01_KJH.


*--------------------------------------------------------------------*
* Header Line

*--------------------------------------------------------------------

DATA:
  GT_LIST TYPE TABLE OF SCARR,
  GT_TABLE TYPE TABLE OF SCARR WITH HEADER LINE,
  GS_LIST TYPE SCARR.

SELECT *
  FROM SCARR
  INTO TABLE GT_TABLE[].

*--------------------------------------------------------------------*
READ TABLE GT_TABLE INDEX 1. " 첫번째 데이터를 읽어온다.

MOVE GT_TABLE   TO GS_LIST. " wa TO wa
MOVE GT_TABLE[] TO GT_LIST. " Table TO Table
*--------------------------------------------------------------------*


*------------------------------------*
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
*-------------------------------------*


WRITE : GS_LIST-CARRID,
        GS_LIST-CARRNAME,
        GS_LIST-CURRCODE,
        GS_LIST-URL.