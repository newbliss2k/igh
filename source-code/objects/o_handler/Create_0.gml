if room=r_init {
	
	scr_getkey_setup()
	room_goto(r_gameplay_test)
	
}

if room=r_gameplay_test {
	
	instance_create_depth(mouse_x,mouse_y,0,o_aim)
	
}

global.osflavor=os_type
global.aspectratio=display_get_width()/display_get_height()
instance_create_depth(20,140,-15999,o_control)

view_camera[0]=camera_create_view(0,0,view_wport[0],view_hport[0],0,noone,-1,-1,-1,-1)
_mouse_x = device_mouse_x_to_gui(0)/3*2
_mouse_y = device_mouse_y_to_gui(0)/3*2
_mouse_factor = 3