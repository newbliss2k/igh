if room=r_init {
	
	scr_getkey_setup()
	room_goto(r_gameplay_test)
	
}

if room=r_gameplay_test {
	
	instance_create_depth(50,50,0,o_chara)
	
}

global.osflavor=os_type
global.aspectratio=display_get_width()/display_get_height()
instance_create_depth(20,140,-15999,o_control)