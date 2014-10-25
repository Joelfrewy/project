#version 150

in vec3 N;
in vec3 pos;

in  vec2 texCoord;  // The third coordinate is always 0.0 and is discarded
out vec4 fColor;
uniform vec3 AmbientProduct, DiffuseProduct, SpecularProduct;
uniform vec3 AmbientProduct2, DiffuseProduct2, SpecularProduct2;
uniform float Shininess;
uniform vec4 LightPosition;
uniform vec4 Light2Position;
uniform sampler2D texture;
uniform float texScale;

void
main()
{
	vec4 color;
	vec4 scolor;
	vec3 Lvec = LightPosition.xyz - pos;
	vec3 L2vec = Light2Position.xyz;
	float distance = length(Lvec);
	
	vec3 L = normalize( Lvec );   // Direction to the light source
    vec3 E = normalize( -pos );   // Direction to the eye/camera
    vec3 H = normalize( L + E );  // Halfway vector
	
	vec3 L2 = normalize( L2vec );   // Direction to the light source
    vec3 E2 = normalize( -pos );   // Direction to the eye/camera
    vec3 H2 = normalize( L + E );  // Halfway vector
	
    // Compute terms in the illumination equation
    vec3 ambient = AmbientProduct + AmbientProduct2;

    float Kd = max( dot(L, N), 0.0 );
	float Kd2 = max( dot(L2, N), 0.0 );
    vec3  diffuse = Kd * DiffuseProduct / distance / distance + Kd2 * DiffuseProduct2;

	float Ks = pow( max(dot(N, H), 0.0), Shininess );
    float Ks2 = pow( max(dot(N, H2), 0.0), Shininess );
    vec3  specular = Ks * SpecularProduct /distance / distance + Ks2 * SpecularProduct2;
    if( dot(L, N) < 0.0 || dot(L2, N) < 0.0 ) {
	specular = vec3(0.0, 0.0, 0.0);
    } 

	
    // globalAmbient is independent of distance from the light source
    vec3 globalAmbient = vec3(0.3, 0.3, 0.3);
    color.rgb = (globalAmbient  + ambient + diffuse);
    color.a = 1.0;
	scolor.rgb = specular;
	color.a = 1.0;
	
    fColor = color * texture2D( texture, texCoord * 2.0 * texScale ) + scolor;
}
