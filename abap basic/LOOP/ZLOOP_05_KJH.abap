*&---------------------------------------------------------------------*
*& Report ZLOOP_05_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_05_KJH.

*--------------------------------------------------------------------*
* 디폴트
*--------------------------------------------------------------------*
DATA:
  ISCARR TYPE  SCARR OCCURS 0 WITH HEADER LINE.


CLEAR:
  ISCARR,
  ISCARR[].

*--1--------------------------------------------------------------------
ISCARR-CARRID = 'AA'.  ISCARR-CARRNAME = 'American Airlines   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.

ISCARR-CARRID = 'AA'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--2--------------------------------------------------------------------
ISCARR-CARRID = 'AC'.  ISCARR-CARRNAME = 'Air Canada          '.
ISCARR-CURRCODE = 'CAD'. ISCARR-URL = 'http://www.aircanada.ca'.
APPEND ISCARR.

ISCARR-CARRID = 'AC'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--3--------------------------------------------------------------------
ISCARR-CARRID = 'AF'.  ISCARR-CARRNAME = 'Air France          '.
ISCARR-CURRCODE = 'EUR'. ISCARR-URL = 'http://www.airfrance.fr'.
APPEND ISCARR.

ISCARR-CARRID = 'AF'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--4--------------------------------------------------------------------
ISCARR-CARRID = 'AZ'.  ISCARR-CARRNAME = 'Alitalia            '.
ISCARR-CURRCODE = 'EUR'. ISCARR-URL = 'http://www.alitalia.it'.
APPEND ISCARR.

ISCARR-CARRID = 'AZ'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--5--------------------------------------------------------------------
ISCARR-CARRID = 'BA'.  ISCARR-CARRNAME = 'British Airways     '.
ISCARR-CURRCODE = 'GBP'. ISCARR-URL = 'http://www.british-airways.com'
.
APPEND ISCARR.

ISCARR-CARRID = 'BA'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--6--------------------------------------------------------------------
ISCARR-CARRID = 'FJ'.  ISCARR-CARRNAME = 'Air Pacific    '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.airpacific.com'.
APPEND ISCARR.

ISCARR-CARRID = 'FJ'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--7--------------------------------------------------------------------
ISCARR-CARRID = 'CO'.  ISCARR-CARRNAME = 'Continental Airlines'.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.continental.com'.
APPEND ISCARR.

ISCARR-CARRID = 'CO'.  ISCARR-CARRNAME = '감자   '.
ISCARR-CURRCODE = 'USD'. ISCARR-URL = 'http://www.aa.com'.
APPEND ISCARR.
*--------------------------------------------------------------------*


DATA:
  GT_LIST TYPE TABLE OF SCARR,
  GS_LIST TYPE SCARR,
  GV_VALUE TYPE C,
  GS_LIST_TEMP TYPE SCARR.

GT_LIST = ISCARR[].


*--------------------------------------------------------------------*
* 변경
*--------------------------------------------------------------------*
SORT GT_LIST BY CARRID.
*LOOP AT GT_LIST INTO GS_LIST .
*
*
*AT NEW CARRID.
*   GV_VALUE = 'X'.
*ENDAT.
*
*IF GV_VALUE = 'X'.
*
*  WRITE:/ GS_LIST-CARRID, GS_LIST-CARRNAME.
*ENDIF.
*
*GV_VALUE = ''.
*
*ENDLOOP.

LOOP AT GT_LIST INTO GS_LIST .

GS_LIST_TEMP = GS_LIST.

AT NEW CARRID.
  WRITE:/ GS_LIST_TEMP-CARRID, GS_LIST_TEMP-CARRNAME.
ENDAT.

ENDLOOP.