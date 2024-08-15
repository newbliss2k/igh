function write(_nosound=0) {
	
	active=1
	global.game.mode="dialogue"
	letter=instance_create_depth(x,y,-15001,o_letter)
	
	
	
	with letter {
		str=string_char_at(global.msg[o_writer.current_msg].text,o_writer.current_char)
		var _sound_letters = ["У","Е","Ы","А","О","Э","Я","И","Ю","E","Y","U","I","O","A","у","е","ы","а","о","э","я","и","ю","e","y","u","i","o","a"]
		if array_contains(_sound_letters,str) and _nosound {//} else if o_writer.timer_snd<1 {
			audio_play_sound(sfx_writer_npc,1,0,0.25)
			o_writer.timer_snd=6
		}
		xscale=o_writer.xscale
		yscale=o_writer.yscale
		yscale2=1
		angle=o_writer.angle
		c1=o_writer.c1
		c2=o_writer.c2
		c3=o_writer.c3
		c4=o_writer.c4
		alpha=o_writer.alpha
		alpha2=0
			
		font=o_writer.font
		destroy=0
		create=1
		
		
		x_border=5
		y_border=5
	}
	
	draw_set_font(font)
	if current_char_str()=" "
		x+=string_width(current_char_str())+2
	else
		x+=string_width(current_char_str())-2
	current_char++
	timer+=1
	
}

