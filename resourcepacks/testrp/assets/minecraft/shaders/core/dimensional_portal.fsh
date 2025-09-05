// Copied from the end portal shader
// h e l p
#version 150

#moj_import <matrix.glsl>

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;

uniform float GameTime;
uniform int EndPortalLayers;

in vec4 texProj0;

const vec3[] COLORS = vec3[](
    vec3(0.071, 0.031, 0.110),
    vec3(0.039, 0.020, 0.090),
    vec3(0.043, 0.043, 0.102),
    vec3(0.059, 0.078, 0.110),
    vec3(0.063, 0.118, 0.094),
    vec3(0.063, 0.086, 0.122),
    vec3(0.106, 0.161, 0.129),
    vec3(0.125, 0.149, 0.110),
    vec3(0.157, 0.133, 0.188),
    vec3(0.180, 0.165, 0.122),
    vec3(0.149, 0.149, 0.145),
    vec3(0.239, 0.204, 0.102),
    vec3(0.212, 0.169, 0.208),
    vec3(0.322, 0.224, 0.082),
    vec3(0.388, 0.388, 0.271),
    vec3(0.659, 0.137, 0.643)
);

const mat4 SCALE_TRANSLATE = mat4(
    0.5, 0.0, 0.0, 0.25,
    0.0, 0.5, 0.0, 0.25,
    0.0, 0.0, 1.0, 0.0,
    0.0, 0.0, 0.0, 1.0
);

mat4 end_portal_layer(float layer) {
    mat4 translate = mat4(
        1.0, 0.0, 0.0, 17.0 / layer,
        0.0, 1.0, 0.0, (2.0 + layer / 1.5) * (GameTime * 1.5),
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0
    );

    mat2 rotate = mat2_rotate_z(radians((layer * layer * 4321.0 + layer * 9.0) * 2.0));

    mat2 scale = mat2(4.5 - layer / 4.0);

    return mat4(scale * rotate) * translate * SCALE_TRANSLATE;
}

out vec4 fragColor;

void main() {
    vec3 color = textureProj(Sampler0, texProj0).rgb * COLORS[0];
    for (int i = 0; i < EndPortalLayers; i++) {
        color += textureProj(Sampler1, texProj0 * end_portal_layer(float(i + 1))).rgb * COLORS[i];
    }
    fragColor = vec4(color, 1.0);
}
