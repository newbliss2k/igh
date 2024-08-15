function player_event(_key="ok") {
	
	if place_meeting(x,y,o_chara) and global.game.mode="walk" {
		action_alpha=min(action_alpha+0.05,1)
		//log_push(string(action_alpha))
	}
	else action_alpha=max(action_alpha-0.05,0)
	
	var _key_pressed = getkey(_key,pressed)
	
	if (global.game.pause=0) and (global.game.mode="walk") and place_meeting(x,y,o_chara) and _key_pressed and (o_writer.active=0) {
		getkey("ok",clear)
		return (global.game.pause=0) and (global.game.mode="walk") and place_meeting(x,y,o_chara) and _key_pressed and (o_writer.active=0)
	}
}

// Данной функцией можно добавить объект в конец списка MSG.
function msg_append(_struct) {
	
	array_push(global.msg,_struct)
	
}

// Данной функцией можно добавить текст в конец списка MSG. Второй аргумент отвечает отвечает за паузу перед добавленным сообщением
function msg_text(_string,_timer=30) {
	
	for(var _i=0;_i<_timer;_i++) array_push(global.msg,{})
	
	array_push(global.msg,{text:_string})
	
}

// Данной функцией можно добавить скрипт в конец списка MSG. Он выполнится, когда очередь до него.
function msg_func(_func) {
	
	array_push(global.msg,{func:_func})
	
}

// Данная функция добавит скрипт к последнему объекту в списке.
function msg_func_add(_func) {
	
	array_last(global.msg).func=_func
	
}

// Данная функция добавит выбор вариантов ответов к последнему объекту в списке.
function msg_poll(_poll,_timer=30) {
	
	array_last(global.msg).poll=_poll
	
	for(var _i=0;_i<_timer;_i++) array_push(global.msg,{})
	
}

// Данная функция добавит ожидание в миллисекундах.
function msg_sleep(_ms) {
	
	for(var _i=0;_i<_ms;_i++) array_push(global.msg,{})
	
}