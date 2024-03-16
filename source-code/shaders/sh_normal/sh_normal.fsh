//--------------------------------------------------------------
    varying vec2 v_vTexcoord;  //(u,v)
    varying vec3 v_vColour; //(r,g,b) note: no alpha cuz we're using it for something else
    varying mat2 rot;
    varying vec2 world_pos;
//--------------------------------------------------------------    
    uniform sampler2D normal_tex;
    uniform float num_lights;
    uniform float lights[60];  //max lights here is 10 (60 / 6)
//--------------------------------------------------------------        
    int num_lights2 = 6 * int(num_lights);  
//--------------------------------------------------------------   
    vec3 light_pos;
    vec3 light_dir;
    float light_level;    
    float light_dist;
//--------------------------------------------------------------    
    void main() {
        vec3 normal_colour = texture2D( normal_tex, v_vTexcoord ).rgb * 2.0 - 1.0;
        vec3 light_colour = vec3(0.0);
        //--------------------------------------------------------------    
        for ( int i = 0; i < num_lights2; i += 6 ) {
            light_pos = vec3( lights[i], lights[i+1], lights[i+2] );
            light_dir = vec3( world_pos.xy -  light_pos.xy, light_pos.z );
            light_dist = length( light_dir );
            light_level = 1.0 / ( 1.0 + light_dist + 0.1 * light_dist * light_dist );  //light attenuation (might want to play around with this a little)
            light_dir = vec3( light_dir.xy * rot, light_dir.z );
            light_level *= max( dot( normalize( light_dir ), normal_colour ), 0.0 );  //light should never be below zero
            light_colour += light_level * vec3( lights[i+3], lights[i+4], lights[i+5] );
        }
        //--------------------------------------------------------------    
        vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord );
        gl_FragColor = vec4( v_vColour * colour.rgb * light_colour , colour.a );
    }
//--------------------------------------------------------------
