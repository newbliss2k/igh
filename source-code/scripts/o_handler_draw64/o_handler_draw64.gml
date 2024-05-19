global.mainmenu={}

with global.mainmenu {
	
	x_padding=960
	y_padding=500
	
	y_string_h=100
	
	accent_color=c_white
	
	options=
	[
		["New game",0],
		["Level select",0],
		["Settings",0],
	]
	
	selector=0
	selector_x1=0
	selector_x2=0
	selector_y1=0
	selector_y2=0
	selector_x_padding=25
	//selector_y_padding=
}

// DRAW64 FUNCTIONS

function o_handler_draw64_ui(){
	
	// MENU UI
	if room=r_init {
		
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