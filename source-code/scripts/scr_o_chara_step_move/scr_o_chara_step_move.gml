function scr_o_chara_step_move(){
	
	
	if !(place_meeting(x+x_speed,y,o_solid)) {					//	Если объект не столкнется с твердым телом,
		x+=x_speed												//	передвигаем объект.
		x_speed_ascends=sign(x_speed)
	}
	else {
		while !(place_meeting(x+sign(x_speed),y,o_solid)) {		//	Иначе передвигаем объект вплотную к твердому телу.
			x+=sign(x_speed)
		}
		x_speed=0												//	А затем обнуляем скорость.
		x_speed_ascends=0										//	Также нужно обнулить эту переменную.
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
	
}