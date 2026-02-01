*&---------------------------------------------------------------------*
*& Report ZDOMAIN_VALUE_00_TEST_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDOMAIN_VALUE_00_TEST_KJH.

TYPES: BEGIN OF TY_S_LIST,
         ID             TYPE  S_CUSTOMER,
         NAME           TYPE  S_CUSTNAME,
         FORM           TYPE  S_FORM,
         STREET         TYPE  S_STREET,
         POSTBOX        TYPE  S_POSTBOX,
         POSTCODE       TYPE  POSTCODE,
         CITY           TYPE  CITY,
         COUNTRY        TYPE  S_COUNTRY,
         REGION         TYPE  S_REGION,
         TELEPHON       TYPE  S_PHONENO,
         CUSTTYPE       TYPE  S_CUSTTYPE,
         CUSTTYPE_T(30),
         CUSTTYPE_1(10),
         DISCOUNT       TYPE  S_DISCOUNT,
         LANGU          TYPE  SPRAS,
         EMAIL          TYPE  S_EMAIL,
         WEBUSER        TYPE  S_WEBNAME,
       END OF TY_S_LIST.

DATA: GT_LIST TYPE TABLE OF TY_S_LIST,
      GS_LIST TYPE TY_S_LIST.

DATA:
  LT_DDTEXT TYPE TABLE OF DD07V,
  LS_DDTEXT TYPE DD07V.


SELECT *
  FROM SCUSTOM
  INTO CORRESPONDING FIELDS OF TABLE GT_LIST.

CALL FUNCTION 'DD_DOMVALUES_GET'
  EXPORTING
    DOMNAME        = 'S_CUSTTYPE'
    TEXT           = 'X'
  TABLES
    DD07V_TAB      = LT_DDTEXT
  EXCEPTIONS
    WRONG_TEXTFLAG = 1
    OTHERS         = 2.


LOOP AT GT_LIST INTO GS_LIST.

  READ TABLE LT_DDTEXT WITH KEY DOMVALUE_L = GS_LIST-CUSTTYPE
  INTO LS_DDTEXT.

  GS_LIST-CUSTTYPE_T = LS_DDTEXT-DDTEXT.

  MODIFY GT_LIST FROM GS_LIST TRANSPORTING CUSTTYPE_T.

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
    T_TABLE = GT_LIST[]
).

LO_COLUMNS = GR_SALV->GET_COLUMNS( ).
LO_COLUMNS->SET_OPTIMIZE( ).

GR_SALV->DISPLAY( ).
*-------------------------------------*