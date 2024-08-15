__poll_rect_y2 = poll_y+poll_border_y-array_len*poll_string_height*(1-poll_rect_alpha)

draw_set_alpha(poll_rect_alpha)
		
			// Нижний слой прогрессбара
	draw_set_color(0)
	draw_set_alpha(poll_rect_alpha)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x2,__poll_rect_y2,0)
		
	// Средний слой прогрессбара
	draw_set_color(c_red)
	draw_set_alpha(poll_rect_alpha*0.4)
	var __poll_length = __poll_rect_x2-__poll_rect_x1
	__poll_length = __poll_length*0.28
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x1+__poll_length,__poll_rect_y2,0)
		
	// Верхний слой прогрессбара
	draw_set_color(c_white)
	draw_set_alpha(poll_rect_alpha*0.2)
	var __poll_length1 = __poll_rect_x2-__poll_rect_x1
	__poll_length1 = __poll_length1*0.3*timer_line/timer_redline
		
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x1+__poll_length1,__poll_rect_y2,0)
		
	// Обводка прогрессбара
	draw_set_alpha(poll_rect_alpha*0.4)
	draw_set_color(c_white)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x2,__poll_rect_y2,1)
		
		draw_set_alpha(poll_rect_alpha*2)
		draw_set_color(0)
		draw_roundrect(__poll_rect_x1,__poll_rect_y1,__poll_rect_x2,__poll_rect_y2,0)
		
		draw_set_alpha(poll_rect_alpha*0.2)
		draw_set_color(c_white)
		draw_roundrect(__poll_rect_x1,__poll_rect_y1,__poll_rect_x2,__poll_rect_y2,1)

if (blink--)<1 {
	blink=blink_def
	if (rep--)<1 selector=0
}
if rep mod 2 poll_selector_alpha=1
else poll_selector_alpha=0.3

if selector {

	draw_set_font(font_poll)

	if ir draw_set_color(c_red)
	else draw_set_color(c_white)
		
			draw_set_alpha(0.2*poll_selector_alpha)
			draw_roundrect(poll_s_x1,poll_s_y1,poll_s_x2,poll_s_y2,0)
			draw_set_alpha(0.7*poll_selector_alpha)
			draw_roundrect(poll_s_x1,poll_s_y1,poll_s_x2,poll_s_y2,1)

	draw_set_alpha(poll_selector_alpha)
	draw_text(poll_x,poll_y+poll_selector*(poll_string_height)-poll_offset,text)
	
} else {
	
	poll_rect_alpha=lerp(poll_rect_alpha,0,0.2)
	if poll_rect_alpha=0 instance_destroy()
	
}