*&---------------------------------------------------------------------*
*& Report ZSELECT_07_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_07_KJH.

DATA: BEGIN OF GT_LIST OCCURS 0,
        CARRID   TYPE S_CARR_ID,
        CARRNAME TYPE S_CARRNAME,
        CURRCODE TYPE S_CURRCODE,
        URL      TYPE S_CARRURL,
        TEXT(20),
      END OF GT_LIST.

DATA:
  GS_LIST LIKE GT_LIST.

* SELECT
*-------------------------------------*
SELECT CARRID, CARRNAME, CURRCODE, URL
  FROM SCARR
  INTO (@GS_LIST-CARRID, @GS_LIST-CARRNAME, @GS_LIST-CURRCODE, @GS_LIST-URL).

  IF GS_LIST-CURRCODE = 'USD'.
    GS_LIST-TEXT = '달러'.
  ELSEIF GS_LIST-CURRCODE = 'EUR'.
    GS_LIST-TEXT = '유로'.
  ELSE.
    GS_LIST-TEXT = '화폐' .
  ENDIF.
  APPEND GS_LIST TO GT_LIST.
ENDSELECT.


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