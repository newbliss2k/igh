// X MOVEMENT

x_control				=	0
x_control_p				=	0
x_speed					=	0

x_max_speed				=	10
x_velocity				=	0.75
x_friction				=	1
x_airres				=	0.25

x_speed_ascends			=	0

// Y MOVEMENT

y_control				=	0
y_control_p				=	0
y_speed					=	0
y_speed_grab_max		=	6

y_max_speed				=	5
y_factor				=	0.5
y_jump_preserve_time	=	-1

y_state					=	"ground"
y_grab					=	0
y_grab_buffer			=	-1
y_grab_buffer_max		=	10

y_grab_cooldown			=	0
y_grab_cooldown_max		=	20

y_jump_height			=	66
y_jump_time_to_apex		=	200

y_gravity				=	(y_jump_height*2)/(y_jump_time_to_apex^2)
y_jump					=	-sqrt(y_gravity*y_jump_height*2)

x_jump					=	10

buffer_counter			=	0
buffer_max				=	3

coyot_buffer			=	0
coyot_buffer_max		=	5

// FUNCTIONS

function set_sprite(_sprite_index,_image_index=-1) {
	sprite_index=_sprite_index
	if _image_index>-1 image_index=_image_index
}

function y_grab_mod_jump() {
	switch y_grab {
		case 0: return 1
		default: return 0.5
	}
}
function y_grab_mod_air() {
	switch y_grab {
		case 0: return 1
		default: return 0.4
	}
}
