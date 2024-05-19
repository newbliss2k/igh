// DRAW FUNCTIONS

function o_handler_draw_begin(){
	
	//--------------------------------------------------------------
    shader_reset();
	//--------------------------------------------------------------
	
	if room=r_init {
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
	
	// MENU UI
	if room=r_init {
		
		global.game.pause=0
		with global.mainmenu {
			
			if getkey("up",pressed) {
				if selector=0 selector=array_length(options)-1
				else selector--
			}
			
			if getkey("down",pressed) {
				if selector=array_length(options)-1 selector=0
				else selector++
			}
			
			if getkey("enter",pressed) {
				options[selector,1]()
			}
			
			draw_set_font(font_big)
		
			draw_set_color(accent_color)
			var _w = string_width(options[selector][0])
			
			selector_x1=lerp(selector_x1,x_padding-_w/2-selector_x_padding,0.5)
			selector_x2=lerp(selector_x2,x_padding+_w/2+selector_x_padding,0.5)
			selector_y1=lerp(selector_y1,y_padding+(selector+0)*y_string_h-5,0.5)
			selector_y2=lerp(selector_y2,y_padding+(selector+1)*y_string_h-5,0.5)
		
			draw_rectangle(selector_x1,selector_y1,selector_x2,selector_y2,0)
		
			for (var _i=0;_i<array_length(options);_i++) {
				
				var _wf = string_width(options[_i][0])
				
				draw_set_color(accent_color*!(selector=_i))
				draw_text(x_padding-_wf/2,y_padding+_i*y_string_h,options[_i][0])
				
			}
		}
		
	}
	
	// PAUSE MENU UI
	if global.game.pause=1 {
		
		with global.pausemenu {
			
			draw_set_color(c_blue)
			draw_set_alpha(0.25)
			
			draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),0)
			
			if getkey("up",pressed) {
				if selector=0 selector=array_length(options)-1
				else selector--
			}
			
			if getkey("down",pressed) {
				if selector=array_length(options)-1 selector=0
				else selector++
			}
			
			if getkey("enter",pressed) {
				options[selector,1]()
			}
			
			draw_set_font(font_big)
			
			draw_set_color(accent_color)
			draw_set_alpha(0.75)
			
			var _w = string_width(options[selector][0])
			
			selector_x1=lerp(selector_x1,x_padding-_w/2-selector_x_padding,0.5)
			selector_x2=lerp(selector_x2,x_padding+_w/2+selector_x_padding,0.5)
			selector_y1=lerp(selector_y1,y_padding+(selector+0)*y_string_h-5,0.5)
			selector_y2=lerp(selector_y2,y_padding+(selector+1)*y_string_h-5,0.5)
		
			draw_rectangle(selector_x1,selector_y1,selector_x2,selector_y2,0)
		
			for (var _i=0;_i<array_length(options);_i++) {
				
				var _wf = string_width(options[_i][0])
				
				draw_set_color(accent_color*!(selector=_i))
				draw_text(x_padding-_wf/2,y_padding+_i*y_string_h,options[_i][0])
				
			}
		}
		
	}
	
	// GAME OVER UI
	if instance_exists(o_chara_dead){
		draw_set_font(font_default)
		draw_set_alpha(1)
		draw_text(200,200,"GAME OVER! Press R to restart")
	}
	
}

function o_handler_draw64_default(){
	
	
	
	log_console()
	
}