if getkey("res") {
	x=mouse_x
	y=mouse_y
}

// X MOVEMENT

x_control=getkey("right")-getkey("left")
x_control_p=getkey("right",pressed)-getkey("left",pressed)

if y_grab=0 {
	
	if y_grab_cooldown<1 x_speed+=x_control*x_velocity
	else y_grab_cooldown--
	
}
else if y_grab_buffer=-1 {
	if x_control_p=-y_grab y_grab_buffer=y_grab_buffer_max
}
else if y_grab_buffer=0 {
	x_speed+=x_control*x_velocity
	y_grab_buffer=-1
}
else if y_grab_buffer>0 {
	y_grab_buffer--
}

x_speed_ascends=abs(x_control)

if !(x_control=sign(x_speed)) if abs(x_speed)>x_friction
	if y_state="ground" x_speed-=x_friction*sign(x_speed)
	else x_speed-=x_airres*sign(x_speed)
else x_speed=0
if abs(x_speed)>x_max_speed x_speed=x_max_speed*sign(x_speed)
//if abs(x_speed)<(x_velocity-0.01) x_speed=0


if !(place_meeting(x+x_speed,y,o_solid)) {
	x+=x_speed
} else {
	while !(place_meeting(x+sign(x_speed),y,o_solid)) {
		x+=sign(x_speed)
	}
	x_speed=0
	x_speed_ascends=0
}

// Y MOVEMENT
if getkey("up",pressed) buffer_counter=buffer_max
if buffer_counter>0 buffer_counter--
var _buffer_getkey_up_pressed=sign(buffer_counter)

y_control=getkey("down")-getkey("up")
y_control_p=getkey("down",pressed)-_buffer_getkey_up_pressed
if place_meeting(x,y+1,o_solid) {
	y_state="ground"
	coyot_buffer=coyot_buffer_max
} else if !(y_state="jump") y_state="air"

//if y_state="ground" coyot_buffer=coyot_buffer_max

if y_control_p=-1 /*jump*/ and coyot_buffer>0 and y_grab=0 and y_jump_preserve_time=-1 {
	y_jump_preserve_time=2 // jump preserve time in frames
	x_speed=0
	coyot_buffer=0
}

coyot_buffer--

if y_control_p=-1 and !(y_grab=0) {
	
	y_state="jump"
	y_speed=y_jump*0.8
	x_speed=x_jump*-y_grab*2
	y_grab_cooldown=y_grab_cooldown_max
	
}

if y_jump_preserve_time=0 {
	y_jump_preserve_time=-1
	y_state="jump"
	y_speed=y_jump
	x_speed=x_jump*x_control
	coyot_buffer=0
} else if y_jump_preserve_time>0 y_jump_preserve_time--

if y_control>-1 /*no jump*/ and y_state="jump" y_state="air"


if y_state="jump" {
	y_speed+=y_gravity*y_factor
	if y_speed>0 y_state="air"
} else y_speed+=y_gravity

if y_speed>y_speed_grab_max and !(y_grab=0) y_speed=y_speed_grab_max

if !(place_meeting(x,y+y_speed,o_solid)) {
	y+=y_speed
} else {
	while !(place_meeting(x,y+sign(y_speed),o_solid)) {
		y+=sign(y_speed)
	}
	y_speed=0
}

// WALLGRAB

if place_meeting(x+abs(x_control),y,o_solid) or place_meeting(x-abs(x_control),y,o_solid) {
	
	if y_state="jump" {
		
		y_grab=place_meeting(x+abs(x_control),y,o_solid)-place_meeting(x-abs(x_control),y,o_solid)
		
	}
	
	if y_state="air" {
		
		y_grab=place_meeting(x+abs(x_control),y,o_solid)-place_meeting(x-abs(x_control),y,o_solid)
		
	}

} else if place_meeting(x+y_grab,y,o_solid) {
	
	
	
} else y_grab=0

if y_state="ground" y_grab=0

// ANIMATIONS
//show_debug_message(x_speed_ascends)

if y_jump_preserve_time=-1 {
	if y_grab=0 {
		switch y_state {
			case "ground":
				
				if x_speed_ascends {
					
					if sprite_index=s_zero_idle or sprite_index=s_zero_run_to_idle set_sprite(s_zero_idle_to_run,0)
					else if sprite_index=s_zero_idle_to_run { if image_index=4 set_sprite(s_zero_run,0) }
					else if !(sprite_index=s_zero_run) set_sprite(s_zero_run,0)
					else set_sprite(s_zero_run)
					
					
				}
				
				if x_speed_ascends=0 {
					
					if sprite_index=s_zero_run or sprite_index=s_zero_idle_to_run set_sprite(s_zero_run_to_idle,0)
					else if sprite_index=s_zero_run_to_idle { if image_index=5 set_sprite(s_zero_idle,0)}
					else if !(sprite_index=s_zero_idle) set_sprite(s_zero_idle,0)
					else set_sprite(s_zero_idle)
					
				}
				
				break;
			case "jump":
				sprite_index=s_zero_jump
				break;
		
			case "air":
				sprite_index=s_zero_fall
				break;
		}
	} else {
		
		if y_control sprite_index=s_zero_wallslide
		else sprite_index=s_zero_wallgrab
		
	}
}  else sprite_index=s_zero_jump

if x_speed<0 image_xscale=-2
if x_speed>0 image_xscale=2


/*sprite_set_bbox(sprite_index,sprite_xoffset-10,sprite_yoffset+30,sprite_xoffset+10,sprite_yoffset)