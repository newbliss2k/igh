global.inventory={}

with global.inventory {
	
	
	items[10]=1
	items[20]=20
	
	
}

function o_chara_step_debug() {
	
	if getkey("ctrl") and getkey("restart",pressed) {
		x=mouse_x
		y=mouse_y
	}
	
}

function o_chara_step_start() {
	
	state_prev=state
	if place_meeting(x,y+1,o_solid) state="ground" else if !(state="air") state="jump"
	
	
	
}

function o_chara_step_phy_grab(){

	grab_prev=grab
	
	if place_meeting(x+abs(control_walk()),y,o_solid_slip) or place_meeting(x-abs(control_walk()),y,o_solid_slip) {
		if state="jump" or state="air" {
			grab=place_meeting(x+abs(control_walk()),y,o_solid_slip)-place_meeting(x-abs(control_walk()),y,o_solid_slip)
		}
	}
	/*else */if place_meeting(x+grab,y,o_solid_slip) {
		
	}
	else grab=0
	
	if state="ground" grab=0

	if (grab_prev=0 & !(grab=0)) {
		unslip_locked=7
		unslip_locked_pressed=1
	}

	mvt_locked = max(mvt_locked - 1, 0)

	if control_walk(pressed)=grab unslip_locked_pressed=0
	if control_walk()=-grab and unslip_locked_pressed=0 unslip_locked--

	if grab=0 unslip_locked=0
	
}

function o_chara_step_phy_crouch(_control_walk=0,_control_jump=0){
	
	crouch_timer=max(crouch_timer - 1, 0)
	crouch_timer_flip=max(crouch_timer_flip - 1, 0)
	
	if (state="ground") and ((crouch_state=0 or crouch_state="post") or (crouch_state="crouch" and crouch_timer<10)) if ((_control_jump=1) and !(_control_walk=0)) { //if ((control_jump(pressed)=1) and !(control_walk()=0)) or ((control_jump()=1) and !(control_walk(pressed)=0)) {
		set_sprite(s_zero_precrouch,0)
		crouch_state="pre"
		crouch_timer=8
		//x_speed=0
		crouch_dir=_control_walk
		
		key_buffer_down=0
	}
	
	if (crouch_state="pre") and (crouch_timer<1) {
		set_sprite(s_zero_crouch,0)
		crouch_state="crouch"
		crouch_timer=28
		x_speed=crouch_timer*crouch_dir*0.5//*crouching_power
	}
	
	if ((crouch_state="crouch") and (crouch_timer<1)) or ((crouch_state="flip") and (crouch_timer_flip<1)) {
		set_sprite(s_zero_postcrouch,0)
		crouch_state="post"
		crouch_timer=5
		
	}
	
	
}

function o_chara_step_phy_walk(_control_walk=0){
	
	var _mvt_locked
	if mvt_locked<=0 _mvt_locked=1
	else _mvt_locked=0.2
	
	if (unslip_locked<=0) and (crouch_timer<=15 or !(crouch_state="crouch")) {
		if sign(x_speed)=-_control_walk x_speed+=walk_turnaround*_control_walk*_mvt_locked
		else {
			if abs(x_speed)<1.5 x_speed+=walk_acc1*_control_walk*_mvt_locked else if abs(x_speed)<x_speed_max x_speed+=walk_acc2*_control_walk*_mvt_locked
		}
	}
	
	if crouch_timer<=15 switch state {
		case "ground": if abs(x_speed)>x_speed_max x_speed=sign(x_speed)*x_speed_max; break;
		default: if abs(x_speed)>x_speed_max_air x_speed=sign(x_speed)*x_speed_max_air; break;
	}
	
}

function o_chara_step_phy_friction(_control_walk=0){
	
	if !(crouch_state="crouch") if _control_walk=0 { if abs(x_speed)>walk_friction
		switch state {
			case "ground": x_speed-=walk_friction*sign(x_speed); break;
			default: x_speed-=walk_airres*sign(x_speed); break;
		}
	else x_speed=0 }
	
	if crouch_timer>0 { if abs(x_speed)>crouching_friction x_speed-=crouching_friction*sign(x_speed) }
		
	
}

