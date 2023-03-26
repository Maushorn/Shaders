void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord.xy - 0.5*iResolution.xy) /iResolution.y;
    //Map to polar coordinates
    vec2 st = vec2(atan(uv.y,uv.x), length(uv));
    
    //2*PI = 6.28
    //Map to [0.0, 1.0]
    uv =vec2( st.x/6.28 +.5 +iTime/8. ,st.y);

    float x = uv.x*6.0;
    
    //This makes the zickzack
    float m = min(fract(x), fract(1.-x));
    float c = smoothstep(0.,.1,m*.3+.2-uv.y);
    
    // Time varying pixel color
    vec3 col = vec3(0.);
    col = vec3(uv, 0.5);

    // Output to screen
    fragColor = vec4(c);
}