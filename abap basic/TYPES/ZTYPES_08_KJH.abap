*&---------------------------------------------------------------------*
*& REPORT ZTYPES_08_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_08_KJH.

*DATA BEGIN OF 선언 *
*OCCURS 0 는 현재 거의 사용되지 않은 현재는 구조체 + 내부 테이블 선언 방식이 권장됨
*DATA : BEGIN OF GT_LIST OCCURS 0.
*        INCLUDE TYPE SCARR.
*DATA : END OF GT_LIST.

TYPES : BEGIN OF TY_LIST.
          INCLUDE TYPE SCARR.
        TYPES : END OF TY_LIST.

DATA : GT_LIST TYPE TABLE OF TY_LIST.


SELECT *
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
*-------------------------------------*