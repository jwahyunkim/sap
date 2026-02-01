*&---------------------------------------------------------------------*
*& Report ZSELECT_01_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSELECT_01_KJH.

DATA: GS_LIST TYPE SCARR,
      GT_LIST TYPE TABLE OF SCARR.

SELECT *
  FROM SCARR
  INTO TABLE GT_LIST.


LOOP AT GT_LIST INTO GS_LIST.

  IF GS_LIST-CARRID = 'AA'.
    WRITE:
      GS_LIST-CARRID, GS_LIST-CARRNAME, GS_LIST-CURRCODE, GS_LIST-URL.
  ENDIF.

ENDLOOP.