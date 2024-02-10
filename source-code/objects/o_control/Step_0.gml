if (global.aspectratio <= 0.5625)
{
    zx = 480-164+border //476
    xx = 480-83+border //557
    cx = 480-2+border //638
    jx = 0
}
else
{
    zx = 480-253+border //387
    xx = 480-172+border //468
    cx = 480-91+border //549
    jx = 100
}
if (global.aspectratio != aspectratio_previous)
{
    virtual_key_delete(virtual_key_z)
    virtual_key_delete(virtual_key_x)
    virtual_key_delete(virtual_key_c)
    virtual_key_z = virtual_key_add(zx, 347, 81, 93, 90)
    virtual_key_x = virtual_key_add(xx, 308, 81, 93, 88)
    virtual_key_c = virtual_key_add(cx, 269, 81, 93, 67)
}
aspectratio_previous = global.aspectratio

// 
var _device_mouse_current_x_to_gui=device_mouse_current_x_to_gui()
var _device_mouse_current_y_to_gui=device_mouse_current_y_to_gui()
var _angle = point_direction(jx, jy, _device_mouse_current_x_to_gui, _device_mouse_current_y_to_gui)
var _outerx = (jx + (dcos(_angle) * 62))
var _outery = (jy + (dsin((_angle + 180)) * 62))
var _deadzonex = (jx + (dcos(_angle) * (global.controller_deadzoner * 24)))
var _deadzoney = (jy + (dsin((_angle + 180)) * (global.controller_deadzoner * 24)))
var _joy_rightp = global.joy_right
var _joy_leftp = global.joy_left
var _joy_upp = global.joy_up
var _joy_downp = global.joy_down
global.joy_right = 0
global.joy_left = 0
global.joy_up = 0
global.joy_down = 0
if (device_mouse_check_any() && device_mouse_current_x_to_gui() <= 400)
{
    if ((sqr((device_mouse_current_x_to_gui() - jx)) + sqr((device_mouse_current_y_to_gui() - jy))) > sqr(62))
    {
        x = _outerx
        y = _outery
    }
    else
    {
        x = device_mouse_current_x_to_gui()
        y = device_mouse_current_y_to_gui()
    }
    if ((sqr((device_mouse_current_x_to_gui() - jx)) + sqr((device_mouse_current_y_to_gui() - jy))) > sqr((global.controller_deadzoner * 24)))
    {
        if (_angle < 0)
            _angle = (_angle + 360)
        if (_angle < 67.5 || _angle > 292.5)
            global.joy_right = 1
        if (_angle > 22.5 && _angle < 157.5)
            global.joy_up = 1
        if (_angle > 112.5 && _angle < 247.5)
            global.joy_left = 1
        if (_angle > 202.5 && _angle < 337.5)
            global.joy_down = 1
    }
}
else
{
    x = jx
    y = jy
}
if (global.joy_right != _joy_rightp && global.joy_right)
    keyboard_key_press(vk_right)
if (global.joy_left != _joy_leftp && global.joy_left)
    keyboard_key_press(vk_left)
if (global.joy_down != _joy_downp && global.joy_down)
    keyboard_key_press(vk_down)
if (global.joy_up != _joy_upp && global.joy_up)
    keyboard_key_press(vk_up)
if (global.joy_right != _joy_rightp && global.joy_right == 0)
    keyboard_key_release(vk_right)
if (global.joy_left != _joy_leftp && global.joy_left == 0)
    keyboard_key_release(vk_left)
if (global.joy_down != _joy_downp && global.joy_down == 0)
    keyboard_key_release(vk_down)
if (global.joy_up != _joy_upp && global.joy_up == 0)
    keyboard_key_release(vk_up)
