//	-----------------------		
//	Горизонтальное движение		
//	-----------------------		

function x_control(_type=0) {
	return getkey("right",_type) - getkey("left",_type)
}

x_speed						=	0				// Горризонтальная скорость тела

//	---------------------		
//	Вертикальное движение		
//	---------------------		

function y_control(_type=0) {
	return getkey("down",_type) - getkey("up",_type)
}

y_speed						=	0				//	Вертикальная скорость тела
y_speed_max					=	500				//	Максимальная вертикальная скорость тела

y_jump_height				=	66				//	Максимальная высота прыжка
y_jump_time_to_apex			=	200				//	Время, нужное для прыжка на максимальную высоту

y_gravity					=	(y_jump_height*2)/(y_jump_time_to_apex^2)		//	Расчет гравитации
y_jump						=	-sqrt(y_gravity*y_jump_height*2)				//	Расчет вертикального импульса прыжка
x_jump						=	10				//	Горизонтальный импульс прыжка
y_factor					=	0.5				//	Делитель гравитации

y_state						=	"ground"		//	Состояние объекта, может быть равно "ground", "jump", "air"

y_coyot_timer				=	0				//	Таймер койота
y_coyot_timer_max			=	5				//	Время койота

y_jump_preserve_timer		=	-1				//	Таймер ожидания перед прыжком
y_jump_preserve_timer_max	=	2				//	Время ожидания перед прыжком