function poll_handle(_only_ir=0) {
	
	draw_set_alpha(1)
	
	poll_selector_alpha=lerp(poll_selector_alpha,1,0.1)
	
	draw_set_font(font_poll)
	
	var _poll=global.msg[current_msg].poll
	var _poll_f=[]
	
	for (var _i=0; _i<array_length(_poll); _i++) if _only_ir=0 or variable_struct_exists(_poll[_i],"ir") array_push(_poll_f,_poll[_i])
	
	var _poll_offset = poll_string_height*array_length(_poll)
	
	var _max_len = 0
	for (var _i=0; _i<array_length(_poll); _i++) _max_len=max(_max_len,string_width(_poll[_i].text))
		
	var __poll_rect_x1 = poll_x-poll_border_x
	var __poll_rect_x2 = poll_x+poll_border_x+_max_len
	var __poll_rect_y1 = poll_y-array_length(_poll)*poll_string_height-poll_border_y
	var __poll_rect_y2 = poll_y+poll_border_y-array_length(_poll)*poll_string_height*(1-poll_selector_alpha)
		
	// Нижний слой прогрессбара
	draw_set_color(0)
	draw_set_alpha(poll_selector_alpha)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x2,__poll_rect_y2,0)
		
	// Средний слой прогрессбара
	draw_set_color(c_red)
	draw_set_alpha(poll_selector_alpha*0.4)
	var __poll_length = __poll_rect_x2-__poll_rect_x1
	__poll_length = __poll_length*0.28
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x1+__poll_length,__poll_rect_y2,0)
		
	// Верхний слой прогрессбара
	draw_set_color(c_white)
	draw_set_alpha(poll_selector_alpha*0.2)
	var __poll_length1 = __poll_rect_x2-__poll_rect_x1
	__poll_length1 = __poll_length1*0.3*timer_line/timer_redline
		
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x1+__poll_length1,__poll_rect_y2,0)
		
	// Обводка прогрессбара
	draw_set_alpha(poll_selector_alpha*0.4)
	draw_set_color(c_white)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1-poll_duration_border,__poll_rect_x2,__poll_rect_y2,1)
		
	// Нижний слой окна выбора ответов
	draw_set_color(0)
	draw_set_alpha(poll_selector_alpha*2)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1,__poll_rect_x2,__poll_rect_y2,0)
		
	// Обводка окна выбора ответов
	draw_set_alpha(poll_selector_alpha*0.4)
	draw_set_color(c_white)
	draw_roundrect(__poll_rect_x1,__poll_rect_y1,__poll_rect_x2,__poll_rect_y2,1)
	
	if array_length(_poll_f)>0 {
		
		poll_s_x1=lerp(poll_s_x1,poll_x-3,0.5)
		poll_s_x2=lerp(poll_s_x2,poll_x+string_width(_poll_f[poll_selector].text)+3,0.5)
		poll_s_y1=lerp(poll_s_y1,poll_y+(poll_selector)*poll_string_height-_poll_offset,0.5)
		poll_s_y2=lerp(poll_s_y2,poll_y+(poll_selector+1)*poll_string_height+1-_poll_offset,0.5)
		
		if _only_ir draw_set_color(c_red)
		else draw_set_color(c_white)
		
		draw_set_alpha(0.1*poll_selector_alpha)
		draw_roundrect(poll_s_x1,poll_s_y1,poll_s_x2,poll_s_y2,0)
		draw_set_alpha(0.7*poll_selector_alpha)
		draw_roundrect(poll_s_x1,poll_s_y1,poll_s_x2,poll_s_y2,1)
		
		for (var _i=0; _i<(array_length(_poll_f)); _i++) {
			
			draw_set_alpha(poll_selector_alpha)
			draw_text(poll_x,poll_y+_i*(poll_string_height)-_poll_offset,_poll_f[_i].text)
			
		}
	
	
		if getkey("up",pressed) {
		
			poll_selector--
			if poll_selector<0 poll_selector=array_length(_poll_f)-1
			
			audio_play_sound(sfx_ui_select1,1,0,0.25)
		
		}
	
		if getkey("down",pressed) {
		
			poll_selector++
			if poll_selector>=array_length(_poll_f) poll_selector=0
			
			audio_play_sound(sfx_ui_select1,1,0,0.25)
		
		}
	
		if getkey("ok") or (__poll_length1>=(__poll_rect_x2-__poll_rect_x1)) {
		
			getkey("ok",clear)
			_poll_f[poll_selector].func(_only_ir)
			
			if _only_ir audio_play_sound(sfx_ui_shatter_01,1,0,0.25)
			else audio_play_sound(sfx_ui_select2,1,0,0.25)
			
			var _o_wr_poll_echo = instance_create_depth(0,0,depth,o_wr_poll_echo)
			
			_o_wr_poll_echo.poll_s_x1=poll_x-3
			_o_wr_poll_echo.poll_s_x2=poll_x+string_width(_poll_f[poll_selector].text)+3
			_o_wr_poll_echo.poll_s_y1=poll_y+(poll_selector)*poll_string_height-_poll_offset
			_o_wr_poll_echo.poll_s_y2=poll_y+(poll_selector+1)*poll_string_height+1-_poll_offset
			
			
			
			_o_wr_poll_echo.poll_x=poll_x
			_o_wr_poll_echo.poll_y=poll_y
			
			_o_wr_poll_echo.ir=_only_ir
			_o_wr_poll_echo.poll_selector=poll_selector
			_o_wr_poll_echo.poll_selector_alpha=poll_selector_alpha
			_o_wr_poll_echo.text=_poll_f[poll_selector].text
			_o_wr_poll_echo.poll_string_height=poll_string_height
			_o_wr_poll_echo.poll_offset=_poll_offset
			_o_wr_poll_echo.array_len=array_length(_poll)
			_o_wr_poll_echo.poll_border_y=poll_border_y
			
			_o_wr_poll_echo.__poll_rect_x1=__poll_rect_x1
			_o_wr_poll_echo.__poll_rect_x2=__poll_rect_x2
			_o_wr_poll_echo.__poll_rect_y1=__poll_rect_y1
			_o_wr_poll_echo.__poll_rect_y2=__poll_rect_y2
			
			_o_wr_poll_echo._poll_rect_y2d=__poll_rect_y2
			
			_o_wr_poll_echo.timer_line=timer_line
			_o_wr_poll_echo.timer_redline=timer_redline
			
			poll_selector=0
			
			if _only_ir with o_letter destroy_ir=1 // Передаем сигнал самоуничтожения созданным объектам-буквам.
			else with o_letter destroy=1
			show_debug_message(array_length(global.msg))
			show_debug_message(current_msg)
			current_msg++ // Переходим к следующему сообщению.
			if !(array_length(global.msg)>current_msg) reset(0) else reset(1)
			// Если это было последнее сообщение, то делаем хард резет - приведение всех служебных переменных в изначальное состояние.
			// Если нет, то все равно нужно привести большинство переменных к стандартным знчениям.
			
		
		}
		
	}
	
}

function scr_current_char_string(_offset) {
	return string_char_at(global.msg[current_msg].text,_i+_offset)
}










