normal_tex = sprite_get_texture( sprite_index, image_index );
//--------------------------------------------------------------
    //set normal texture uniform if it doesn't already equal our normal_tex
    /*if ( global.normal_tex != normal_tex ) { 
        texture_set_stage( global.sh_normal_normal_tex, normal_tex );
        global.normal_tex = normal_tex;
    }*/

draw_set_alpha(1)
draw_text(x,y-100,((control_jump(pressed)=1) and !(control_walk()=0)) or ((control_jump()=1) and !(control_walk(pressed)=0)))

draw_rectangle(x-timer_coyot*10,y-100,x+timer_coyot*10,y-105,0)
//--------------------------------------------------------------
    draw_self();
//--------------------------------------------------------------