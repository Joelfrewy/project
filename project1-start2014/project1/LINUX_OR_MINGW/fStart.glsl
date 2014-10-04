#version 150

in vec3 N;
in vec3 pos;

in  vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
out vec4 fColor;
uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;

uniform float Shininess;
uniform vec4 LightPosition;
uniform sampler2D texture;

void
main()
{
	vec4 color;

	vec3 Lvec = LightPosition.xyz - pos;
	float distance = length(Lvec);
	
	vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector
	
    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct;

    float Kd = max( dot(L, N), 0.0 );
    vec3  diffuse = Kd*DiffuseProduct;

    float Ks = pow( max(dot(N, H), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct;
	if(H == vec3(0.0,0.0,0.0)){
    specular = vec3(100.0,20.0,0.0);}
    if( dot(L, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 

    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.1, 0.1, 0.1);
    color.rgb = (globalAmbient  + ambient + diffuse + specular)/distance;
    color.a = 1.0;
	
    fColor = color * texture2D( texture, texCoord * 2.0 );
}
