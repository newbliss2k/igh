	//	----------------------
	//	Дебаг
	//	----------------------

if getkey("res") {
	x	=	mouse_x
	y	=	mouse_y
}

if getkey("debug_gravity",pressed) {
	y_gravity=-y_gravity
	y_jump=-y_jump
	y+=sign(y_gravity)*sprite_get_height(mask_index)*2
}

//	----------------------
//	Буфферинг кноки прыжка
//	----------------------

if getkey("up",pressed) {
	key_buffer_up=1
}

		//	-----
		//	Атака
		//	-----

if y_state="ground" or !(y_grab=0) {
	attack_cd=0
	attack_first=1
}

if attack_cd<1 {
	if getkey("atk",pressed) {
		y_state="air"
		attack_cd=attack_cd_max
		x_speed=0
		x_speed=attack_velocity*attack_velocity_x*dcos(point_direction(x,y-50,mouse_x,mouse_y))
		if attack_first=1 {
			y_speed=0
			y_speed=-attack_velocity*attack_velocity_y*dsin(point_direction(x,y-50,mouse_x,mouse_y))
			attack_first=0
		}
		else {
			y_speed=0
			y_speed=-attack_velocity*attack_velocity_y*dsin(point_direction(x,y-50,mouse_x,mouse_y))*0.1
		}
		
		//	Создаем клинок на месте персонажа
		var _attack
		_attack=instance_create_depth(x,y-50,-1,o_attack)
		_attack.direction=point_direction(x,y-50,mouse_x,mouse_y)
	}
}
else attack_cd--

		//	-----------------------
		//	Горизонтальное движение
		//	-----------------------

if y_state="ground" y_grab_cd=0
if y_grab=0 {
	if y_grab_cd<1 x_speed+=x_control()*x_velocity
	else y_grab_cd--
}
else if y_grab_buffer=-1 {
	if x_control(pressed)=-y_grab y_grab_buffer=y_grab_buffer_max
}
else if y_grab_buffer=0 {
	x_speed+=x_control()*x_velocity
	y_grab_buffer=-1
}
else if y_grab_buffer>0 {
	y_grab_buffer--
}

//x_speed+=x_control()*x_velocity									//	Если кнопка движения вправо или влево нажата, увеличиваем модуль скорости
if abs(x_speed)>x_speed_max x_speed-=x_friction*sign(x_speed)	//	Ограничиваем максимальную скорость.

if !(x_control()=sign(x_speed)) if abs(x_speed)>x_friction
	if y_state="ground" x_speed-=x_friction*sign(x_speed)
	else x_speed-=x_airres*sign(x_speed)
else x_speed=0

x_speed_ascends=abs(x_control())									//	Эта переменная нужна, чтобы узнать, перемещался ли объект за этот кадр.

if !(place_meeting(x+x_speed,y,o_solid)) {					//	Если объект не столкнется с твердым телом,
	x+=x_speed												//	передвигаем объект.
} else {
	while !(place_meeting(x+sign(x_speed),y,o_solid)) {		//	Иначе передвигаем объект вплотную к твердому телу.
		x+=sign(x_speed)
	}
	x_speed=0												//	А затем обнуляем скорость.
	x_speed_ascends=0										//	Также нужно обнулить эту переменную.
}

		//	---------------------		
		//	Вертикальное движение		
		//	---------------------		

	//	Управление состояением

if place_meeting(x,y+sign(y_gravity),o_solid) and y_jump_preserve_timer<0 {		//	Определяем состояние объекта: если объект находится на земле и не готовится к прыжку,
	y_state="ground"					//	он получает соответствующее состояние.
	y_coyot_timer=y_coyot_timer_max		//	Также мы даем телу время койота.
}
else {
	if !(y_state="jump") {				//	Иначе, если объект не находится в состоянии прыжка,
		y_state="air"					//	он получает состояние "в воздухе".
	}
}

	//	Прилипание к стене

if place_meeting(x+abs(x_control()),y,o_solid) or place_meeting(x-abs(x_control()),y,o_solid) {
	if y_state="jump" or y_state="air" {
		y_grab=place_meeting(x+abs(x_control()),y,o_solid)-place_meeting(x-abs(x_control()),y,o_solid)
	}
}
else if place_meeting(x+y_grab,y,o_solid) {
	
}
else y_grab=0

if y_state="ground" y_grab=0

	//	Управление прыжком

if !(y_grab=0) and y_control(pressed)=-1 {
	y_speed=y_jump*y_grabjump
	x_speed=x_jump*x_grabjump*-y_grab
	y_state="jump"
	y_grab_cd=y_grab_cd_max
	key_buffer_up=0
}

if y_coyot_timer>0 and y_control(pressed,1)=-1 {			//	Если у тела есть время койота (т.е. он находится на земле или находился на ней несколько)
														//	кадров назад) и кнопка прыжка только что нажата, нам нужно приготовить тело к прыжку:
	x_speed=0											//	Обнуляем горизонтальную скорость.
	y_jump_preserve_timer=y_jump_preserve_timer_max		//	Задаем заддержку перед прыжком: через несколько кадров тело совершит прыжок.
	y_coyot_timer=0										//	Обнуляем и время койота.
	key_buffer_up=0
}
else y_coyot_timer--									//	Иначе уменьшаем значение таймера на единицу.

if y_jump_preserve_timer=0 {							//	Когда задержка заканчивается, тело совершает прыжок.
	y_speed=y_jump										//	Приравниваем вертикальную скорость к импульсу прыжка.
	x_speed=x_jump*x_control()							//	То же самое с горизонтальной скоростью, если кнопка нажата.
	y_state="jump"										//	Переводим объект в состояние прыжка
}
if y_jump_preserve_timer>-1 y_jump_preserve_timer--		//	Уменьшаем время койота на единицу.

	//	Применение гравитации и скорости

if y_control()>-1 and y_state="jump" y_state="air"		//	Переводим объект в состояние падения, если не нажата кнопка прыжка и объект
														//	находился в состоянии прыжка.

if y_state="jump" {										//	Если игрок удерживает кнопку прыжка,
	y_speed+=y_gravity*y_grab_factor(0.5,1.5)*y_factor			//	применяем уменьшенную гравитацию, чтобы игрок прыгал выше.
	if y_speed*y_gravity>0 y_state="air"				//	Если игрок падает, переводим объект в состояние падения.
}
else y_speed+=y_gravity*y_grab_factor(0.4,1.5)					//	Тогда он будет получать уменьшенную гравитациюю.

if abs(y_speed)>y_speed_max {				//	Если модуль скорости больше максимальной скорости,
	y_speed=y_speed_max*sign(y_speed)		//	модуль скорости приравнивается к максимальной скорости с тем же знаком.
}

if y_control() {
	if y_speed>y_speed_max_grab*2 and !(y_grab=0) {
		y_speed=y_speed_max_grab*2
	}
}
else {
	if y_speed>y_speed_max_grab and !(y_grab=0) {
		y_speed=y_speed_max_grab
	}
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

		//	--------
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

if x_speed<0 image_xscale=-2			// Если горизонтальная скорость направлена влево (меньше нуля), поворачиваем спрайт влево.
if x_speed>0 image_xscale=2				// Если горизонтальная скорость направлена вправо (больше нуля), поворачиваем спрайт вправо.

image_yscale=2*sign(y_gravity)			// Поворачиваем спрайт в соответствии с направлением гравитации.












