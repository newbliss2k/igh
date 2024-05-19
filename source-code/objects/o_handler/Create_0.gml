self.x=0
self.y=0

global.game.animspeed=1

if room=r_init {
	
	//room_goto(r_gameplay_test)
	
}

if room=r_gameplay_test {
	
	instance_create_depth(mouse_x,mouse_y,0,o_aim)
	
}

global.osflavor=os_type
global.aspectratio=display_get_width()/display_get_height()
instance_create_depth(20,140,-15999,o_control)


var _camera_x = 0
var _camera_y = 0

if instance_exists(o_chara) {
	//_camera_x=o_chara.x
	//_camera_y=o_chara.y
}

view_camera[0]=camera_create_view(_camera_x/3*2,_camera_y/3*2,view_wport[0],view_hport[0],0,noone,-1,-1,-1,-1)
_mouse_x = device_mouse_x_to_gui(0)/3*2
_mouse_y = device_mouse_y_to_gui(0)/3*2
_mouse_factor = 3

shake_x=0
shake_y=0

camera_chara_error_threw=0

    randomize();
//--------------------------------------------------------------
    //shader uniforms
    sh_normal_num_lights = shader_get_uniform( sh_normal, "num_lights" );
    sh_normal_lights = shader_get_uniform( sh_normal, "lights" );
    global.sh_normal_normal_tex = shader_get_sampler_index( sh_normal, "normal_tex" );
//--------------------------------------------------------------
    //direction light is pointing to, i.e. opposite direction light is coming from.
    //light direction is normalized inside vertex shader
    num_lights = 10;
    light_array[59] = 0;
    var _brightness;
    for (var _i = 0; _i < ( num_lights * 6 ); _i += 6) {
        light_array[_i] = random_range(0, room_width ); //x
        light_array[_i+1] = random_range( 0, room_height ); //y
        light_array[_i+2] = random_range(20,250); //z
        _brightness = power( random( 1 ), 3 ) * 6000 + 1500;
        light_array[_i+3] = random(1) * _brightness; //r
        light_array[_i+4] = random(1) * _brightness; //g
        light_array[_i+5] = random(1) * _brightness; //b
    }
//--------------------------------------------------------------
    //used to keep track of the current texture assigned to shader normal sampler "normal_tex"
    //so that we can avoid resetting it unless the texture will change
    global.normal_tex =	0;
//--------------------------------------------------------------
    draw_set_color(c_white);  //white for showing text in gui
//--------------------------------------------------------------