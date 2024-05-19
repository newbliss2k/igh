/*o_handler.shake_x=random_range(-amnt,amnt)
o_handler.shake_y=random_range(-amnt,amnt)*/

/*var _dir = random_range(0,360)
o_handler.shake_x=timer*amnt*dcos(_dir)
o_handler.shake_y=timer*amnt*dsin(_dir)

if timer<1 instance_destroy() else timer--*/

shake_time -= 1; 
   var _xval = choose(-shake_magnitude, shake_magnitude); 
   var _yval = choose(-shake_magnitude, shake_magnitude); 
   o_handler.shake_x=_xval
   o_handler.shake_y=_yval

   if (shake_time <= 0) 
   { 
      shake_magnitude -= shake_fade; 

      if (shake_magnitude <= 0) 
      { 
         o_handler.shake_x=0
		 o_handler.shake_y=0
		 instance_destroy()
      } 
   } 