function o_chara_step_phy_jump(){
	
	if place_meeting(x,y+1,o_solid) and (timer_jump<0) state="ground" else if !(state="air") state="jump"
	
	if state="ground" timer_coyot=timer_coyot_max
	if (state="ground") jumps=jumps_max
	if !(grab=0) jumps=1
	if (control_jump(pressed)=-1 and control_jump()=-1) {
		switch grab {
			case 0:
				if timer_coyot>0 or jumps>0 {
					
					if !(crouch_state=0) {
						crouch_state=0
						crouch_timer=0
						set_sprite(s_zero_jump,0)
					}
					
					timer_jump=timer_jump_max
					timer_coyot=0
					jumps--
				}
				break;
			default:
			state="jump"
			crouch_state="flip"
			crouch_timer_flip=25
			set_sprite(s_zero_flip,0)
			x_speed=-grab_jump_h*grab
			y_speed=-grab_jump
			mvt_locked=mvt_locked_max
			key_buffer_up=0
			grab=0
			break;
		}
	}
	if timer_coyot>0 timer_coyot--

	if timer_jump=0 {
		
		instance_create_layer(x,y,"Player",o_jumpcloud)
		timer_jump=-1
		timer_coyot=0
		state="jump"
		if !(control_walk()=0) x_speed=jump_h*control_walk()
		if jumps=1 y_speed=-jump else y_speed=1.1*-jump
		key_buffer_up=0
	}
	else timer_jump--

	if ((state="jump") & (control_jump()>-1)) state="air"
	
	if y_speed>y_speed_max y_speed=y_speed_max
	
}

function o_chara_step_phy_gravity(_control_jump=0){
	
	// Этот кусок кода нужен для физики прилипания к стене
	
	var _g_grab
	var _g_grab_jump
	var _g_grab_fall
	if grab=0 or _control_jump=1 {
		_g_grab=1
		_g_grab_jump=1
		_g_grab_fall=1
		if _control_jump=1 {
			_g_grab=1.8
			_g_grab_jump=1.8
			_g_grab_fall=1.8
		}
	}
	else {
		_g_grab=0.4
		_g_grab_jump=0.6
		_g_grab_fall=0.2
	}
	
	// Это уже гравитация

	if (state="jump") {
		y_speed+=g*_g_grab_jump
		if (y_speed>-1) state="air"
	}
	else {
		if (y_speed<0) y_speed+=g*_g_grab*g_factor_jump
		else y_speed+=g*_g_grab_fall*g_factor_air
	}
	
	//y_speed+=g
	
}

function o_chara_step_attack(){
	
	weapon_direction=point_direction(x,y-30,mouse_x,mouse_y)
	
	if recharge<1 {
		
		var _attack
		if global.osflavor=4 _attack = o_control2.attack
		else _attack = getkey("atk")
		
		if _attack {
			recharge = 20//dmm_recharge
			//sprite_index = costume(chara,inv,"attack")
			
			var _bullet=instance_create_layer(x,y-30,"Player",o_bullet)
			var _range
			if weapon_range=0 _range=0 else _range=+random_range(-weapon_range,weapon_range)
			_bullet.image_angle=weapon_direction+_range//(-dmm_range,dmm_range)
			_bullet.spd=50
			
			audio_play_sound(snd_9mm,1,0,0.5)
			instance_create_depth(x,y,0,o_shake)
			
		}
	}
		else recharge--
	
}

function o_chara_step_behaviour(){
	
	if place_meeting(x,y,o_danger){
		
		
		
	}
	
}

function o_chara_step_phy_apply_speed(){
	
	if !(place_meeting(x+x_speed,y,o_solid)) x+=x_speed
	else {
		while !(place_meeting(x+sign(x_speed),y,o_solid)) x+=sign(x_speed)
		x_speed=0
	}
	
	if !place_meeting(x,y+y_speed,o_solid) y+=y_speed
	else {
		while !place_meeting(x,y+sign(y_speed),o_solid) y+=sign(y_speed)
		y_speed=0
	}
	
}






function o_chara_step_dead(){
	
	if force_applied=0 {
		
		x_speed=-x_dead_force_power*dcos(force_dir)
		y_speed=y_dead_force_power*dsin(force_dir)
		
		force_applied=1
	}
	
}