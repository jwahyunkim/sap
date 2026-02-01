*&---------------------------------------------------------------------*
*& Report ZTYPES_03_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_03_KJH.
*옛날 방식
TABLES:
  SCARR.

SELECT SINGLE * FROM SCARR WHERE CARRID = 'AA'.

WRITE: SCARR-CARRID, SCARR-CARRNAME, SCARR-CURRCODE, SCARR-URL.

*요즘 방식
DATA gs_scarr TYPE scarr.

SELECT SINGLE *
  FROM scarr
  INTO gs_scarr
  WHERE carrid = 'AA'.

WRITE: gs_scarr-carrid,
       gs_scarr-carrname,
       gs_scarr-currcode,
       gs_scarr-url.