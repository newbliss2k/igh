display_set_gui_size(854, 480)
draw_sprite_ext(s_control_zkey, keyboard_check(ord("Z")), zx, 350, 3, 3, 0, c_white, global.controller_opacity)
draw_sprite_ext(s_control_xkey, keyboard_check(ord("X")), xx, 311, 3, 3, 0, c_white, global.controller_opacity)
draw_sprite_ext(s_control_ckey, keyboard_check(ord("C")), cx, 272, 3, 3, 0, c_white, global.controller_opacity)
draw_sprite_ext(s_joybase, 0, jx, jy, 3, 3, 0, joybase_colour, global.controller_opacity)
draw_sprite_ext(s_joystick, 0, x, y, 3, 3, 0, joystick_colour, global.controller_opacity)

if dzdraw
{
    draw_set_alpha(0.5)
    draw_set_color(c_red)
    draw_circle(jx, jy, (global.controller_deadzoner * 24), 0)
    draw_set_alpha(1)
}