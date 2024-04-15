function set_sprite(_sprite_index,_image_index=-1) {
	sprite_index=_sprite_index
	if _image_index>-1 image_index=_image_index
}

function control_walk(_type=0) {
	return getkey("right",_type) - getkey("left",_type)
}

function control_jump(_type=0,_buffer=0) {
	return getkey("down",_type) - getkey("up",_type)
}

key_buffer_up=0

x_speed							=	0
y_speed							=	0

x_speed_max						=	10
x_speed_max_air					=	15
y_speed_max						=	20

walk_acc						=	10
walk_acc1						=	0.3
walk_acc2						=	0.6
walk_turnaround					=	1.5
walk_friction					=	1.5
walk_airres						=	0.2

jump_height						=	32*2
jump_time_to_apex				=	120

g								=	(jump_height*2)/(jump_time_to_apex^2)
jump_h							=	10
jump							=	sqrt(abs(g*jump_height*2))


jumps							=	2
jumps_max						=	2

timer_coyot						=	0
timer_coyot_max					=	5

timer_jump						=	-1
timer_jump_max					=	3

grab							=	0
grab_jump_h						=	11
grab_jump						=	10

mvt_locked						=	0
unslip_locked					=	0
unslip_locked_pressed			=	0

timer_grab_control				=	0
timer_grab_control_max			=	10

timer_grab_ungrab				=	0
timer_grab_ungrab_max			=	15
timer_grab_ungrab_a				=	1
timer_grab_ungrab_b				=	0

attack_cd						=	0
attack_first					=	1
attack_cd_max					=	10
attack_velocity_x				=	20
attack_velocity_y				=	15

log_push(g,c_blue,c_blue,c_aqua,c_aqua)
log_push(jump,c_blue,c_blue,c_aqua,c_aqua)

factor							=	0.35

gdir							=	90
state							=	"ground"



normal_tex=0

/*/	-----------------------		
//	Горизонтальное движение		
//	-----------------------		

function x_control(_type=0) {
	return getkey("right",_type) - getkey("left",_type)
}

x_speed						=	0				//	Горизонтальная скорость тела
x_speed_max					=	10				//	Максимальная горизонтальная скорость тела

x_velocity					=	0.75			//	Ускорение тела
x_friction					=	1				//	Трение
x_airres					=	0.25			//	Сопротивление воздуха

x_dec						=	1
x_acc						=	0.1

x_speed_ascends				=	0				//	

//	---------------------		
//	Вертикальное движение		
//	---------------------		

key_buffer_up=0

function y_control(_type=0,_buffer=0) {
	if _type=pressed and _buffer=1 {
		return getkey("down",_type) - key_buffer_up*getkey("up")
	}
	else {
		return getkey("down",_type) - getkey("up",_type)
	}
}

y_speed						=	0				//	Вертикальная скорость тела
y_speed_max					=	50				//	Максимальная вертикальная скорость тела
y_speed_max_grab			=	4				//	Максимальная вертикальная скорость тела при спуске по стене


y_jump_height				=	32*2				//	Максимальная высота прыжка
y_jump_height_max			=	32*5			//	
y_jump_time_to_apex			=	60*2			//	Время, нужное для прыжка на максимальную высоту
y_factor					=	y_jump_height/y_jump_height_max								//	Делитель гравитации

y_gravity					=	(y_jump_height*2)/(y_jump_time_to_apex^2)						//	Расчет гравитации
y_gravity_air				=	y_gravity*0.7
y_jump						=	-sqrt(abs(y_gravity*y_jump_height*2))*sign(y_gravity)			//	Расчет вертикального импульса прыжка
x_jump						=	10				//	Горизонтальный импульс прыжка

y_state						=	"ground"		//	Состояние объекта, может быть равно "ground", "jump", "air"
y_grab						=	0				//	Направление объекта, если он прицепился к стене.

y_grabjump					=	0.8				//	Множитель прыжка от стены по вертикали
x_grabjump					=	1.5				//	Множитель прыжка от стены по горизонтали
y_grab_cd					=	0				//	Кулдаун после прыжка от стены
y_grab_cd_max				=	30				//	
y_grab_buffer				=	-1				//	Буфер, запрещающий отцепление от стены
y_grab_buffer_max			=	20				//	

y_coyot_timer				=	0				//	Таймер койота
y_coyot_timer_max			=	5				//	Время койота

y_jump_preserve_timer		=	-1				//	Таймер ожидания перед прыжком
y_jump_preserve_timer_max	=	2				//	Время ожидания перед прыжком

attack_velocity				=	20				//	
attack_velocity_x			=	1				//	
attack_velocity_y			=	0.8				//	

attack_cd					=	0				//	
attack_cd_max				=	20				//	
attack_first				=	1				//	

attack_x_speedblock			=	0				//	
attack_y_speedblock			=	0				//	
attack_unblock_speed		=	1				//	
//	-------
//	Функции
//	-------

function set_sprite(_sprite_index,_image_index=-1) {
	sprite_index=_sprite_index
	if _image_index>-1 image_index=_image_index
}

function y_grab_factor(_return,_return_down) {
	if y_control() {
		return _return_down
	}
	else {
		switch y_grab {
			case 0: return 1
			default: return _return
		}
	}
}

normal_tex = sprite_get_texture( sprite_index, image_index );