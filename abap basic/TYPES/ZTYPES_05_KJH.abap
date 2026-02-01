*&---------------------------------------------------------------------*
*& Report ZTYPES_05_KJH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZTYPES_05_KJH.


* TYPES BEGIN OF *

TYPES : BEGIN OF TY_S_LIST,
          ID TYPE I,
          NAME TYPE STRING,
        END OF TY_S_LIST.


DATA:
  GS_EMP TYPE TY_S_LIST.

GS_EMP-ID = 1.
GS_EMP-NAME = '감자'.


WRITE: / 'ID:',   GS_EMP-ID,
       / 'Name:' ,GS_EMP-NAME.