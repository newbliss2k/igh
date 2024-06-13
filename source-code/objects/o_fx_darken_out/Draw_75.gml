timer--

if timer=0 {
	instance_destroy()
}

	draw_set_alpha(timer/timer_max)
	draw_set_color(c_black)
	with global.game draw_rectangle(0,0,9999,9999,1)
	draw_set_alpha(1)
