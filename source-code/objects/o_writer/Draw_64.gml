draw_set_alpha(1)
draw_set_color(c_white)

timer_snd--

/*
draw_text(0,0,string(timer_line*0.3))
draw_text(0,30,string(timer_redline))
if (timer_line=timer_redline) and timer>0 log_push("ok")*/

if global.game.pause=0 and array_length(global.msg)>current_msg {
	
	active=1
	global.game.mode="dialogue"
	
	var _poll=variable_struct_exists(global.msg[current_msg],"poll")
	var _func=variable_struct_exists(global.msg[current_msg],"func")
	var _text=variable_struct_exists(global.msg[current_msg],"text")
	
	if _func global.msg[current_msg].func() // Если в обрабатываемом MSG существует функция, нам следует ее выполнить.
	
	if _text { // Если в обрабатываемом MSG существует текст, нам следует его обработать.
		
		timer_line+=0.5
		
		if !(current_char_str()="") { // Если выведение текста на экран еще не закончилось, нам следует продолжить.
			
			if getkey("ok",pressed) and !_poll while !(current_char_str()="") {
				
				// Две строки ниже отвечают за пропуск анимации текста.
				// Он срабатывает, если нажата кнопка действия и в обрабатываемом сообщении нет выборов варинтов ответов.
				// Мы просто интерпретируем и выводим все символы до последнего с помощью цикла while.
				scr_writer_redline_check()
				scr_writer_format() // Этой функцией мы интерпретируем текст.
				write() // Этой функцией мы осуществляем выведение символа.
				
			}
			else {
				scr_writer_redline_check()
				scr_writer_format() // Этой функцией мы интерпретируем текст.
				if timer<1 write(1) else timer--
				// Этой функцией мы осуществляем выведение символа, когда таймер меньше единицы.
				// Это нужно, чтобы реализовать задержку в тексте (например, в знаках препинаний).
				
			}
			
			if _poll { // Если переменная _poll существует, нам следует обработать выбор вариантов ответов.
				
				poll_handle(1)
				// Для удобства скрипт вынесен в отдельную функцию.
				// Пока текст сообщения не показан полностью, игрок сможет выбрать перебивающий ответ, если такой предусмотрен.
				
			}
			
			else {
				poll_selector_alpha=lerp(poll_selector_alpha,0,0.1)
				if (timer_line*0.3)>timer_redline {
					getkey("ok",clear) // Очищаем кнопку действия, чтобы избавиться от возможных багов.
					with o_letter destroy=1 // Передаем сигнал самоуничтожения созданным объектам-буквам.
					current_msg++ // Переходим к следующему сообщению.
					if !(array_length(global.msg)>current_msg) reset() else reset(1)
				}
			}
			
		}
	
		else { // Если все сообщение выведено на экран, то просто ожидаем действий от игрока.
			
			if getkey("ok",pressed) and !_poll {
				
				// Это скрипт перехода к следующему сообщению.
				// Он срабатывает, если нажата кнопка действия и в обрабатываемом сообщении нет выборов варинтов ответов.
				
				getkey("ok",clear) // Очищаем кнопку действия, чтобы избавиться от возможных багов.
				with o_letter destroy=1 // Передаем сигнал самоуничтожения созданным объектам-буквам.
				current_msg++ // Переходим к следующему сообщению.
				if !(array_length(global.msg)>current_msg) reset() else reset(1)
				// Если это было последнее сообщение, то делаем хард резет - приведение всех служебных переменных в изначальное состояние.
				// Если нет, то все равно нужно привести большинство переменных к стандартным знчениям.
				
			}
			
			if _poll { // Если переменная _poll существует, нам следует обработать выбор вариантов ответов.
				
				poll_handle()
				// Для удобства скрипт вынесен в отдельную функцию.
				
			}
			
			else {
				poll_selector_alpha=lerp(poll_selector_alpha,0,0.1)
				if (timer_line*0.3)>timer_redline {
					getkey("ok",clear) // Очищаем кнопку действия, чтобы избавиться от возможных багов.
					with o_letter destroy=1 // Передаем сигнал самоуничтожения созданным объектам-буквам.
					current_msg++ // Переходим к следующему сообщению.
					if !(array_length(global.msg)>current_msg) reset() else reset(1)
				}
			}
		
		}
	
	}
	else { // Если текста нет:
		
		current_msg++ // Переходим к следующему сообщению.
		if !(array_length(global.msg)>current_msg) reset() else reset(1)
		// Если это было последнее сообщение, то делаем хард резет - приведение всех служебных переменных в изначальное состояние.
		// Если нет, то все равно нужно привести большинство переменных к стандартным знчениям.
	}
	
}

if active=1 dbox_y1=lerp(dbox_y1,dbox_y1_open,dbox_anim_speed) else dbox_y1=lerp(dbox_y1,dbox_y1_close,dbox_anim_speed)
// Эта строчка отвечает за плавное выдвижение текстбокса.

draw_set_color(0)
draw_set_alpha(1)
draw_rectangle(dbox_x1,dbox_y1,dbox_x2,dbox_y2,0) // Этой строчкой мы рисуем текстбокс-прямоугольник.
draw_set_color(c_white)