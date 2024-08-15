

image_speed=global.game.animspeed*!global.game.pause

if global.game.pause=0 {
	
	if global.game.player_control=1 {
		
		o_solid_locker.x=-48
		
		o_chara_step_debug()
		
		o_chara_step_start()
		
		o_chara_step_phy_grab()
		
		o_chara_step_phy_crouch(control_walk(),control_jump())
		
		o_chara_step_phy_walk(control_walk())
		
		o_chara_step_phy_friction(control_walk())
		
		o_chara_step_phy_jump()
		
		o_chara_step_phy_gravity(control_jump())
		
		o_chara_step_attack()
		
		o_chara_step_behaviour()
		
		o_chara_step_phy_apply_speed()
		
	}
	
	else {
		
		scr_ai_chara()
		
	}
	
			//	--------
			//	Анимации
			//	--------
	
	image_speed=global.game.animspeed*!global.game.pause
	
	if (grab=0) and (crouch_state=0 or crouch_state="post") {
		switch state {
		
			case "ground":
				if  crouch_state="post" or !(state_prev="ground") {
					crouch_state=0
					instance_create_layer(x,y,"Player",o_landcloud)
					set_sprite(s_zero_run_to_idle,0)
				
				} else if !(x_speed=0) {//if x_speed_ascends {
					if sprite_index=s_carol_idle or sprite_index=s_zero_run_to_idle set_sprite(s_zero_idle_to_run,0)
					else if sprite_index=s_zero_idle_to_run { if image_index=4 set_sprite(s_zero_run,0) }
					else if !(sprite_index=s_zero_run) set_sprite(s_zero_run,0)
					else set_sprite(s_zero_run)
				}
				else {//if x_speed_ascends=0 {
					if sprite_index=s_zero_run or sprite_index=s_zero_idle_to_run set_sprite(s_zero_run_to_idle,0)
					else if sprite_index=s_zero_run_to_idle { if image_index=5 set_sprite(s_carol_idle,0)}
					else if !(sprite_index=s_carol_idle) set_sprite(s_carol_idle,0)
					else set_sprite(s_carol_idle)
				}
				break;
	
			case "jump":
				sprite_index=s_zero_jump
				break;
	
			case "air":
				sprite_index=s_zero_fall
				break;
			
			case "door":
				if image_index>7 state="walk"
	
		}
	}
	else {
		if !(grab=0) {
			if control_jump() sprite_index=s_zero_wallslide
			else sprite_index=s_zero_wallgrab
		}
		/*if crouch_state="pre" sprite_index=s_zero_precrouch
		if crouch_state="crouch" sprite_index=s_zero_crouch
		if crouch_state="post" sprite_index=s_zero_postcrouch*/
	}

	//if control_walk()=-1 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
	//if control_walk()=1 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.
	if x_speed<0 image_xscale=-1
	if x_speed>0 image_xscale=1

	if grab=-1 image_xscale=-1			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
	if grab=1 image_xscale=1				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

	image_yscale=sign(g)			// Поворачиваем спрайт в соответствии с направлением гравитации.




}