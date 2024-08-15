

		//	--------
		//	Анимации
		//	--------

/*
if grab=0 {
	switch state {
	
		case "ground":
			if !(x_speed=0) {//if x_speed_ascends {
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
	
	}
}
else {
	if control_jump() sprite_index=s_zero_wallslide
	else sprite_index=s_zero_wallgrab
}

if control_walk()=-1 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
if control_walk()=1 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

if grab=-1 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
if grab=1 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

image_yscale=2*sign(g)			// Поворачиваем спрайт в соответствии с направлением гравитации.




