function scr_o_chara_step_debug(){
	
	if getkey("res") {
		x	=	mouse_x
		y	=	mouse_y
	}

	if getkey("debug_gravity",pressed) {
		y_gravity=-y_gravity
		y_jump=-y_jump
		y+=sign(y_gravity)*sprite_get_height(mask_index)*2
	}
	
}