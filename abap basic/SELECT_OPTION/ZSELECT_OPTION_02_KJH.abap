*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTION_02_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTION_02_KJH.
* SELECT OPTIONS의 참조 필드
*TABLES:
*  SFLIGHT.
DATA:LT_SFLIGHT TYPE SFLIGHT.

*SELECT-OPTIONS에서  선택한 값을 담는 테이블 선언
*DATA:
*      GT_LIST TYPE TABLE OF SFLIGHT.

TYPES: BEGIN OF TY_SFLIGHT.
         INCLUDE TYPE SFLIGHT.
       TYPES: END OF TY_SFLIGHT.

DATA:GT_LIST TYPE TABLE OF TY_SFLIGHT.

* OPTION 변수는 사용자가 입력할/한 파라미터 값 -> 따라서 입력할 파라미터의 타입을 FOR 뒤에 넣어야함
SELECT-OPTIONS:
  F_DATE FOR LT_SFLIGHT-FLDATE .

* 쿼리 시작 부분 SELECT-OPTIONS에서 선택한 값을 WHERE조건으로 사용  WHERE 칼럼 IN <SELECT-OPTIONS 변수>
START-OF-SELECTION.
  SELECT *
    FROM SFLIGHT
    INTO TABLE GT_LIST
    WHERE
        FLDATE IN F_DATE.
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