
*&---------------------------------------------------------------------*
*& Report ZSELECT_08_PRACTICE_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_08_PRACTICE_KJH.

DATA: BEGIN OF GT_LIST OCCURS 0,
  CUSTOMID   TYPE S_CUSTOMER,
  NAME       TYPE S_CUSTNAME,
END OF GT_LIST.

DATA:
  GS_LIST LIKE GT_LIST,
  LT_SBOOK TYPE TABLE OF SBOOK.

SELECT *
  FROM SBOOK
  INTO TABLE LT_SBOOK[]
  WHERE CARRID = 'AA'
  AND CONNID = 17
  AND FLDATE = '20171219'.



SELECT ID AS CUSTOMID,NAME
  FROM SCUSTOM
  INTO CORRESPONDING FIELDS OF TABLE @GT_LIST[]
  FOR ALL ENTRIES IN @LT_SBOOK
  WHERE ID = @LT_SBOOK-CUSTOMID.



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
*--------------------------------------------------------------------