*&---------------------------------------------------------------------*
*& Report ZTYPES_00_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_00_KJH.


*--------------------------------------------------------------------*
*  Header Line으로 변경 해야하는 부분
*--------------------------------------------------------------------*



DATA:
  GT_TABLE TYPE TABLE OF SCARR WITH HEADER LINE,
  GS_TABLE TYPE SCARR.

GT_TABLE-CARRID = 'AA'.
GT_TABLE-CARRNAME = 'American Airlines'.
GT_TABLE-CURRCODE = 'USD'.
GT_TABLE-URL = 'http://www.aa.com'.
APPEND GT_TABLE TO GT_TABLE[].


GT_TABLE-CARRID = 'AC'.
GT_TABLE-CARRNAME = 'Air Canada'.
GT_TABLE-CURRCODE = 'CAD'.
GT_TABLE-URL = 'http://www.aircanada.ca'.
APPEND GT_TABLE TO GT_TABLE[].

* LOOP AT GT_TABLE[] INTO GS_TABLE. 에서 GT_TABLE의 ROW 하고 GS_TABLE의 구조는 동일해야한다.
* GT_TABLE[] 의 ROW 갯수만큼 반복문이 실행된다.
LOOP AT GT_TABLE[] INTO GS_TABLE.
  WRITE :GS_TABLE-CARRID,
         GS_TABLE-CARRNAME,
         GS_TABLE-CURRCODE,
         GS_TABLE-URL.
ENDLOOP.


*--------------------------------------------------------------------*