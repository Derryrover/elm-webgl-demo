module FragmentShader exposing (fragmentShader)

import Math.Vector3 exposing (Vec3)
import Math.Vector4 exposing (Vec4)
import WebGL exposing (Shader)


fragmentShader : Shader {} { u | shade : Float } { vColor : Vec3, vTransformedNormal: Vec3, vPosition : Vec4 }
fragmentShader =
    [glsl|

precision mediump float;

uniform float shade; // needed?

varying vec3 vColor;
varying vec3 vTransformedNormal;
varying vec4 vPosition;

void main () {

    vec3 normal = normalize(vTransformedNormal);
    vec3 eyeDirection = normalize( vPosition.xyz - vec3(0.0,0.0,5.0) );

    vec3 ambientLight = vec3(0.6, 0.6, 0.6);
    vec3 pointLightingColor = vec3(0.7, 0.7, 0.7);
    vec3 pointLightingSpecularColor = vec3(0.3, 0.3, 0.3);
    float materialShininess = 2.0;


    vec3 lightDirection = vec3(0.0, 0.0, 5.0);
    //vec3 relativeLightDirection = normalize( vPosition.xyz - lightDirection );
    vec3 relativeLightDirection = normalize( vPosition.xyz - lightDirection);

    //vec3 reflectionDirection = reflect(relativeLightDirection, normal); // original
    vec3 reflectionDirection = reflect(-relativeLightDirection, normal); // original
    //vec3 reflectionDirection = reflect(lightDirection, normal);

    float specularLightWeighting = pow(max(dot(reflectionDirection, eyeDirection), 0.0), materialShininess);


    float directionalLightWeighting = max(dot(normal, -relativeLightDirection), 0.0);
    //float directionalLightWeighting = max(dot(normal, relativeLightDirection), 0.0);
    //highp vec3 lightWeighting = ambientLight + pointLightingColor * directionalLightWeighting + specularLightWeighting * pointLightingSpecularColor;
    //highp vec3 lightWeighting = ambientLight + specularLightWeighting * pointLightingSpecularColor;

    highp vec3 lightWeighting = ambientLight + pointLightingColor * directionalLightWeighting;
    //gl_FragColor = vec4(vColor * lightWeighting, 1.0);
    gl_FragColor = vec4((vColor * lightWeighting+specularLightWeighting * pointLightingSpecularColor), 1.0);
    //gl_FragColor = vec4(1.0,1.0,1.0,1.0);




}

|]

{-
fragmentShader : Shader {} { u | shade : Float } { vcolor : Vec3, vlighting: Vec3 }
fragmentShader =
    [glsl|

precision mediump float;
uniform float shade;
varying vec3 vlighting;
varying vec3 vcolor;
void main () {
    // lightning and color
    //gl_FragColor = vec4(vcolor * vlighting, 1.0);

    // shows whiter colors
    //gl_FragColor = vec4(vcolor * vlighting, 0.7);


    // no difference
    //gl_FragColor = vec4(vcolor, 1.6);

    // shows nothing
    //gl_FragColor = vec4(vcolor + vlighting, 1.0);

    // no lighting
    //gl_FragColor = vec4(vcolor, 1.0);

    gl_FragColor = vec4(vcolor * vlighting, 1.0);


}

|]
-}

{-

gl_FragColor = shade * vec4(vcolor, 1.0);

    gl_FragColor = shade * vec4(vcolor, 1.0);
-}
