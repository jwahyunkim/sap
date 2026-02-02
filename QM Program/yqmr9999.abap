REPORT yqmr9999.

"---------------------------------------------------
" 타입 정의
"---------------------------------------------------
TYPES: BEGIN OF ty_gt.
         INCLUDE STRUCTURE yqmt9999.
TYPES:   name1 TYPE t001w-name1, " 플랜트 이름 (JOIN된 필드)
       END OF ty_gt.

DATA: gt_list TYPE TABLE OF ty_gt,
      ls_list TYPE ty_gt.

"---------------------------------------------------
" (ALV용 전역 선언)  <<== ALV 때문에 추가 필요
"---------------------------------------------------
DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_grid      TYPE REF TO cl_gui_alv_grid,
      gv_okcode    TYPE sy-ucomm.

DATA: gt_fcat TYPE lvc_t_fcat,
      gs_fcat TYPE lvc_s_fcat,
      gs_layo TYPE lvc_s_layo.

"---------------------------------------------------
" Selection screen
"---------------------------------------------------
SELECTION-SCREEN BEGIN OF LINE.
  PARAMETERS: sel_v1 RADIOBUTTON GROUP r1 DEFAULT 'X'.
  SELECTION-SCREEN COMMENT 10(20) FOR FIELD sel_v1.

  PARAMETERS: sel_v2 RADIOBUTTON GROUP r1.
  SELECTION-SCREEN COMMENT 35(20) FOR FIELD sel_v2.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN SKIP.

PARAMETERS: plant TYPE yqmt9999-werks OBLIGATORY.
SELECT-OPTIONS: prpcd FOR ls_list-prpcd.
PARAMETERS: prptxt TYPE yqmt9999-prptxt.

DATA: gv_property_type TYPE ty_gt-prptype.

SELECTION-SCREEN BEGIN OF LINE.
  SELECTION-SCREEN COMMENT 1(15) TEXT-000.

  PARAMETERS: p_type1 RADIOBUTTON GROUP r2 DEFAULT 'X'.
  SELECTION-SCREEN COMMENT 20(15) FOR FIELD p_type1.

  PARAMETERS: p_type2 RADIOBUTTON GROUP r2.
  SELECTION-SCREEN COMMENT 45(15) FOR FIELD p_type2.

  PARAMETERS: p_type3 RADIOBUTTON GROUP r2.
  SELECTION-SCREEN COMMENT 62(15) FOR FIELD p_type3.
SELECTION-SCREEN END OF LINE.

"---------------------------------------------------
" START OF SELECTION
"---------------------------------------------------

START-OF-SELECTION.

  " 라디오 버튼 → prptype 값 매핑
  IF p_type1 = abap_true.
    gv_property_type = ''.
  ELSEIF p_type2 = abap_true.
    gv_property_type = 'N'.
  ELSEIF p_type3 = abap_true.
    gv_property_type = 'L'.
  ENDIF.

  CLEAR gt_list[].

  SELECT a~*, b~name1
    FROM yqmt9999 AS a
    INNER JOIN t001w AS b ON a~werks = b~werks
*    WHERE a~werks    = @plant
*      AND a~prpcd    IN @prpcd
*      AND a~prptxt   = @prptxt
*      AND ( a~prptype = @gv_property_type OR @gv_property_type IS INITIAL )
  INTO CORRESPONDING FIELDS OF TABLE @gt_list.

  "---------------------------------------------------
  " ALV 필드카탈로그(LVC): 일부 필드만 수정 가능
  "---------------------------------------------------
  CLEAR gt_fcat.

  DEFINE add_field.
    CLEAR gs_fcat.
    gs_fcat-fieldname = &1.
    gs_fcat-coltext   = &2.
    gs_fcat-col_pos   = &3.
    gs_fcat-edit      = &4.      " 'X' or space
    APPEND gs_fcat TO gt_fcat.
  END-OF-DEFINITION.

  add_field:
    'WERKS'     'Plant'            1  space,
    'NAME1'     'Plant Name'       2  space,
    'PRPCD'     'Property Code'    3  space,
    'PRPTXT'    'Property Desc'    4  'X',
    'SHTTXT'    'Short Desc'       5  'X',
    'RPTTXT'    'Report Desc'      6  'X',
    'PRPTYPE'   'Property Type'    7  'X',
    'METHOD'    'Test Method'      8  'X',
    'CGROUP'    'Group'            9  'X',
    'EXCHAR'    'Expression Char.' 10 'X',
    'REMARK'    'Remark'           11 'X',
    'ERDAT'     'Created On'       12 space,
    'ERZET'     'Created Time'     13 space,
    'ERNAM'     'Created By'       14 space,
    'AEDAT'     'Changed On'       15 space.

  CLEAR gs_layo.
  gs_layo-edit = abap_true.

  " ★ 화면이 1000만 있으므로 1000 호출
  CALL SCREEN 0100.

  "===================================================
  " Screen 1000 : PBO/PAI Modules
  "===================================================

MODULE status_1000 OUTPUT.
  " SE41에서 만든 GUI Status: ZALV (SAVE/ADD/BACK 등 버튼 포함)
  SET PF-STATUS 'ZALV'.

  IF go_container IS INITIAL.
    " Screen 1000 Layout에 Custom Control 이름이 CC_ALV 여야 함
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_container.

    CALL METHOD go_grid->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layo
      CHANGING
        it_outtab       = gt_list
        it_fieldcatalog = gt_fcat.
  ENDIF.
ENDMODULE.

MODULE user_command_1000 INPUT.
  gv_okcode = sy-ucomm.
  CLEAR sy-ucomm.

  " ALV에서 수정한 값을 gt_list에 반영
  IF go_grid IS BOUND.
    go_grid->check_changed_data( ).
  ENDIF.

  CASE gv_okcode.
    WHEN 'ADD'.
      APPEND INITIAL LINE TO gt_list.
      go_grid->refresh_table_display( ).

    WHEN 'SAVE'.
      " 수정된 gt_list를 DB에 저장 (UPDATE/INSERT)
      DATA ls_db TYPE yqmt9999.
      FIELD-SYMBOLS: <f_mandt> TYPE any.

      LOOP AT gt_list ASSIGNING FIELD-SYMBOL(<ls>).
        CLEAR ls_db.
        MOVE-CORRESPONDING <ls> TO ls_db.  " NAME1은 자동 제외

        " 키 필드 체크(테이블 키에 맞게 조정 가능)
        IF ls_db-werks IS INITIAL OR ls_db-prpcd IS INITIAL.
          CONTINUE.
        ENDIF.

        " MANDT 필드가 있는 경우만 채움
        ASSIGN COMPONENT 'MANDT' OF STRUCTURE ls_db TO <f_mandt>.
        IF sy-subrc = 0 AND <f_mandt> IS ASSIGNED AND <f_mandt> IS INITIAL.
          <f_mandt> = sy-mandt.
        ENDIF.

        MODIFY yqmt9999 FROM ls_db.
      ENDLOOP.

      COMMIT WORK.
      MESSAGE 'Saved.' TYPE 'S'.

      go_grid->refresh_table_display( ).

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.