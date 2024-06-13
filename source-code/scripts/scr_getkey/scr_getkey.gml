
#macro pressed 1
#macro released 2
#macro direct 3
#macro clear 4
	
#macro mouse_left -4
#macro mouse_right -3
#macro mouse_center -2
#macro mouse_no -5
#macro mouse_any -6
	
#macro unset -7
	
// key load from file
	
ini_open("file_config")
		
	global.key1={}
	global.key2={}
		
	// primary keys definition
		
	global.key1.up=ini_read_real("key1","up",vk_up)
	global.key1.left=ini_read_real("key1","left",vk_left)
	global.key1.down=ini_read_real("key1","down",vk_down)
	global.key1.right=ini_read_real("key1","right",vk_right)
		
	global.key1.enter=ini_read_real("key1","ok",vk_enter)
	global.key1.shift=ini_read_real("key1","back",vk_shift)
	global.key1.ctrl=ini_read_real("key1","menu",vk_control)
		
	global.key1.prev=ini_read_real("key1","prev",ord("Q"))
	global.key1.next=ini_read_real("key1","next",ord("E"))
		
	global.key1.atk=ini_read_real("key1","atk",mouse_left)
		
	global.key1.restart=ini_read_real("key1","res",ord("R"))
	global.key1.esc=ini_read_real("key1","esc",vk_escape)
	global.key1.debug_gravity=ini_read_real("key1","debug gravity",ord("P"))
		
	// secondary keys definition
		
	global.key2.up=ini_read_real("key2","up",ord("W"))
	global.key2.left=ini_read_real("key2","left",ord("A"))
	global.key2.down=ini_read_real("key2","down",ord("S"))
	global.key2.right=ini_read_real("key2","right",ord("D"))
		
	global.key2.enter=ini_read_real("key2","ok",vk_space)
	global.key2.shift=ini_read_real("key2","back",unset)
	global.key2.ctrl=ini_read_real("key2","menu",unset)
		
	global.key2.prev=ini_read_real("key2","prev",unset)
	global.key2.next=ini_read_real("key2","next",unset)
		
	global.key2.atk=ini_read_real("key2","atk",unset)
		
	global.key2.restart=ini_read_real("key2","res",unset)
	global.key2.esc=ini_read_real("key2","esc",unset)
	global.key2.debug_gravity=ini_read_real("key2","debug gravity",unset)
		
ini_close()

function getkey_add(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check(__key)
	else return mouse_check_button(__key+5)
	
}

function getkey_add_pressed(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check_pressed(__key)
	else return mouse_check_button_pressed(__key+5)
	
}

function getkey_add_released(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check_released(__key)
	else return mouse_check_button_released(__key+5)
	
}

function getkey_add_direct(__key){
	
	if !(__key=unset) if __key > -2 return keyboard_check_direct(__key)
	else throw("Error!")
	
}

function getkey(_key,_type=0){
	
	var _key1=variable_struct_get(global.key1,_key)
	var _key2=variable_struct_get(global.key2,_key)
	//show_debug_message(string(mb_left)+" "+string(mb_middle)+" "+string(mb_right)+" "+string(mb_any)+" "+string(mb_none))
	//show_debug_message("1:"+string(_key1)+" 2:"+string(_key2)+" 0:"+string(_key))
	
	switch _type {
		
		case 0: if ((getkey_add(_key1)) || (getkey_add(_key2))) return 1 else return 0
		
		case pressed: if ((getkey_add_pressed(_key1)) || (getkey_add_pressed(_key2))) return 1 else return 0
		
		case released: if ((getkey_add_released(_key1)) || (getkey_add_released(_key2))) return 1 else return 0
			
		case direct: if ((getkey_add_direct(_key1)) || (getkey_add_direct(_key2))) return 1 else return 0
		
		case clear:
			if _key1>0 keyboard_clear(_key1)
			if _key2>0 keyboard_clear(_key2)
			
			
		
		}

}