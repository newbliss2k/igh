x_speed=spd*dcos(image_angle)
y_speed=-spd*dsin(image_angle)

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

for (var _i=0; _i<abs(x_speed); _i++) {
	if !(place_meeting(x+sign(x_speed),y,o_solid)) x+=sign(x_speed)
	else {
		instance_destroy()
	}
}

for (var _i=0; _i<abs(y_speed); _i++) {
	if !(place_meeting(x,y+sign(y_speed),o_solid)) y+=sign(y_speed)
	else {
		instance_destroy()
	}
}

if timer<1 instance_destroy() else timer--