shader_type spatial;
render_mode unshaded, cull_back;

// PS1/Retro FPS shader inspired by Warhammer 40K Boltgun
uniform vec4 albedo : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform sampler2D texture_albedo : source_color, filter_nearest, repeat_enable;
uniform float vertex_snap : hint_range(0.0, 1.0) = 0.05;
uniform float affine_texture_mapping : hint_range(0.0, 1.0) = 1.0;
uniform bool use_texture = false;

varying vec3 world_pos;
varying vec2 vertex_uv;
varying float vertex_distance;

void vertex() {
	// Vertex snapping for PS1 effect
	vec4 snap_pos = MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	snap_pos.xyz = snap_pos.xyz / snap_pos.w;
	
	float grid_size = vertex_snap * 100.0;
	snap_pos.x = floor(snap_pos.x / grid_size) * grid_size;
	snap_pos.y = floor(snap_pos.y / grid_size) * grid_size;
	snap_pos.z = floor(snap_pos.z / grid_size) * grid_size;
	
	snap_pos.xyz *= snap_pos.w;
	POSITION = PROJECTION_MATRIX * snap_pos;
	
	// Store world position
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	
	// Affine texture mapping (PS1 style - no perspective correction)
	vertex_uv = UV;
	vertex_distance = POSITION.z;
}

void fragment() {
	vec4 tex_color = albedo;
	
	if (use_texture) {
		// Affine texture mapping
		vec2 corrected_uv = mix(vertex_uv, UV, 1.0 - affine_texture_mapping);
		tex_color = texture(texture_albedo, corrected_uv) * albedo;
	}
	
	// Distance-based color quantization (more retro at distance)
	float dist = length(world_pos - CAMERA_POSITION_WORLD);
	float color_steps = mix(32.0, 8.0, clamp(dist / 50.0, 0.0, 1.0));
	
	tex_color.rgb = floor(tex_color.rgb * color_steps) / color_steps;
	
	// Simple fog
	float fog_start = 20.0;
	float fog_end = 80.0;
	float fog_factor = clamp((dist - fog_start) / (fog_end - fog_start), 0.0, 1.0);
	vec3 fog_color = vec3(0.2, 0.2, 0.25);
	tex_color.rgb = mix(tex_color.rgb, fog_color, fog_factor);
	
	ALBEDO = tex_color.rgb;
	ALPHA = tex_color.a;
}
