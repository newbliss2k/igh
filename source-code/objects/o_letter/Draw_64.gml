draw_set_alpha(1)
draw_set_font(font)

if global.game.pause=0 {
	
	draw_set_font(font)
	if destroy=1 {
		create=0
		alpha2=lerp(alpha2,0,0.1)
		//yscale2=lerp(yscale2,2,0.1)
		y_border=lerp(y_border,-10,0.1)
		if alpha2=0 instance_destroy(self)
	}
	
	if destroy_ir=1 {
		
		create=0
		gravity=0.5
		direction=random_range(55,125)
		speed=random_range(10,12)
		destroy_ir=2
		destroy_timer=120
		
	}
	
	destroy_timer--
	
	if destroy_ir=2 {
		
		angle+=angle_step
		
		if destroy_timer<1 instance_destroy(self)
		
	}

	if create=1 {
		alpha2=lerp(alpha2,1,0.1)
		x_border=lerp(x_border,0,0.1)
		y_border=lerp(y_border,0,0.1)
	}
}

//draw_text_transformed_color(x,y,str,xscale,yscale,angle,c1,c2,c3,c4,alpha)
draw_text_transformed_color(x+x_border,y+y_border+o_writer.dbox_y1,str,xscale,yscale*yscale2,angle,c1,c2,c3,c4,alpha*alpha2)
//draw_text(mouse_y*2,mouse_x*2,"x: )
//draw_text(x,y,"x: "+string(x)+"\ny: "+string(y))
	