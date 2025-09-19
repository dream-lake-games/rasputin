shader_type canvas_item;

uniform int delta = 0;

uniform vec4 COLOR_ONE: source_color;
uniform vec4 COLOR_TWO: source_color;
uniform vec4 COLOR_THREE: source_color;
uniform vec4 COLOR_FOUR: source_color;

float color_distance(vec4 a, vec4 b) {
    vec3 diff = a.rgb - b.rgb;
    return length(diff);
}

vec4 delta_color(vec4 color, int applied_delta) {
    float dist1 = color_distance(color, COLOR_ONE);
    float dist2 = color_distance(color, COLOR_TWO);
    float dist3 = color_distance(color, COLOR_THREE);
    float dist4 = color_distance(color, COLOR_FOUR);

    int closest = 1;
    float min_dist = dist1;

    if (dist2 < min_dist) {
        min_dist = dist2;
        closest = 2;
    }
    if (dist3 < min_dist) {
        min_dist = dist3;
        closest = 3;
    }
    if (dist4 < min_dist) {
        min_dist = dist4;
        closest = 4;
    }

    // Apply delta with clamping
    int target = clamp(closest + applied_delta, 1, 4);

    if (target == 1) return COLOR_ONE;
    if (target == 2) return COLOR_TWO;
    if (target == 3) return COLOR_THREE;
    return COLOR_FOUR;
}

void fragment() {
	COLOR = delta_color(COLOR, delta);
}
