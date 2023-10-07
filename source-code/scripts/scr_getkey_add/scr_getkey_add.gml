function scr_getkey_add(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check(__key)
	else return mouse_check_button(__key+5)
	
}