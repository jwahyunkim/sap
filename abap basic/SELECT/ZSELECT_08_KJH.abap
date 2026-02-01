*&---------------------------------------------------------------------*
*& REPORT ZSELECT_08_KJH
*&---------------------------------------------------------------------*
REPORT ZSELECT_08_KJH.

DATA: BEGIN OF GT_LIST OCCURS 0,
  CUSTOMID   TYPE S_CUSTOMER,
  NAME       TYPE S_CUSTNAME,
END OF GT_LIST.

DATA:
  GS_LIST LIKE GT_LIST,
  LT_SBOOK TYPE TABLE OF SBOOK.

SELECT *
  FROM SBOOK
  INTO CORRESPONDING FIELDS OF TABLE @LT_SBOOK
  WHERE CARRID = 'AA'
    AND CONNID = 17
    AND FLDATE = '20171219'.

* TL_SBOOK에 기준 조건을 넣고 그 기준을 SCUSTOM의 조회 조건으로 사용 할 때 FOR ALL ENTRIES IN을 사용한다.

SELECT ID AS CUSTOMID,NAME
  FROM SCUSTOM
  INTO CORRESPONDING FIELDS OF TABLE @GT_LIST[]
  FOR ALL ENTRIES IN @LT_SBOOK
  WHERE ID = @LT_SBOOK-CUSTOMID.

* FOR ALL ENTRIES IN 을 사용하지 않고 JOIN으로 한 경우
*SELECT SC~ID AS CUSTOMID,
*       SC~NAME
*  FROM SCUSTOM AS SC
*  INNER JOIN SBOOK AS SB
*    ON SC~ID = SB~CUSTOMID
*  INTO CORRESPONDING FIELDS OF TABLE @GT_LIST[]
*  WHERE SB~CARRID = 'AA'
*    AND SB~CONNID = 17
*    AND SB~FLDATE = '20171219'.



BREAK-POINT.


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