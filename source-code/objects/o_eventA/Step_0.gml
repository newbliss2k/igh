


if player_event() {
	
	//msg_text("Здравствуйте,<timer=15> и добро пожаловать в тестовую комнату!<timer=25> /nЯ -<timer=15> тестовая табличка.")
	////msg_text("В этом тексте есть <color=65280>задержка<color/> после знаков препинания. <timer=25>Круто,<timer=15> не прадва ли?")
	//msg_text("В этом тексте есть <color=65280>задержка<color/> после знаков препинания.<timer=25> Круто,<timer=15> не прадва ли?<timer=25> ")
	
	msg_text("Закрыто.<timer=25> Вернусь через пару месяцев.")
	
}
//	msg_poll([
		
//		/* 0 */ {ir:1, text:"\"Нет\"",func: function(_ir=0){
			
//			if _ir {
				
//				msg_sleep(25)
//				msg_text("Это было грубо<timer=15>.<timer=15>.<timer=15>.<timer=25> Когда ты перебиваешь собеседника,<timer=15> ему может стать обидно!<timer=25> Помни это,<timer=15> когда разговариваешь с другими персонажами.")
//				msg_text("Больше так не делай,<timer=15> хорошо?<timer=15> ")
				
//				msg_poll([
				
//					/* 0 */ {ir:1, text:"\"Иди нахуй.\"",func: function(_ir=0){
						
//						msg_text("Ха-ха!<timer=25> Сам иди нахуй.")
						
//					}},
					
//					/* 1 */ {text:"\"Извини, я не знал!\"",func: function(_ir=0){
						
//						msg_text("Ничего страшного!<timer=25> Все мы ошибаемся.")
//						msg_text("Но в качестве наказания тебе придется <color=12632256>ZOV <color=16776960>СВО <color=255>SVO <color=12632256>GOIДА <color=16776960>VOINA <color=255>UKRAINA <color=12632256>Z<color=16776960>Z<color=255>Z<color/>VZ")
//						msg_func(function(){
//							o_glitch.intensity=0.3
//							o_glitch.spd=5
//							o_glitch.noise=0.000
//							audio_play_sound(sfx_glitch1,2,0)
//							audio_pause_sound(global.game.ost)
//							game_set_speed(3,gamespeed_fps)
//						})
//						for(var _i=0;_i<3;_i++){
//							//msg_sleep(1)
//							msg_func(function(){
//								view_xport[0]=irandom_range(0,100)
//								view_yport[0]=irandom_range(0,50)
//								view_wport[0]=irandom_range(50,100)
//								view_hport[0]=irandom_range(50,200)
//							})
//						}
//						msg_func(function(){
//							room_goto(r_battle)
//							bktglitch_deactivate()
//							game_set_speed(60,gamespeed_fps)
//						})
						
						
//					}},
				
//				])
//			}
//			else {
//				msg_text("Жаль...<timer=25> Ты можешь выбрать другие варианты ответов,<timer=15> используя стрелки или кнопки W и S.<timer=25> Просто поговори с табличкой ещё раз!")
//			}
			
//		}},
		
//		/* 1 */ {text:"\"Да!\"",func: function(_ir=0){
			
//			msg_text("Я рад,<timer=15> что тебе понравилось!<timer=25> Ты можешь легко редактировать события в редакторе GameMaker.<timer=25> Просто скачай исходный код этой игры!<timer=15> ")
			
//			msg_poll([
				
//					/* 0 */ {text:"\"Открой страницу с исходным кодом\"",func: function(_ir=0){
						
//						msg_func(function(){url_open("https://github.com/newbliss2k/subside")})
//						msg_text("Я открыл страницу с исходным кодом игры на GitHub.<timer=25> Приятного моддинга!")
						
//					}},
					
//					/* 1 */ {text:"\"Приму к сведению\"",func: function(_ir=0){
						
//						msg_text("Отлично!")
						
//					}},
				
//				])
			
//		}},
		
//		/* 2 */ {text:"\"Третий вариант\"",func: function(_ir=0){
			
//			msg_text("Я не придумал,<timer=15> что ответить!")
			
//		}},
		
//	])
	
//}