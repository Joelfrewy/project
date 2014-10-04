#version 150

in  vec4 vPosition;
in  vec3 vNormal;
in  vec2 vTexCoord;

out vec2 texCoord;
out vec3 N;
out vec3 pos;
uniform mat4 ModelView;
uniform mat4 Projection;

void main()
{
	pos = (ModelView * vPosition).xyz;
	// Transform vertex normal into eye coordinates (assumes scaling is uniform across dimensions)
    N = normalize( (ModelView*vec4(vNormal, 0.0)).xyz );
	
	// Unit direction vectors for Blinn-Phong shading calculation
    
	
    gl_Position = Projection * ModelView * vPosition;
    texCoord = vTexCoord;
}
