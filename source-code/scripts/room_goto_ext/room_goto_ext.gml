function room_goto_ext(_room,_changer="darken",_timer=30){
	
	global.game.restarted=0
	
	switch _changer {
		
		case 0:
			room_goto(_room)
		break
		
		case "darken":
			with o_handler {
				var _inst
				_inst=instance_create_depth(0,0,-15999,o_fx_darken_in)
				_inst.room_goto_index=_room
				_inst.timer=_timer
				_inst.timer_max=30
			}
		break
		
	}
}