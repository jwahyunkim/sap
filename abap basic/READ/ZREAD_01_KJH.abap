*&---------------------------------------------------------------------*
*& Report ZREAD_01_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREAD_01_KJH.

DATA : GT_LIST TYPE TABLE OF SCARR.

PARAMETERS: PA_INDEX TYPE I.

SELECT *
  FROM SCARR
  INTO TABLE GT_LIST.

READ TABLE GT_LIST INTO DATA(GS_LIST) INDEX PA_INDEX.

WRITE:
'SY-TABIX=', SY-TABIX,
/
GS_LIST-CARRID, GS_LIST-CARRNAME, GS_LIST-CURRCODE, GS_LIST-URL.