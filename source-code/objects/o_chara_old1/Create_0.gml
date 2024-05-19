//	-----------------------		
//	Горизонтальное движение		
//	-----------------------		

function control_walk(_type=0) {
	return getkey("right",_type) - getkey("left",_type)
}

x_speed						=	0				//	Горизонтальная скорость тела
x_speed_max					=	10				//	Максимальная горизонтальная скорость тела

x_velocity					=	0.75			//	Ускорение тела
x_friction					=	1				//	Трение
x_airres					=	0.25			//	Сопротивление воздуха

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

state						=	"ground"		//	Состояние объекта, может быть равно "ground", "jump", "air"
grab						=	0				//	Направление объекта, если он прицепился к стене.

grabjump					=	0.8				//	Множитель прыжка от стены по вертикали
x_grabjump					=	1.5				//	Множитель прыжка от стены по горизонтали
grab_cd					=	0				//	Кулдаун после прыжка от стены
grab_cd_max				=	30				//	
grab_buffer				=	-1				//	Буфер, запрещающий отцепление от стены
grab_buffer_max			=	20				//	

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

function grab_factor(_return,_return_down) {
	if y_control() {
		return _return_down
	}
	else {
		switch grab {
			case 0: return 1
			default: return _return
		}
	}
}

normal_tex = sprite_get_texture( sprite_index, image_index );