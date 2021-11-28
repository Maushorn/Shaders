//Attach this shader to a material and attach the material to a TextureRect. Everzthing behind the TextureRect gets pixelated.

shader_type canvas_item;

/*Number of Pixels. Numbers under 50 are not recommended,
since the GraphicsCard has to do more calculations the bigger each pixel gets.*/
uniform float pixel_amount_x = 100.0;	
//A texture needs to be applied for screen reading shaders.
uniform sampler2D text;

	
void fragment(){
	
	vec2 resolution = 1.0/SCREEN_PIXEL_SIZE;
	float pixel_amount_y = pixel_amount_x/resolution.x*resolution.y;
	vec2 pixel_amount = vec2(pixel_amount_x, pixel_amount_y);
	
	
	float pixel_size = resolution.x/pixel_amount_x;
	vec2 position_new_resolution = SCREEN_UV*pixel_amount;
	vec2 pixel = floor(position_new_resolution)/pixel_amount;
	vec3 col = vec3(0.0,0.0,0.0);
	int pixel_size_int = int(pixel_size);
	
	for(int x = 0; x < pixel_size_int; x++){
		for(int y = 0; y < pixel_size_int; y++){
			col+=textureLod(SCREEN_TEXTURE,pixel+(vec2(float(x)/pixel_size,float(y)/pixel_size))/pixel_amount,0.0).rgb
			//col = mix(col, textureLod(SCREEN_TEXTURE,pixel+(vec2(float(x)/pixel_size,float(y)/pixel_size))/pixel_amount,0.0).rgb, 0.5);

		}	
	}
	col/=(pixel_size*pixel_size);
	COLOR=vec4(col, 1.0);
}