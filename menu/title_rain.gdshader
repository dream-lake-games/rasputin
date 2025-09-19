shader_type canvas_item;

uniform float loop_time;

uniform float rep_x;
uniform float rep_y;
uniform float rain_amt;
uniform float rain_width;
uniform float rain_length;
uniform float rain_speed;
uniform float theta = 0.0;
uniform vec4 rain_color : source_color;

void fragment() {
	float atheta = theta * 3.1415926 / 180.0;
	vec2 rotated_uv = vec2(
		cos(atheta) * UV.x - sin(atheta) * UV.y,
		sin(atheta) * UV.x + cos(atheta) * UV.y
	);
    vec2 uv = vec2(fract(rotated_uv.x * rep_x), fract(rotated_uv.y * rep_y));

    float remainder = fract(uv.x * rain_amt) / rain_amt;
    float grid_x = uv.x - remainder;
    float rn = fract(sin(grid_x * rain_amt * rain_length * rain_speed));

	float speed = rain_speed / loop_time;

    float y_pos = fract(uv.y + rn * loop_time - TIME * speed);
    float is_raindrop = step(1.0 - rain_length, y_pos) * step(remainder * rain_amt, rain_width);

    COLOR = vec4(rain_color.rgb, rain_color.a * is_raindrop);
}