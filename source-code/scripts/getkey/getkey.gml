function getkey(_key,_type=0){
	
	var _key1=variable_struct_get(global.key1,_key)
	var _key2=variable_struct_get(global.key2,_key)
	//show_debug_message(string(mb_left)+" "+string(mb_middle)+" "+string(mb_right)+" "+string(mb_any)+" "+string(mb_none))
	//show_debug_message("1:"+string(_key1)+" 2:"+string(_key2)+" 0:"+string(_key))
	
	switch _type {
		
		case 0: if ((scr_getkey_add(_key1)) || (scr_getkey_add(_key2))) return 1 else return 0
		
		case pressed: if ((scr_getkey_add_pressed(_key1)) || (scr_getkey_add_pressed(_key2))) return 1 else return 0
		
		case released: if ((scr_getkey_add_released(_key1)) || (scr_getkey_add_released(_key2))) return 1 else return 0
			
		case direct: if ((scr_getkey_add_direct(_key1)) || (scr_getkey_add_direct(_key2))) return 1 else return 0
		
		}

}