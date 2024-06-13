timer--

	draw_set_alpha(1/*-(timer/timer_max)*/)
	draw_set_color(c_black)
	
		draw_set_alpha(255/*-(timer/timer_max)*/)
		draw_set_color(c_white)
		draw_rectangle(0,0,9999,9999,0)
	
	draw_set_alpha(1)

if timer=0 {
	room_goto(room_goto_index)
	var _inst
	_inst=instance_create_depth(0,0,-15999,o_fx_darken_out)
	_inst.timer=timer_max
	_inst.timer_max=timer_max
}