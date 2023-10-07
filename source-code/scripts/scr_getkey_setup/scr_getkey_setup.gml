function scr_getkey_setup(){
	
	#macro pressed 1
	#macro released 2
	#macro direct 3
	
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
		
		global.key1.up=ini_read_real("key1","up",ord("W"))
		global.key1.left=ini_read_real("key1","left",ord("A"))
		global.key1.down=ini_read_real("key1","down",ord("S"))
		global.key1.right=ini_read_real("key1,","right",ord("D"))
		
		global.key1.shoot=ini_read_real("key1","attack1",mouse_left)
		global.key1.cast=ini_read_real("key1","attack2",mouse_left)
		global.key1.accept=ini_read_real("key1","accept",vk_space)
		
		global.key1.restart=ini_read_real("key1","restart",ord("R"))
		
		global.key1.escape=ini_read_real("key1","escape",vk_escape)
		
		// secondary keys definition
		
		global.key2.up=ini_read_real("key1","up",vk_up)
		global.key2.left=ini_read_real("key1","left",vk_left)
		global.key2.down=ini_read_real("key1","down",vk_down)
		global.key2.right=ini_read_real("key1,","right",vk_right)
		
		global.key2.shoot=ini_read_real("key1","attack1",unset)
		global.key2.cast=ini_read_real("key1","attack2",unset)
		global.key2.accept=ini_read_real("key1","accept",vk_enter)
		
		global.key2.restart=ini_read_real("key1","restart",unset)
		
		global.key2.escape=ini_read_real("key1","escape",unset)
		
	ini_close()
	
}