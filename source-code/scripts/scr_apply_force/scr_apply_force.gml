function apply_force_x(_amnt,_obj=self,_maxovr=0) {
	
	if instance_exists(self) if variable_instance_exists(self,"x_speed") {
		if abs(x_speed)+abs(_amnt)<x_speed_max or _maxovr=1
			x_speed+=_amnt
		
	}
	
}

function apply_force_y(_amnt,_obj=self,_maxovr=0) {
	if instance_exists(self) if variable_instance_exists(self,"y_speed") {
		if abs(y_speed)+abs(_amnt)<y_speed_max or _maxovr=1
			y_speed+=_amnt
		
	}
}
