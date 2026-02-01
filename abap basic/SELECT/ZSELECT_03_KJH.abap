*&---------------------------------------------------------------------*
*& Report ZSELECT_03_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_03_KJH.

DATA:
  GV_FIELD1 TYPE SCARR-CARRID,
  GV_FIELD2 TYPE SCARR-CARRNAME,
  GV_FIELD3 TYPE SCARR-URL.

* SELECT
*-------------------------------------*
SELECT SINGLE CARRID, CARRNAME, URL
  FROM SCARR
  INTO (@GV_FIELD1, @GV_FIELD2, @GV_FIELD3)
  WHERE CARRID = 'AA'.

*ENDSELECT.
*-------------------------------------*

  WRITE:
    GV_FIELD1, GV_FIELD2, GV_FIELD3.