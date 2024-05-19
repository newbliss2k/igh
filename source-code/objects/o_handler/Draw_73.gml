//--------------------------------------------------------------
    shader_reset();
//--------------------------------------------------------------

draw_set_alpha(0.1)
draw_set_color(c_white)
var _grid=32
for (var _i=0; _i<(1920/_grid); _i++) draw_line(_i*_grid,0,_i*_grid,1080)
for (var _i=0; _i<(1080/_grid); _i++) draw_line(0,_i*_grid,1920,_i*_grid)
draw_set_alpha(1)