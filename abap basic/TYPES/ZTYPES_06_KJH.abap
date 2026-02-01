*&---------------------------------------------------------------------*
*& Report ZTYPES_06_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_06_KJH.

* TYPES 정의 *
TYPES : BEGIN OF TY_S_LIST.
          INCLUDE TYPE SFLIGHT.
          TYPES : CARRNAME TYPE SCARR-CARRNAME,
        END OF TY_S_LIST.


DATA:
  GT_LIST TYPE TABLE OF TY_S_LIST.



SELECT *
  FROM SCARR AS A
  INNER JOIN SFLIGHT AS B
  ON A~CARRID EQ B~CARRID
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
    T_TABLE = GT_LIST
).

COLUMNS = GR_SALV->GET_COLUMNS( ).
COLUMNS->SET_OPTIMIZE( ).

GR_SALV->DISPLAY( ).
*-------------------------------------*