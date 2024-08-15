//	
//	
//	
//	

function set_sprite(_sprite_index,_image_index=-1) {
	sprite_index=_sprite_index
	if _image_index>-1 image_index=_image_index
}

function control_walk(_type=0) {
	return getkey("right",_type) - getkey("left",_type)
}



function control_jump(_type=0,_buffer=0) {
	
	//if _type=pressed
	//	return key_buffer_down - key_buffer_up
	//else
		return getkey("down",_type) - getkey("up",_type)
}

global.game.player_control=0
if global.game.restarted {
	x=global.game.chara_restart_x
	y=global.game.chara_restart_y
	global.game.player_control=1
}


ai_control_walk=0
ai_control_jump=0


key_buffer_up=0
key_buffer_down=0

x_speed							=	0
y_speed							=	0

x_speed_max						=	4

x_speed_max_default				=	4

x_speed_max_air					=	4.5
y_speed_max						=	10

walk_acc						=	5
walk_acc1						=	0.2
walk_acc2						=	0.5
walk_turnaround					=	1.5
walk_friction					=	1.5
walk_airres						=	0.2

jump_height						=	32*2
jump_time_to_apex				=	400

g								=	(jump_height*2)/(jump_time_to_apex^2)
jump_h							=	5
jump							=	sqrt(abs(g*jump_height*2))


jumps							=	2
jumps_max						=	2

timer_coyot						=	0
timer_coyot_max					=	5

timer_jump						=	-1
timer_jump_max					=	3

grab							=	0
grab_jump_h						=	11
grab_jump						=	8
grab_prev						=	0

mvt_locked						=	0
mvt_locked_max					=	17
unslip_locked					=	0
unslip_locked_pressed			=	0

crouch_state					=	0
crouch_dir						=	1
crouch_timer					=	0
crouch_timer_flip				=	0
crouching_power					=	17
crouching_friction				=	0.6

g_factor_jump							=	2.4
g_factor_air							=	1.5

gdir							=	90
state							=	"ground"
state_prev						=	"ground"


weapon=10
weapon_direction=0
weapon_range=0
recharge=10

attack_impulse=0


normal_tex=0

door_break_timer=0
door_break_timer_max=15

image_xscale=1
image_yscale=1

dead=0