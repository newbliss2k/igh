direction=image_angle

spd=max(spd+0.05,spd_max)
/*if !(place_meeting(x+x_speed,y,o_solid)) x+=x_speed
else {
	while !(place_meeting(x+sign(x_speed),y,o_solid)) x+=sign(x_speed)
	instance_destroy()
}

if !(place_meeting(x,y+y_speed,o_solid)) y+=y_speed
else {
	while !(place_meeting(x,y+sign(y_speed),o_solid)) y+=sign(y_speed)
	instance_destroy()
}*/

var _instance_destroy = 0

for (var _i=0; _i<abs(spd); _i++) {
	
	if !(place_meeting(x+dcos(image_angle),y,o_solid)) x+=dcos(image_angle)
	else {
		_instance_destroy=1
		break
	}
	
	if !(place_meeting(x,y-dsin(image_angle),o_solid)) y-=dsin(image_angle)
	else {
		_instance_destroy=1
		break
	}
	
	if not _instance_destroy {
		var _tracer = instance_create_depth(x,y,depth,o_bullet_tracer)
		_tracer.image_alpha=1.0
		_tracer.image_angle=image_angle
	}
	
}

draw_self()
if timer timer-- else instance_destroy()
if _instance_destroy instance_destroy()

