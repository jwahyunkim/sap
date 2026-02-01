*&---------------------------------------------------------------------*
*& Report ZLOOP_03_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_03_KJH.
*-------------------------------------*

*SFLIGHT Table에서 SELECT문을 통해 데이터를 가져와보자.
*이번 예제는 가져온 데이터를 통해 LOOP문의 조건문을 사용해서 “AA”에 대한 “CONNID” 값을 변경하자.
*LOOP문 안에 IF문과 CASE문을 넣는 방법이 아니다.
*-------------------------------------*
DATA: GT_SFLIGHT TYPE TABLE OF SFLIGHT,
      GT_LIST    TYPE TABLE OF SFLIGHT,
      LT_SFLIGHT TYPE SFLIGHT.

SELECT *
  FROM SFLIGHT
  INTO TABLE GT_SFLIGHT.



LOOP AT GT_SFLIGHT INTO LT_SFLIGHT WHERE CARRID = 'AA'.
    LT_SFLIGHT-CONNID = 9999.
    APPEND LT_SFLIGHT TO GT_LIST.
ENDLOOP.

LOOP AT GT_SFLIGHT INTO LT_SFLIGHT WHERE CARRID <> 'AA'.
        APPEND LT_SFLIGHT TO GT_LIST.
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