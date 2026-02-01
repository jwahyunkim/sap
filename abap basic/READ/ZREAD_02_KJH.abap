*&---------------------------------------------------------------------*
*& Report ZREAD_02_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZREAD_02_KJH.

DATA:
  GT_LIST TYPE TABLE OF SCUSTOM,
  GS_LIST TYPE SCUSTOM.

PARAMETERS:
  PA_ID TYPE S_CUSTOMER.

SELECT *
  FROM SCUSTOM
  INTO TABLE GT_LIST.

* Read Table 구현
READ TABLE GT_LIST INTO GS_LIST TRANSPORTING NO FIELDS
 WITH KEY ID = PA_ID.



IF SY-SUBRC EQ 0.
  MESSAGE S016(pn) WITH PA_ID '존재합니다!'.
ELSE.
  MESSAGE S016(pn) WITH PA_ID '존재하지않습니다!' DISPLAY LIKE 'E'.
ENDIF.