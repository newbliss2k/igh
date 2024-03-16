//--------------------------------------------------------------   
    //need to set shader and light_pos before drawing asteroids
    //then reset shader after done... see: Draw End event 
    shader_set( sh_normal );
    //--------------------------------------------------------------
    shader_set_uniform_f( sh_normal_num_lights, num_lights );
    shader_set_uniform_f_array( sh_normal_lights, light_array );
//--------------------------------------------------------------

