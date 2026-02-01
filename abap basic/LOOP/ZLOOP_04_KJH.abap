*&---------------------------------------------------------------------*
*& Report ZLOOP_04_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_04_KJH.

DATA:
  GT_LIST TYPE TABLE OF SFLIGHT,
  GS_LIST TYPE SFLIGHT.

SELECT *
  FROM SFLIGHT
  INTO CORRESPONDING FIELDS OF TABLE GT_LIST.


LOOP AT GT_LIST INTO GS_LIST FROM 2.


    AT FIRST.
      WRITE: / 'AT FIRST'.
    ENDAT.

ENDLOOP.


WRITE: / '끝'.