function o_handler_draw64_ui_menu_script(_alpha){
	
	
}

// DRAW FUNCTIONS

function o_handler_draw_begin(){
	
	//--------------------------------------------------------------
    shader_reset();
	//--------------------------------------------------------------
	
	if room=r_menu_main {
		draw_set_alpha(0.1)
		draw_set_color(c_white)
		var _grid=32
		for (var _i=0; _i<(1920/_grid); _i++) draw_line(_i*_grid,0,_i*_grid,1080)
		for (var _i=0; _i<(1080/_grid); _i++) draw_line(0,_i*_grid,1920,_i*_grid)
		draw_set_alpha(1)
	}
}

// DRAW64 FUNCTIONS

function o_handler_draw64_ui(){
	
	// GAME OVER UI
	if instance_exists(o_chara_dead){
		draw_set_font(font_default)
		draw_set_alpha(1)
		draw_set_color(c_white)
		var _game_over_alert="            Нет... Так ничего не выйдет.\nНажми R, чтобы придумать новый план"
		draw_text((display_get_gui_width()-string_width(_game_over_alert))/2,display_get_gui_height()/2,_game_over_alert)
	}
	
	with global.game {
		var_mouse_x=device_mouse_x_to_gui(0)
		var_mouse_y=device_mouse_y_to_gui(0)
		draw_sprite_ext(s_aim,-1,var_mouse_x,var_mouse_y,3,3,0,c_white,1)
	}
	
}

function o_handler_draw64_default(){
	
	scr_log()
	
}