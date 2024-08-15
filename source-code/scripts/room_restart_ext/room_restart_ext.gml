function room_restart_ext(){
	
	global.game.restarted=1
	
	switch room {
		
		case r_menu_main:
			break;
		
		default:
			room_restart()
			global.game.chara_restart_x=160
			global.game.chara_restart_y=448
		break
		
	}
	
}