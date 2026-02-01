*&---------------------------------------------------------------------*
*& REPORT ZTYPES_07_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_07_KJH.

* DATA 선언 *

DATA: BEGIN OF GS_LIST,
        ID TYPE I,
        NAME TYPE STRING,
        AGE TYPE I,
      END OF GS_LIST.

GS_LIST-ID   = 1.
GS_LIST-NAME = '감자'.
GS_LIST-AGE  = 30.


WRITE: / 'ID:',   GS_LIST-ID,
       / 'NAME:', GS_LIST-NAME,
       / 'AGE:',  GS_LIST-AGE.