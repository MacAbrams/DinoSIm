#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform sampler2D foods;
uniform float numFoods;
uniform vec2 resolution;


void main(){
    vec2 uv = gl_FragCoord.xy/resolution;
    float texCoord = floor(uv.x*100.)/100.;

    // uv*=256;

    vec3 color= vec3(0.);
    float smell=0.0;
    for(float i=0.0;i<=1.0;i+=1./100.){
        vec2 position = (texture(foods, vec2(i,1)).xy);
        float d = length(gl_FragCoord.xy - position*resolution.xy );
        // smell = (d<0.01)?1.:smell;
        smell+=1./(d*d);
    }


    gl_FragColor = vec4(  0., smell  ,0.,1.);
}