function o_handler_draw64_ui_menu_script(_alpha){
	
	if global.menu._selector<0 global.menu._selector=0
	if global.menu._selector>array_length(options)-1 global.menu._selector=array_length(options)-1
	
	draw_set_alpha(_alpha)
	
	if getkey("up",pressed) {
				if global.menu._selector=0 global.menu._selector=array_length(options)-1
				else global.menu._selector--
			}
			
			if getkey("down",pressed) {
				if global.menu._selector=array_length(options)-1 global.menu._selector=0
				else global.menu._selector++
			}
			
			if getkey("enter",released) or getkey("atk",released) {
				options[global.menu._selector,1]()
				if global.menu._selector<0 global.menu._selector=0
				if global.menu._selector>array_length(options)-1 global.menu._selector=array_length(options)-1
				getkey("enter",clear)
				getkey("atk",clear)
				mouse_clear(mouse_left)
			}
			
			draw_set_font(font_default24)
		
			draw_set_color(accent_color)
			var _w = string_width(options[global.menu._selector][0])
			if align=0 {
				global.menu._selector_x1=lerp(global.menu._selector_x1,x_padding-_w/2-global.menu._selector_x_padding,0.5)
				global.menu._selector_x2=lerp(global.menu._selector_x2,x_padding+_w/2+global.menu._selector_x_padding,0.5)
			}
			else {
				global.menu._selector_x1=lerp(global.menu._selector_x1,x_padding-global.menu._selector_x_padding,0.5)
				global.menu._selector_x2=lerp(global.menu._selector_x2,x_padding+global.menu._selector_x_padding+_w,0.5)
			}
			
			global.menu._selector_y1=lerp(global.menu._selector_y1,y_padding+(global.menu._selector+0)*y_string_h-5,0.5)
			global.menu._selector_y2=lerp(global.menu._selector_y2,y_padding+(global.menu._selector+1)*y_string_h-5,0.5)
		
			draw_rectangle(global.menu._selector_x1,global.menu._selector_y1,global.menu._selector_x2,global.menu._selector_y2,0)
		
			for (var _i=0;_i<array_length(options);_i++) {
				
				var _wf = string_width(options[_i][0])
				
				draw_set_color(accent_color*!(global.menu._selector=_i))
				if align=0 {
					draw_text(x_padding-_wf/2,y_padding+_i*y_string_h,options[_i][0])
				}
				else {
					draw_text(x_padding,y_padding+_i*y_string_h,options[_i][0])
				}
				
				if (device_mouse_y_to_gui(0)>y_padding+_i*y_string_h-5) and (device_mouse_y_to_gui(0)<y_padding+(_i+1)*y_string_h-5) {
					global.menu._selector=_i
				}
				
			}
			
			var _wf = string_width(title)
			
			draw_set_color(accent_color)
			draw_text(x_padding-_wf/2,title_y,title)
			
			if !(display_text=0) {
				_wf = string_width(display_text)
				draw_text(x_padding-_wf/2,display_text_y,display_text)
				
			}
			
			draw_set_alpha(1)
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
	
	var _screen = struct_get(global.menu,global.game.screen)
	with _screen {
		
		if global.game.pause=1 {
			draw_set_color(c_blue)
			draw_set_alpha(0.25)
			draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),0)
			
			draw_set_color(c_black)
			draw_set_alpha(0.5)
			draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),0)
		}
		
		if (global.game.pause=1) or (room=r_menu_main) o_handler_draw64_ui_menu_script(1)
	}
	
	
	
	// GAME OVER UI
	if instance_exists(o_chara_dead){
		draw_set_font(font_default12)
		draw_set_alpha(1)
		draw_set_color(c_white)
		draw_text((display_get_gui_width()-string_width("GAME OVER! Press R to restart"))/2,display_get_gui_height()/2,"GAME OVER! Press R to restart")
	}
	
	with global.game {
		var_mouse_x=device_mouse_x_to_gui(0)
		var_mouse_y=device_mouse_y_to_gui(0)
		draw_sprite_ext(s_aim,-1,var_mouse_x,var_mouse_y,3,3,0,c_white,1)
	}
	
}

function o_handler_draw64_default(){
	
	log_console()
	
}