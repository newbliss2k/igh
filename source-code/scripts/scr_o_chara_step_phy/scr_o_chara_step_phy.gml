function scr_o_chara_step_phy(){
	
	/*if x_control()=0 {
		
		if abs(x_speed)>x_dec {
			x_speed-=sign(x_speed)*x_dec
		}
		else {
			x_speed=0
		}
		
	}
	else {
		
		x_speed+=x_control()*x_acc
		
	}*/
	
	/*if abs(x_speed)<0.5 {
		if abs(x_speed)+x_control()*x_acc1 < x_speed_max {
			x_speed+=x_control()*x_acc1
		}
		if abs(x_speed)+x_control()*x_acc1 > x_speed_max {
			x_speed=x_speed_max*sign(x_speed)
		}
	}
	else {
		if abs(x_speed)+x_control()*x_acc2 < x_speed_max {
			x_speed+=x_control()*x_acc2
		}
		if abs(x_speed)+x_control()*x_acc2 > x_speed_max {
			x_speed=x_speed_max*sign(x_speed)
		}
	}
	
	if abs(x_speed)>x_dec {
		x_speed-=sign(x_speed)*x_dec
	}
	else {
		x_speed=0
	}*/
	
	//if abs(x_speed)>x_speed_max x_speed=x_speed_max*sign(x_speed)
	if abs(x_speed)>x_speed_max x_speed=x_speed_max*sign(x_speed)	//	lerp(x_speed,x_speed_max*sign(x_speed),0.5)
	
	
	
	
	
		if getkey("atk",pressed) {
			x_speed=20*dcos(point_direction(x,y-50,mouse_x,mouse_y))
			y_speed=20*-dsin(point_direction(x,y-50,mouse_x,mouse_y))
			//	Создаем клинок на месте персонажа
			var _attack
			_attack=instance_create_depth(x,y-50,-1,o_attack)
			_attack.direction=point_direction(x,y-50,mouse_x,mouse_y)
		}
	
	
	
	
	
}