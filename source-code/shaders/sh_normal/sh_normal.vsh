//--------------------------------------------------------------
    attribute vec3 in_Position;                  // (x,y,z)
    attribute vec4 in_Colour;                    // (r,g,b,a)
    attribute vec2 in_TextureCoord;              // (u,v)
//--------------------------------------------------------------
    varying vec2 v_vTexcoord;
    varying vec3 v_vColour;
    varying mat2 rot;
    varying vec2 world_pos;
//--------------------------------------------------------------
    void main() {
        vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
        gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
        world_pos = object_space_pos.xy;
        //--------------------------------------------------------------
        float angle = in_Colour.a * 6.283185307;
        vec2 cs = vec2( cos( angle ), -sin( angle ) );
        rot = mat2( cs, vec2( -cs.y, cs.x ) );
        //--------------------------------------------------------------
        v_vTexcoord = in_TextureCoord;
        v_vColour = in_Colour.rgb;
    }
//--------------------------------------------------------------
