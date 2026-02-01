*&---------------------------------------------------------------------*
*& Report ZTYPES_02_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_02_KJH.

*데이터베이스 테이블 SCARR와 동일한 구조의
*전역 워크에어리어를 하나 자동으로 선언하는 구문
*DATA scarr TYPE scarr. 이게 선언 되었다고 보면 됨

TABLES:
  SCARR.

SCARR-CARRID = 'GJ'.
SCARR-CARRNAME = 'GAMJA'.
SCARR-CURRCODE = 'KRW'.
SCARR-URL = 'https://patato98.tistory.com/'.

INSERT scarr FROM scarr.
SELECT SINGLE * FROM SCARR WHERE CARRID ='GJ'.


WRITE: SCARR-CARRID, SCARR-CARRNAME, SCARR-CURRCODE, SCARR-URL.