// X MOVEMENT

x_control=getkey("right")-getkey("left")
x_speed+=x_control*x_velocity

x_speed-=x_friction*sign(x_speed)
if abs(x_speed)>x_max_speed x_speed=x_max_speed*sign(x_speed)



if !(place_meeting(x+x_speed,y,o_solid)) {
	x+=x_speed
} else while place_meeting(x+sign(x_speed),y,o_solid) {
	x+=sign(x_speed)
}

sprite_timer--

if x_speed>0 image_xscale=1
if x_speed<0 image_xscale=-1

if abs(x_speed)>0 and sprite_index=s_zero_idle {
	sprite_index=s_zero_idle_to_run
	sprite_timer=4
}

if abs(x_speed)=0 and sprite_index=s_zero_run {
	sprite_index=s_zero_run_to_idle
	sprite_timer=5
}

if sprite_timer<1 {
	if abs(x_speed)>0 sprite_index=s_zero_run
	if abs(x_speed)=0 sprite_index=s_zero_idle
}