if getkey("esc") game_end()

var _view_x = camera_get_view_x(view_camera[0]);
var _view_y = camera_get_view_y(view_camera[0]);
var _view_w = camera_get_view_width(view_camera[0]);
var _view_h = camera_get_view_height(view_camera[0]);

//_mouse_x=xx
//_mouse_y=yy

if getkey("x") {
	_mouse_x=(device_mouse_x_to_gui(0)/3*2 - (_view_w * 0.5))
	_mouse_y=(device_mouse_y_to_gui(0)/3*2 - (_view_h * 0.5))
} else {
	_mouse_x=(device_mouse_x_to_gui(0)/3*2 - (_view_w * 0.5))/_mouse_factor
	_mouse_y=(device_mouse_y_to_gui(0)/3*2 - (_view_h * 0.5))/_mouse_factor
}

var _goto_x = o_chara.x + _mouse_x - (_view_w * 0.5)
var _goto_y = o_chara.y + _mouse_y - (_view_h * 0.5)

// borders

if (_goto_x + _view_w) > room_width _goto_x = room_width - _view_w
if (_goto_y + _view_h) > room_height _goto_y = room_height - _view_h

if _goto_x < 0 _goto_x = 0
if _goto_y < 0 _goto_y = 0

// lerping

var _new_x = lerp(_view_x, _goto_x, 0.1);
var _new_y = lerp(_view_y, _goto_y, 0.1);

camera_set_view_pos(view_camera[0], _new_x, _new_y)


if getkey("z",pressed) {
    //randomize lights
    var _brightness;
    for (var i = 0; i < ( num_lights * 6 ); i += 6) {
        light_array[i] = random_range(0, room_width ); //x
        light_array[i+1] = random_range( 0, room_height ); //y
        light_array[i+2] = random_range(20,250); //z
        _brightness = power( random( 1 ), 3 ) * 6000 + 1500;
        light_array[i+3] = random(1) * _brightness; //r
        light_array[i+4] = random(1) * _brightness; //g
        light_array[i+5] = random(1) * _brightness; //b
    }

}