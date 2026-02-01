*&---------------------------------------------------------------------*
*& Report ZLOOP_07_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_07_KJH.

DATA:
  GT_SPFLI TYPE TABLE OF SPFLI,
  GS_SPFLI TYPE SPFLI,
  SUM      TYPE SPFLI-DISTANCE,
  FLAG_NEW,
  FLAG_END.

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
    WRITE: / '항공사:', GS_SPFLI-CARRID.
    SUM = 0.
  ENDIF.
  SUM = SUM + GS_SPFLI-DISTANCE.
  WRITE: / '-> 노선:', GS_SPFLI-CONNID, GS_SPFLI-CITYFROM, '-', GS_SPFLI-CITYTO, '거리:', GS_SPFLI-DISTANCE.

  IF FLAG_END = 'X'.
    WRITE: / '==> 총 거리:', SUM.
    ULINE.
  ENDIF.

  FLAG_NEW = ''.
  FLAG_END = ''.




ENDLOOP.


*--------------------------------------------------------------------*
* WRITE 참고용
*--------------------------------------------------------------------*
" WRITE: / '항공사:', GS_SPFLI-CARRID.

" WRITE: / '-> 노선:', GS_SPFLI-CONNID, GS_SPFLI-CITYFROM, '-', GS_SPFLI-CITYTO, '거리:', GS_SPFLI-DISTANCE.

" WRITE: / '==> 총 거리:', GS_SPFLI-DISTANCE.