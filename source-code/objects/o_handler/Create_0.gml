if room=r_init {
	
	scr_getkey_setup()
	room_goto(r_gameplay_test)
	
}

if room=r_gameplay_test {
	
	instance_create_depth(50,50,0,o_sora)
	
}