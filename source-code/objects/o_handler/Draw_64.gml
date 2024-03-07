draw_text(0,0,device_mouse_x_to_gui(0))
draw_text(0,20,device_mouse_y_to_gui(0))

draw_text(0,40,o_chara.y_speed)
draw_text(0,60,o_chara1.y_speed)

/*draw_set_alpha(0.1)

var _grid=60

for (var _i=0; _i<(1920/_grid); _i++) draw_line(_i*_grid,0,_i*_grid,1080)
for (var _i=0; _i<(1080/_grid); _i++) draw_line(0,_i*_grid,1920,_i*_grid)
/**/