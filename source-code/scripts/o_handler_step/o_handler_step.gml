function camera_chara() {
	
	if instance_exists(o_chara) {
		camera_chara_error_threw=0
		return o_chara
	}
	else if instance_exists(o_chara_dead) {
		camera_chara_error_threw=0
		return o_chara_dead
	}
	else if camera_chara_error_threw=0 {
		camera_chara_error_threw=1
		log_push("ERROR: No object to camera follow!")
		return self
	}
}

function o_handler_step_control() {
	
	if getkey("esc") and getkey("shift") game_end()
	
	if getkey("esc",pressed) {
		
		switch room {
			case r_menu_main:
			
			break
			default: with global.game if pause pause=0 else pause=1
		}
	}
		
	if getkey("restart",pressed) {
			
			room_restart_ext()
			
	}
	
	if room=r_menu_main global.game.pause=0
	
}

function o_handler_step_camera() {
	
	var _view_x = camera_get_view_x(view_camera[0]);
	var _view_y = camera_get_view_y(view_camera[0]);
	var _view_w = camera_get_view_width(view_camera[0]);
	var _view_h = camera_get_view_height(view_camera[0]);
	
	if getkey("shift") {
		_mouse_x=(device_mouse_x_to_gui(0)/3*2 - (_view_w * 0.5))
		_mouse_y=(device_mouse_y_to_gui(0)/3*2 - (_view_h * 0.5))
	} else {
		_mouse_x=(device_mouse_x_to_gui(0)/3*2 - (_view_w * 0.5))/_mouse_factor
		_mouse_y=(device_mouse_y_to_gui(0)/3*2 - (_view_h * 0.5))/_mouse_factor
	}
	
	var _goto_x = camera_chara().x + _mouse_x - (_view_w * 0.5)
	var _goto_y = camera_chara().y + _mouse_y - (_view_h * 0.5)
	
	if (_goto_x + _view_w) > room_width _goto_x = room_width - _view_w
	if (_goto_y + _view_h) > room_height _goto_y = room_height - _view_h
	
	if _goto_x < 0 _goto_x = 0
	if _goto_y < 0 _goto_y = 0
	
	var _new_x = lerp(_view_x, _goto_x, 0.1);
	var _new_y = lerp(_view_y, _goto_y, 0.1);
	
	var _mod_x = 0 + shake_x
	var _mod_y = 0 + shake_y
	
	camera_set_view_pos(view_camera[0], _new_x + _mod_x, _new_y + _mod_y)
	
}

function o_handler_step_shading_shit() {
	
	if getkey("enter",pressed) {
		//randomize lights
		var _brightness;
		for (var _i = 0; _i < ( num_lights * 6 ); _i += 6) {
			light_array[_i] = random_range(0, room_width ); //x
			light_array[_i+1] = random_range( 0, room_height ); //y
			light_array[_i+2] = random_range(20,250); //z
			_brightness = power( random( 1 ), 3 ) * 6000 + 1500;
			light_array[_i+3] = random(1) * _brightness; //r
			light_array[_i+4] = random(1) * _brightness; //g
			light_array[_i+5] = random(1) * _brightness; //b
		}
	
	}
	
}