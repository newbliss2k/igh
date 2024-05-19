image_speed=global.game.animspeed*!global.game.pause

if (dead_before<1) and (global.game.pause=0) {
	
	global.game.animspeed=1
	
	o_chara_step_dead()

	o_chara_step_start()

	o_chara_step_phy_walk()

	o_chara_step_phy_friction()

	o_chara_step_phy_gravity()

	o_chara_step_phy_apply_speed()

	// ANIMATIONSSS

	dead_begin=max(dead_begin-1,0)
	if state="ground" {
		set_sprite(s_zero_hurtground)
		if image_index>5 image_index=5
	}
	else if dead_begin<1 set_sprite(s_zero_hurtfly)

	if x_speed<0 image_xscale=2
	if x_speed>0 image_xscale=-2
}
else dead_before=max(dead_before-1,0)