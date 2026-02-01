*&---------------------------------------------------------------------*
*& REPORT ZPARAMETER_01_KJH
*&---------------------------------------------------------------------*
REPORT ZPARAMETER_01_KJH.

* 라디오 버튼 선언
PARAMETERS: A RADIOBUTTON GROUP R1 DEFAULT 'X',
            B RADIOBUTTON GROUP R1,
            C RADIOBUTTON GROUP R1.

SELECTION-SCREEN SKIP.

PARAMETERS: A1 RADIOBUTTON GROUP R2 DEFAULT 'X',
            B1 RADIOBUTTON GROUP R2,
            C1 RADIOBUTTON GROUP R2.

START-OF-SELECTION.

* 첫 번째 CASE: A, B, C 분기 (예시상 A/B/C는 임의 출력)
* ABAP에서 CASE 'X'. WHEN <변수>. 는 내부적으로: IF <변수> = 'X'. 이렇게 인식한다.

CASE 'X'.
  WHEN A.
    WRITE: / 'A'.
  WHEN B.
    WRITE: / 'B'.
  WHEN OTHERS.
    WRITE: / 'C'.
ENDCASE.

* 두 번째 CASE: A1, B1, C1 분기
CASE 'X'.
  WHEN A1.
    WRITE: / 'A1'.
  WHEN B1.
    WRITE: / 'B1'.
  WHEN C1.
    WRITE: / 'C1'.
ENDCASE.