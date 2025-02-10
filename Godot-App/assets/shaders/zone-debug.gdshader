shader_type spatial;
render_mode cull_disabled, unshaded;

uniform vec4 color : source_color = vec4(1.0, 0.2, 0.2, 0.5);  // Couleur de base
uniform vec4 colorB : source_color = vec4(1.0, 1.0, 1.0, 1.0);  // Bordure
uniform vec4 colorAnimationStart : source_color = vec4(0.0, 0.0, 1.0, 1.0);  // Bleu de départ
uniform vec4 colorAnimationEnd : source_color = vec4(0.0, 1.0, 1.0, 1.0);  // Bleu clair (cyan)
uniform float fade_length : hint_range(0.0, 1.0) = 0.3;
uniform float colorB_size : hint_range(0.0, 0.5) = 0.05;
uniform float pulse_speed : hint_range(0.1, 5.0) = 2.0;
uniform float time_offset = 0.0;

void fragment() {
    float height = UV.y;
    float fade_start = 1.0 - fade_length;
    float alpha = smoothstep(fade_start, 1.0, height) * color.a;
    float border = smoothstep(colorB_size, 0.0, height);
    float pulse = 0.5 + 0.5 * sin(TIME * pulse_speed + time_offset); // pulsation

    // Animation de la couleur basée sur la pulsation
    float animation_factor = 0.5 + 0.5 * sin(TIME * pulse_speed); // variation fluide de la pulsation
    vec3 animated_color = mix(colorAnimationStart.rgb, colorAnimationEnd.rgb, animation_factor);  // Interpolation entre bleu et cyan

    vec3 final_color = mix(color.rgb, colorB.rgb * pulse, border);
    final_color = mix(final_color, animated_color, fade_start); // Mélange avec la couleur animée

    float final_alpha = mix(colorB.a, 1, height);

    ALBEDO = final_color;
    ALPHA = final_alpha;
	//ALPHA = color.a;

}