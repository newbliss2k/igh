global.depth=-14000

global.game={}
with global.game {
	
	depth=-14000
	pause=0
	player_control=0
	screen="main"
	screen_history=[]
	animspeed=1
	
	restarted=0
	chara_restart_x=0
	chara_restart_y=0
}

global.menu={}
global.menu._selector=0
global.menu._selector_x_padding=25

function _global_menu_setup(){
	
	if !variable_instance_exists(self,"x_padding") x_padding=960
	if !variable_instance_exists(self,"y_padding") y_padding=500
	
	draw_set_font(font_default24)
	if !variable_instance_exists(self,"y_string_h") y_string_h=string_height("A")*1.2
	
	if !variable_instance_exists(self,"accent_color") accent_color=c_white
	
	draw_set_font(font_default24)
	draw_set_color(accent_color)
	draw_set_alpha(0.75)
	
	draw_set_alpha(1)
	
	if !variable_instance_exists(self,"title") title="Default title"
	if !variable_instance_exists(self,"title_y") title_y=150
	
	if !variable_instance_exists(self,"display_text") display_text=0
	if !variable_instance_exists(self,"display_text_y") display_text_y=0
	
	if !variable_instance_exists(self,"align") align=0
	
}

global.menu.main={}
with global.menu.main {
	
	options=
	[
		["New game",function _global_menu_main_new_game(){
			room_goto_ext(r_game_test)
			global.game.screen="pause"
		},],
		
		["Level select",function _global_menu_main_level_select(){
			array_push(global.game.screen_history,global.game.screen)
			global.game.screen="levels"
		},],
		
		["Settings",function _global_menu_main_settings(){
			array_push(global.game.screen_history,global.game.screen)
			global.game.screen="settings"
		},],
		
		["Read me",function _global_menu_main_info(){
			array_push(global.game.screen_history,global.game.screen)
			global.game.screen="info"
		},],
		
		["End Program",function _global_menu_main_endprogram(){
			game_end()
		},],
	]
	
	accent_color=c_white
	title="SURVEY_PROGRAM"
	
	_global_menu_setup()
	
	draw_set_font(font_default24)
	var _w = string_width(options[global.menu._selector][0])
	
	if align=0 {
		global.menu._selector_x1=x_padding-_w/2-global.menu._selector_x_padding
		global.menu._selector_x2=x_padding+_w/2+global.menu._selector_x_padding
		align=0
	}
	else if align=-1 {
		global.menu._selector_x1=x_padding-global.menu._selector_x_padding
		global.menu._selector_x2=x_padding+global.menu._selector_x_padding+_w
		align=-1
	}
	
	global.menu._selector_y1=y_padding+(global.menu._selector+0)*y_string_h-5
	global.menu._selector_y2=y_padding+(global.menu._selector+1)*y_string_h-5
	
}

global.menu.pause={}
with global.menu.pause {
	
	options=
	[
		["Continue",function _global_menu_pause_continue(){
			global.game.pause=0
		},],
		
		["Settings",function _global_menu_pause_settings(){
			array_push(global.game.screen_history,global.game.screen)
			global.game.screen="settings"
		},],
		
		["Exit to Main Menu",function _global_menu_pause_exit(){
			room_goto_ext(r_menu_main,0)
			global.game.screen="main"
		},],
		
		["End Program",function _global_menu_pause_endprogram(){
			game_end()
		},],
	]
	
	accent_color=c_blue
	title="Paused"
	
	_global_menu_setup()
}

global.menu.settings={}
with global.menu.settings {
	
	options=
	[
		["Back",function _global_menu_settings_back(){
			global.game.screen=array_pop(global.game.screen_history)
		},],
		
		["Point 1",function _global_menu_settings_1(){
			log_push("You clicked the point 1")
		},],
		
		["Point 2",function _global_menu_settings_2(){
			log_push("You clicked the point 2 lololo")
		},],
		
		["Point 3",function _global_menu_settings_3(){
			log_push("ZZ V Z V GOIDA SVO СВО ZA НАШИХ Смартфон vivo")
		},],
	]
	
	accent_color=c_white
	title="Settings"
	
	_global_menu_setup()
}

global.menu.levels={}
with global.menu.levels {
	
	options=
	[
		["Back",function _global_menu_levels_back(){
			global.game.screen=array_pop(global.game.screen_history)
		},],
		
		["Level 1 - Test",function _global_menu_levels_1(){
			log_push("Entering Level 1")
			room_goto_ext(r_game_test)
		},],
		
		["Level 2 - No level",function _global_menu_levels_3(){
			log_push("No level 2 yet((")
		},],
	]
	
	align=-1
	x_padding=500
	
	accent_color=c_white
	title="Level Select"
	
	_global_menu_setup()
}

global.menu.info={}
with global.menu.info {
	
	options=
	[
		["Back",function _global_menu_info_back(){
			global.game.screen=array_pop(global.game.screen_history)
		},],
	]
	
	y_padding=200
	
	accent_color=c_white
	title="Read Me"
	
	display_text_y=300
	display_text=@"Claws of hell
Torn from the night
Crimson stain
Eternal blight

Demon spawn
Die in the fire
Severed wings
No escape, no desire

Burning eyes
In the abyss
Torn apart
No second kiss"
	
	_global_menu_setup()
}