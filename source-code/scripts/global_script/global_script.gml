global.game={}
with global.game {
	
	global.game.pause=0
	global.game.animspeed=1
	
}

global.mainmenu={}
with global.mainmenu {
	
	x_padding=960
	y_padding=500
	
	y_string_h=100
	
	accent_color=c_white
	
	options=
	[
		["New game",function _global_mainmenu_new_game(){
			room_goto(r_gameplay_test)
		},],
		
		["Level select",function _global_mainmenu_level_select(){
			
		},],
		
		["Settings",function _global_mainmenu_settings(){
			
		},],
	]
	
	selector=0
	selector_x_padding=25
	
	draw_set_font(font_big)
	draw_set_color(accent_color)
	draw_set_alpha(0.75)
	
	var _w = string_width(options[selector][0])
	
	selector_x1=x_padding-_w/2-selector_x_padding
	selector_x2=x_padding+_w/2+selector_x_padding
	selector_y1=y_padding+(selector+0)*y_string_h-5
	selector_y2=y_padding+(selector+1)*y_string_h-5
	
}

global.pausemenu={}
with global.pausemenu {
	
	x_padding=display_get_gui_width()/2
	y_padding=500
	
	y_string_h=100
	
	accent_color=c_blue
	
	options=
	[
		["Continue",function _global_pausemenu_continue(){
			global.game.pause=0
		},],
		
		["Settings",function _global_pausemenu_settings(){
			log_push("Settings aren't complete yet")
		},],
		
		["Exit to Main Menu",function _global_pausemenu_exit(){
			room_goto(r_init)
		},],
	]
	
	selector=0
	selector_x_padding=25
	
	draw_set_font(font_big)
	draw_set_color(accent_color)
	draw_set_alpha(0.75)
	
	var _w = string_width(options[selector][0])
	
	selector_x1=x_padding-_w/2-selector_x_padding
	selector_x2=x_padding+_w/2+selector_x_padding
	selector_y1=y_padding+(selector+0)*y_string_h-5
	selector_y2=y_padding+(selector+1)*y_string_h-5
	
}