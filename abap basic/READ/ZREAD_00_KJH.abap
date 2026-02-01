*&---------------------------------------------------------------------*
*& Report ZREAD_00_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREAD_00_KJH.

DATA : GT_LIST TYPE TABLE OF SCARR.

PARAMETERS: PA_VALUE(2) TYPE C.

SELECT *
  FROM SCARR
  INTO TABLE GT_LIST.

READ TABLE GT_LIST INTO DATA(GS_LIST) WITH KEY CARRID = PA_VALUE.

WRITE:
'SY-TABIX=', SY-TABIX,
/
GS_LIST-CARRID, GS_LIST-CARRNAME, GS_LIST-CURRCODE, GS_LIST-URL.