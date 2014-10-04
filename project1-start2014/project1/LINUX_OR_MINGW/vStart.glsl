#version 150

in  vec4 vPosition;
in  vec3 vNormal;
in  vec2 vTexCoord;

out vec2 texCoord;
out vec3 pos;
out vec3 N;

uniform mat4 ModelView;
uniform mat4 Projection;

void main()
{
    // Transform vertex position into eye coordinates
    vec3 pos = (ModelView * vPosition).xyz;

	
	// Transform vertex normal into eye coordinates (assumes scaling is uniform across dimensions)
    vec3 N = normalize( (ModelView*vec4(vNormal, 0.0)).xyz );
	
    gl_Position = Projection * ModelView * vPosition;
    texCoord = vTexCoord;
}
