*&---------------------------------------------------------------------*
*& Report ZPARAMETER_04_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*유효성 검사 + SEARCH HELP
REPORT ZPARAMETER_04_KJH.

PARAMETERS: PV_1 TYPE SCARR-CARRID,
            PV_2 TYPE SCARR-CARRID.


AT SELECTION-SCREEN ON PV_1.
  SELECT SINGLE CARRID
    FROM SCARR
*    SELECT 구문 안에서 외부 변수 PV_1을 사용한다는 의미
    WHERE CARRID = @PV_1
*    inline 방식으로 변수 lv_carrid를 선언하면서 값도 대입함
    INTO @DATA(LV_CARRID).

  IF SY-SUBRC <> 0.
    MESSAGE '존재하지 않음' TYPE 'E'.
  ENDIF.