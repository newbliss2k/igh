
#region CONTROL HANDLE
	
	
#endregion

//	========
//	FRICTION
//	========

if place_meeting(x,y+1,o_solid) state="ground" else if !(state="air") state="jump"

if control_walk()=0 if abs(x_speed)>walk_friction {
	switch state {
		case "ground": x_speed-=walk_friction*sign(x_speed); break;
		default: x_speed-=walk_airres*sign(x_speed); break;
	}
}
else x_speed=0

//	========
//	WALLGRAB
//	========

grab_prev=grab

grab = (place_meeting(x-abs(control_walk()), y, o_solid) - place_meeting(x+abs(control_walk()), y, o_solid))*!(state="ground")


if (grab_prev=0 & grab=1) {
	unslip_locked=10
	unslip_locked_pressed=1
}

mvt_locked = max(mvt_locked - 1, 0)

if control_walk(pressed)=grab unslip_locked_pressed=0
if control_walk()=grab and unslip_locked_pressed=0 unslip_locked--

if grab=0 unslip_locked=0

//	====
//	WALK
//	====

if (mvt_locked<=0) and (unslip_locked<=0) {
	if sign(x_speed)=-control_walk() x_speed+=walk_turnaround*control_walk()
	else {
		if abs(x_speed)<1.5 x_speed+=walk_acc1*control_walk() else if abs(x_speed)<x_speed_max x_speed+=walk_acc2*control_walk()
	}
}

//	=====
//	LIMIT
//	=====

switch state {
	case "ground": if abs(x_speed)>x_speed_max x_speed=sign(x_speed)*x_speed_max; break;
	default: if abs(x_speed)>x_speed_max_air x_speed=sign(x_speed)*x_speed_max_air; break;
}

if y_speed>y_speed_max y_speed=y_speed_max

//	=======
//	JUMPING
//	=======

if place_meeting(x,y+1,o_solid) and (timer_jump<0) state="ground" else if !(state="air") state="jump"

if state="ground" timer_coyot=timer_coyot_max
if (state="ground") jumps=jumps_max
if !(grab=0) jumps=0
if control_jump(pressed,1)=-1 {
	switch grab {
		case 0:
			if timer_coyot>0 or jumps>0 {
				timer_jump=timer_jump_max
				timer_coyot=0
				jumps--
			}
			break;
		default:
		state="jump"
		x_speed=grab_jump_h*grab
		y_speed=-grab_jump
		mvt_locked=10
		key_buffer_up=0
		 break;
	}
}
if timer_coyot>0 timer_coyot--

if timer_jump=0 {
	timer_jump=-1
	timer_coyot=0
	state="jump"
	if !(control_walk()=0) x_speed=jump_h*control_walk()
	y_speed=-jump
	key_buffer_up=0
}
else timer_jump--

if ((state="jump") & (control_jump()>-1)) state="air"

///	=======
//	GRAVITY
//	=======

if (state="jump") {
	y_speed+=g*factor
	if (y_speed>-1) state="air"
}
else {
	if y_speed<0
		y_speed+=g
	else
		y_speed+=g*0.6
}

#region APPLY SPEED
	
	if !(place_meeting(x+x_speed,y,o_solid)) {					//	Если объект не столкнется с твердым телом,
		x+=x_speed												//	передвигаем объект.
	}
	else {
		while !(place_meeting(x+sign(x_speed),y,o_solid)) {		//	Иначе передвигаем объект вплотную к твердому телу.
			x+=sign(x_speed)
		}
		x_speed=0												//	А затем обнуляем скорость.
	}
	
	if !place_meeting(x,y+y_speed,o_solid) {						//	Если объект не столкнется с твердым телом,
		y+=y_speed													//	мы передвигаем объект.
	}
	else {
		while !place_meeting(x,y+sign(y_speed),o_solid) {
			y+=sign(y_speed)										//	Иначе мы передвигаем объект вплотную к твердому телу.
		}
		y_speed=0													//	Затем мы обнуляем скорость объекта.
	}
	
#endregion

/*		//	--------
		//	Анимации
		//	--------

if y_grab=0 {
	switch y_state {
	
		case "ground":
			if !(x_speed=0) {//if x_speed_ascends {
				if sprite_index=s_zero_idle or sprite_index=s_zero_run_to_idle set_sprite(s_zero_idle_to_run,0)
				else if sprite_index=s_zero_idle_to_run { if image_index=4 set_sprite(s_zero_run,0) }
				else if !(sprite_index=s_zero_run) set_sprite(s_zero_run,0)
				else set_sprite(s_zero_run)
			}
			else {//if x_speed_ascends=0 {
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
}
else {
	if y_control() sprite_index=s_zero_wallslide
	else sprite_index=s_zero_wallgrab
}

if x_control()=-1 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
if x_control()=1 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

if y_grab=-1 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
if y_grab=1 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

image_yscale=2*sign(y_gravity)			// Поворачиваем спрайт в соответствии с направлением гравитации.




