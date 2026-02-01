*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTION_00_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTION_00_KJH.

*-------------------------------------*
*DATA
*  GT_LIST TYPE TABLE OF SFLIGHT.

TYPES: BEGIN OF TY_GT.
         INCLUDE TYPE SFLIGHT.
       TYPES: END OF TY_GT.

DATA: GT_LIST TYPE TABLE OF TY_GT.

*TABLES
*  SCARR.

DATA: LS_SCARR TYPE SCARR.



SELECT-OPTIONS
  SO_ID FOR LS_SCARR-CARRID.


*-------------------------------------*
* WHERE CARRID IN SO_ID. 이거는 B가 A안에 있는 값들 중 하나일때
SELECT *
  FROM SFLIGHT
  INTO TABLE GT_LIST
  WHERE
      CARRID IN SO_ID.


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