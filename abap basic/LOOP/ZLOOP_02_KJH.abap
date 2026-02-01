*&---------------------------------------------------------------------*
*& Report ZLOOP_02_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_02_KJH.

TYPES: BEGIN OF TY_SCARR.
         INCLUDE TYPE SCARR.
         TYPES: CUR_KR TYPE STRING,
       END OF TY_SCARR.

*TYPES: BEGIN OF ty_scarr,
*         carrid   TYPE scarr-carrid,
*         carrname TYPE scarr-carrname,
*         currcode TYPE scarr-currcode,
*         url      TYPE scarr-url,
*         cur_kr   TYPE string,
*       END OF ty_scarr.

DATA: GT_SCARR TYPE TABLE OF TY_SCARR,
      GT_LIST  TYPE TABLE OF TY_SCARR.
*      LS_SCARR TYPE TY_SCARR.

SELECT *
  FROM SCARR
  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR.

*SELECT carrid,
*       carrname,
*       currcode,
*       url
*  FROM scarr
*  INTO TABLE @gt_scarr.

LOOP AT GT_SCARR INTO DATA(LS_SCARR).
  IF LS_SCARR-CURRCODE = 'USD'.
    LS_SCARR-CUR_KR = '달러'.
  ELSEIF LS_SCARR-CURRCODE = 'EUR'.
    LS_SCARR-CUR_KR = '유로'.
  ELSE.
    LS_SCARR-CUR_KR = '화폐'.
  ENDIF.

  APPEND LS_SCARR TO GT_LIST.
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