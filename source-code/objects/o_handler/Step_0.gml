game_timer++

if getkey("debug_gravity") window_set_fullscreen(!window_get_fullscreen())

o_handler_step_control()

if (global.game.pause=0) and !(room=r_menu_main) o_handler_step_camera()
