function scr_getkey_add_pressed(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check_pressed(__key)
	else return mouse_check_button_pressed(__key+5)
	
}