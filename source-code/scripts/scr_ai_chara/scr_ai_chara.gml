function scr_ai_chara(){
	
	switch room {
		
		case r_menu_main:
			break
		
		default:
			
			switch o_handler.game_timer {
				
				case 0: ai_control_walk=1
				break
				
				case 30: ai_control_walk=0
				break
				
				case 60: global.game.player_control=1
				break
				
			}
		
	}
	
	o_chara_step_debug()
	o_chara_step_start()
	o_chara_step_phy_grab()
	o_chara_step_phy_crouch(ai_control_walk,ai_control_jump)
	o_chara_step_phy_walk(ai_control_walk)
	o_chara_step_phy_friction(ai_control_walk)
	o_chara_step_phy_jump()
	o_chara_step_phy_gravity(ai_control_jump)
	o_chara_step_attack()
	o_chara_step_behaviour()
	o_chara_step_phy_apply_speed()
	
}