module VertexShader exposing (vertexShader)

import Math.Vector3 exposing (Vec3)
import Math.Vector4 exposing (Vec4)
import Math.Matrix4 exposing (Mat4)
import WebGL exposing (Shader)


vertexShader : Shader { attr | position : Vec3, color : Vec3, normal : Vec3 } { unif | rotation : Mat4, perspective : Mat4, camera : Mat4 } { vColor : Vec3, vTransformedNormal : Vec3,  vPosition : Vec4 }
vertexShader =
    [glsl|

attribute vec3 position;
attribute vec3 color;
attribute vec3 normal;

uniform mat4 rotation;
uniform mat4 perspective;
uniform mat4 camera;
varying vec3 vColor;
varying vec3 vTransformedNormal;
varying vec4 vPosition;

void main(void) {
  vColor = color;
  vPosition = rotation * vec4(position, 1.0);
  gl_Position = perspective * camera * vPosition;
  vec4 tempTransformedNormal = rotation * vec4(normal, 1.0);
  //vTransformedNormal = vec3(1.0,0.0,0.0);//tempTransformedNormal.xyz;
  vTransformedNormal = tempTransformedNormal.xyz;
}
|]


{-
vertexShader : Shader { attr | position : Vec3, color : Vec3, normal : Vec3 } { unif | rotation : Mat4, perspective : Mat4, camera : Mat4 } { vcolor : Vec3, vlighting : Vec3 }
vertexShader =
    [glsl|

attribute vec3 position;
attribute vec3 color;
attribute vec3 normal;
uniform mat4 perspective;
uniform mat4 camera;
uniform mat4 rotation;
varying vec3 vcolor;
varying highp vec3 vlighting;
void main () {
    gl_Position = perspective * camera * rotation * vec4(position, 1.0);
    vcolor = color;

    //vec3 ambientLight = vec3(0.9, 0.9, 0.9);
    vec3 ambientLight = vec3(0.7, 0.7, 0.7);
    //vec3 directionalLightColor = vec3(0.4, 0.4, 0.4);
    vec3 directionalLightColor = vec3(0.6, 0.6, 0.6);
    //vec3 specularLightColor = vec3(0.2, 0.2, 0.2);
    vec3 specularLightColor = vec3(0.9, 0.9, 0.9);

    vec4 transformedNormal = camera * rotation * vec4(normal, 0);
    vec4 lightDirection = normalize(vec4(0,0,1,0));
    float directionalLightWeighting = max(dot(transformedNormal, lightDirection), 0.0);

    vec4 positionEye = camera * rotation * vec4(position, 1.0);
    vec3 eyeDirection = -positionEye.xyz;
    vec3 reflectionDirection = reflect(-lightDirection.xyz, transformedNormal.xyz);

    float specularLightWeighting = max(dot(reflectionDirection, eyeDirection), 0.0);
    float specularLightWeightingPow = specularLightWeighting; // * specularLightWeighting;
    float specularLightWeightingPowDiv = 0.5* specularLightWeightingPow;

    ///*
    vlighting = ambientLight
                + specularLightColor * specularLightWeightingPowDiv //specularLightWeightingPow //specularLightWeighting
                + directionalLightColor * directionalLightWeighting;
    //*/

    //vlighting = ambientLight + (directionalLightColor * directionalLightWeighting);
}

|]

-}

{-
vlighting = ambientLight + (directionalLightColor * directionalLightWeighting);
-}


{-

precision mediump float;
    varying vec2 vTextureCoord;
    varying vec3 vTransformedNormal;
    varying vec4 vPosition;
    uniform float uMaterialShininess;
    uniform bool uShowSpecularHighlights;
    uniform bool uUseLighting;
    uniform bool uUseTextures;
    uniform vec3 uAmbientColor;
    uniform vec3 uPointLightingLocation;
    uniform vec3 uPointLightingSpecularColor;
    uniform vec3 uPointLightingDiffuseColor;
    uniform sampler2D uSampler;
    void main(void) {
        vec3 lightWeighting;
        if (!uUseLighting) {
            lightWeighting = vec3(1.0, 1.0, 1.0);
        } else {
            vec3 lightDirection = normalize(uPointLightingLocation - vPosition.xyz);
            vec3 normal = normalize(vTransformedNormal);
            float specularLightWeighting = 0.0;
            if (uShowSpecularHighlights) {
                vec3 eyeDirection = normalize(-vPosition.xyz);
                vec3 reflectionDirection = reflect(-lightDirection, normal);
                specularLightWeighting = pow(max(dot(reflectionDirection, eyeDirection), 0.0), uMaterialShininess);
            }
            float diffuseLightWeighting = max(dot(normal, lightDirection), 0.0);
            lightWeighting = uAmbientColor
                + uPointLightingSpecularColor * specularLightWeighting
                + uPointLightingDiffuseColor * diffuseLightWeighting;
        }
        vec4 fragmentColor;
        if (uUseTextures) {
            fragmentColor = texture2D(uSampler, vec2(vTextureCoord.s, vTextureCoord.t));
        } else {
            fragmentColor = vec4(1.0, 1.0, 1.0, 1.0);
        }
        gl_FragColor = vec4(fragmentColor.rgb * lightWeighting, fragmentColor.a);
    }
-}
