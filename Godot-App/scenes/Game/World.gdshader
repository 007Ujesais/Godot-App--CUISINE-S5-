shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float limit : hint_range(0.0, 0.5) = 0.2;
uniform float blur : hint_range(0.0, 5.0) = 2.0;
uniform float intensity : hint_range(0.0, 5.0) = 2.0;
uniform bool debug = true;

void fragment() {

    vec4 color = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur);

    if (UV.y < limit) {
        float _step = smoothstep(limit, 0.0, UV.y * intensity);
        COLOR.rgb = debug ? vec3(1.0) : color.rgb;
        COLOR.a = _step;
    }
    else if (UV.y > 1.0 - limit) {
        float _step = smoothstep(limit, 0.0, (1.0 - UV.y) * intensity);
        COLOR.rgb = debug ? vec3(1.0) : color.rgb;
        COLOR.a = _step;
    }
    else {
        COLOR.rgb = color.rgb;
        COLOR.a = 0.0;
    }
}
