#version 150

in  vec4 vPosition;
in  vec3 vNormal;
in  vec2 vTexCoord;
in ivec4 boneIDs;
in vec4 boneWeights;

out vec2 texCoord;
out vec3 N;
out vec3 pos;
uniform mat4 boneTransforms[64];
uniform mat4 ModelView;
uniform mat4 Projection;

void main()
{
	mat4 boneTransform = boneWeights[0] * boneTransforms[boneIDs[0]] + boneWeights[1] * boneTransforms[boneIDs[1]] + boneWeights[2] * boneTransforms[boneIDs[2]] + boneWeights[3] * boneTransforms[boneIDs[3]];
	vec3 tvNormal = mat3(boneTransform) * vNormal;
	vec4 tvPosition = boneTransform * vPosition;
	pos = (ModelView * tvPosition).xyz;
	// Transform vertex normal into eye coordinates (assumes scaling is uniform across dimensions)
    N = normalize( (ModelView*vec4(tvNormal, 0.0)).xyz );
	
	// Unit direction vectors for Blinn-Phong shading calculation
    
	
    gl_Position = Projection * ModelView * tvPosition;
    texCoord = vTexCoord;
}
