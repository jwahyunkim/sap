*&---------------------------------------------------------------------*
*& REPORT ZDOMAIN_VALUE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOMAIN_VALUE_02.


TYPES: BEGIN OF TY_S_LIST,
         CARRID   TYPE S_CARR_ID,
         CONNID   TYPE S_CONN_ID,
         FLDATE   TYPE S_DATE,
         BOOKID   TYPE S_BOOK_ID,
         CUSTOMID TYPE S_CUSTOMER,
         SMOKER   TYPE S_SMOKER,
         SMOKER_T TYPE CHAR10,
       END OF TY_S_LIST.

DATA:
      GT_LIST TYPE TABLE OF TY_S_LIST.

* SELECT 설정(JOIN)
SELECT A~CARRID,
       A~CONNID,
       A~FLDATE,
       A~BOOKID,
       A~CUSTOMID,
       A~SMOKER,
       B~DDTEXT AS SMOKER_T
  FROM SBOOK AS A
  LEFT OUTER JOIN DD07V AS B
  ON A~SMOKER = B~DOMVALUE_L
  WHERE B~DOMNAME = 'S_SMOKER'
  AND A~CARRID = 'AA'
  INTO CORRESPONDING FIELDS OF TABLE @GT_LIST.






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