normal_tex = sprite_get_texture( sprite_index, image_index );
//--------------------------------------------------------------
    //set normal texture uniform if it doesn't already equal our normal_tex
    /*if ( global.normal_tex != normal_tex ) { 
        texture_set_stage( global.sh_normal_normal_tex, normal_tex );
        global.normal_tex = normal_tex;
    }*/
//--------------------------------------------------------------
    draw_self();
//--------------------------------------------------------------