*&---------------------------------------------------------------------*
*& Report ZLOOP_06_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_06_KJH.


DATA:
  GT_SPFLI TYPE TABLE OF SPFLI,
  GS_SPFLI TYPE SPFLI,
  FLAG_NEW TYPE STRING,
  FLAG_END TYPE STRING.

SELECT *
  FROM SPFLI
  INTO TABLE GT_SPFLI.



LOOP AT GT_SPFLI INTO GS_SPFLI.

  AT NEW CARRID.
    FLAG_NEW = 'X'.
  ENDAT.

  AT END OF CARRID.
    FLAG_END = 'X'.
  ENDAT.


  IF FLAG_NEW = 'X'.
    WRITE: '항공사:', GS_SPFLI-CARRID .
  ENDIF.

  WRITE: / GS_SPFLI-CONNID, ' ', GS_SPFLI-CITYFROM, GS_SPFLI-CITYTO.

  IF FLAG_END = 'X'.
    ULINE.
  ENDIF.

  FLAG_NEW = ''.
  FLAG_END = ''.

ENDLOOP.