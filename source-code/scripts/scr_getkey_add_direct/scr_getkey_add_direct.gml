function scr_getkey_add_direct(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check_direct(__key)
	else throw("Error!")
	
}