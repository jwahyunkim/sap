*&---------------------------------------------------------------------*
*& Report ZSELECT_OPTION_01_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_OPTION_01_KJH.

*TABLES:
*  SFLIGHT.
* SELECT OPTION의 참조필드 선언
DATA: LT_SFLIGHT TYPE SFLIGHT.


TYPES: BEGIN OF TY_SFLIGHT.
         INCLUDE TYPE SFLIGHT.
       TYPES: END OF TY_SFLIGHT.

DATA:
  GT_LIST TYPE TABLE OF TY_SFLIGHT.

SELECT-OPTIONS:
  SO_ID FOR LT_SFLIGHT-CARRID DEFAULT 'AA'.


*INITIALIZATION.
*  so_id-sign   = 'E'.
*  so_id-option = 'EQ'.
*  so_id-low    = 'AA'.
*  APPEND so_id TO so_id.

START-OF-SELECTION.
* SQL
  SELECT *
    FROM SFLIGHT
    INTO TABLE GT_LIST
    WHERE
        CARRID NOT IN SO_ID.


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