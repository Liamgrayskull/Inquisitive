#include "/lib/shaderSettings/particles.glsl"
/////////////////////////////////////
// Complementary Shaders by EminGT //
// With Euphoria Patches by SpacEagle17 //
/////////////////////////////////////

//Common//
#include "/lib/common.glsl"
#include "/lib/shaderSettings/raindropColor.glsl"
//#define GLOWING_COLORED_PARTICLES

//////////Fragment Shader//////////Fragment Shader//////////Fragment Shader//////////
#ifdef FRAGMENT_SHADER

in vec2 texCoord;
in vec2 lmCoord;

flat in vec3 upVec, sunVec;
in vec3 normal;

flat in vec4 glColor;

#ifdef CLOUD_SHADOWS
    flat in vec3 eastVec;

    #if SUN_ANGLE != 0
        flat in vec3 northVec;
    #endif
#endif

//Pipeline Constants//

//Common Variables//
float NdotU = dot(normal, upVec);
float NdotUmax0 = max(NdotU, 0.0);
float SdotU = dot(sunVec, upVec);
float sunFactor = SdotU < 0.0 ? clamp(SdotU + 0.375, 0.0, 0.75) / 0.75 : clamp(SdotU + 0.03125, 0.0, 0.0625) / 0.0625;
float sunVisibility = clamp(SdotU + 0.0625, 0.0, 0.125) / 0.125;
float sunVisibility2 = sunVisibility * sunVisibility;
float shadowTimeVar1 = abs(sunVisibility - 0.5) * 2.0;
float shadowTimeVar2 = shadowTimeVar1 * shadowTimeVar1;
float shadowTime = shadowTimeVar2 * shadowTimeVar2;

#ifdef OVERWORLD
    vec3 lightVec = sunVec * ((timeAngle < 0.5325 || timeAngle > 0.9675) ? 1.0 : -1.0);
#else
    vec3 lightVec = sunVec;
#endif

//Common Functions//

//Includes//
#include "/lib/util/spaceConversion.glsl"
#include "/lib/lighting/mainLighting.glsl"
#include "/lib/util/dither.glsl"

#if MC_VERSION >= 11500
    #include "/lib/atmospherics/fog/mainFog.glsl"
#endif

#if defined ATM_COLOR_MULTS || defined SPOOKY
    #include "/lib/colors/colorMultipliers.glsl"
#endif

#ifdef COLOR_CODED_PROGRAMS
    #include "/lib/misc/colorCodedPrograms.glsl"
#endif

#if defined BIOME_COLORED_NETHER_PORTALS && !defined BORDER_FOG
    #include "/lib/colors/skyColors.glsl"
#endif

#ifdef SS_BLOCKLIGHT
    #include "/lib/lighting/coloredBlocklight.glsl"
#endif

#ifdef AURORA_INFLUENCE
    #include "/lib/atmospherics/auroraBorealis.glsl"
#endif

//Program//
void main() {
    vec4 color = texture2D(tex, texCoord);
    vec4 colorP = color;
    color *= glColor;

    vec3 screenPos = vec3(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z);
    vec3 viewPos = ScreenToView(screenPos);
    float lViewPos = length(viewPos);
    vec3 playerPos = ViewToPlayer(viewPos);

    float dither = texture2D(noisetex, gl_FragCoord.xy / 128.0).b;
    #ifdef TAA
        dither = fract(dither + goldenRatio * mod(float(frameCounter), 3600.0));
    #endif

    #if defined ATM_COLOR_MULTS || defined SPOOKY
        atmColorMult = GetAtmColorMult();
    #endif

    #ifdef VL_CLOUDS_ACTIVE
        float cloudLinearDepth = texelFetch(gaux1, texelCoord, 0).r;

        if (cloudLinearDepth > 0.0) // Because Iris changes the pipeline position of opaque particles
        if (pow2(cloudLinearDepth + OSIEBCA * dither) * renderDistance < min(lViewPos, renderDistance)) discard;
    #endif

    float emission = 0.0, materialMask = OSIEBCA * 254.0; // No SSAO, No TAA
    vec2 lmCoordM = lmCoord;
    vec3 normalM = normal, geoNormal = normal, shadowMult = vec3(1.0);
    vec3 worldGeoNormal = normalize(ViewToPlayer(geoNormal * 10000.0));
    float purkinjeOverwrite = 0.0;
    #if defined IPBR && defined IPBR_PARTICLE_FEATURES
        // We don't want to detect particles from the block atlas
        #if MC_VERSION >= 12000
            float atlasCheck = 1100.0; // I think texture atlas got bigger in newer mc
        #else
            float atlasCheck = 900.0;
        #endif

    if (atlasSize.x < atlasCheck) {
        vec2 texCoordScaled = texCoord * 16384;
        if (texCoordScaled.x < 11536) {
            if (texCoordScaled.y < 12304) {
                if (texCoordScaled.x < 6144) {
                    if (texCoordScaled.y < 11520) {
                        if (texCoordScaled.x < 3456) {
                            if (texCoordScaled.x >= 128 && texCoordScaled.x < 2176 && texCoordScaled.y >= 8192 && texCoordScaled.y < 10240) {
                                emission = 5.0 * pow2(color.b);
                                color.a *= 0.5;
                            }
                        } else {
                            if (texCoordScaled.x >= 3456 && texCoordScaled.x < 6144 && texCoordScaled.y >= 10240 && texCoordScaled.y < 10496) {
                                color.a *= 0.5;
                                materialMask = 0.0;
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 384) {
                            if (texCoordScaled.x >= 104 && texCoordScaled.x < 200 && texCoordScaled.y >= 12288 && texCoordScaled.y < 12304) {
                                emission = 5.0;
                            }
                        } else {
                            if (texCoordScaled.y < 12288) {
                                if (texCoordScaled.x >= 384 && texCoordScaled.x < 1792 && texCoordScaled.y >= 11520 && texCoordScaled.y < 11648) {
                                    emission = 2.0 * max0(color.g - 0.25);
                                }
                            } else {
                                if (texCoordScaled.x >= 584 && texCoordScaled.x < 872 && texCoordScaled.y >= 12288 && texCoordScaled.y < 12304) {
                                    #ifdef GLOWING_MIME_ENERGY
                                        emission = 3.5;
                                        color.rgb *= color.rgb;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (texCoordScaled.y < 11008) {
                        if (texCoordScaled.x < 10880) {
                            if (texCoordScaled.x >= 6144 && texCoordScaled.x < 9600 && texCoordScaled.y >= 10240 && texCoordScaled.y < 10496) {
                                color.a *= 0.5;
                                materialMask = 0.0;
                            }
                        } else {
                            if (texCoordScaled.x >= 10880 && texCoordScaled.x < 11536 && texCoordScaled.y >= 9984 && texCoordScaled.y < 10240) {
                                #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                #endif
                                #ifdef PURPLE_END_FIRE_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                #endif
                                
                                emission = 2.0;
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 11256) {
                            if (texCoordScaled.y < 11776) {
                                if (texCoordScaled.x >= 9976 && texCoordScaled.x < 11000 && texCoordScaled.y >= 11008 && texCoordScaled.y < 11136) {
                                    emission = 5.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 6144 && texCoordScaled.x < 7552 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                    if (color.b > 0.6 && color.a > 0.9) {
                                        color.rgb = pow1_5(color.rgb);
                                        emission = 2.5;
                                    }
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 11648) {
                                if (texCoordScaled.x >= 11256 && texCoordScaled.x < 11536 && texCoordScaled.y >= 11008 && texCoordScaled.y < 11136) {
                                    color.a *= 0.5;
                                    materialMask = 0.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 11456 && texCoordScaled.x < 11536 && texCoordScaled.y >= 11648 && texCoordScaled.y < 11776) {
                                    emission = 2.5 * smoothstep1(color.a);
                                }
                            }
                        }
                    }
                }
            } else {
                if (texCoordScaled.x < 3584) {
                    if (texCoordScaled.y < 12384) {
                        if (texCoordScaled.x < 2880) {
                            if (texCoordScaled.x < 584) {
                                if (texCoordScaled.x >= 104 && texCoordScaled.x < 200 && texCoordScaled.y >= 12304 && texCoordScaled.y < 12384) {
                                    emission = 5.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 584 && texCoordScaled.x < 872 && texCoordScaled.y >= 12304 && texCoordScaled.y < 12384) {
                                    #ifdef GLOWING_MIME_ENERGY
                                        emission = 3.5;
                                        color.rgb *= color.rgb;
                                    #endif
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 12352) {
                                if (texCoordScaled.x >= 3136 && texCoordScaled.x < 3200 && texCoordScaled.y >= 12304 && texCoordScaled.y < 12352) {
                                    if (color.b > 0.6 && color.a > 0.9) {
                                        color.rgb = pow1_5(color.rgb);
                                        emission = 2.5;
                                    }
                                }
                            } else {
                                if (texCoordScaled.x < 3136) {
                                    if (texCoordScaled.x >= 2880 && texCoordScaled.x < 2944 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12384) {
                                        if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                            materialMask = 0.0;
                                            color.rgb = sqrt3(color.rgb);
                                            color.rgb *= 0.7;
                                            if (dither > 0.4) discard;
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        #ifdef OVERWORLD
                                        } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        
                                            if (color.a < 0.1 || isEyeInWater == 3) discard;
                                            color.a *= rainTexOpacity;
                                            color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                        } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        
                                            if (color.a < 0.1 || isEyeInWater == 3) discard;
                                            color.a *= snowTexOpacity;
                                            color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                        #endif
                                        } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                            color.rgb = sqrt2(color.rgb) * 0.35;
                                            if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                        }
                                        
                                        float dotColor = dot(color.rgb, color.rgb);
                                        if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                            // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                            emission = clamp(color.r * 8.0, 1.6, 5.0);
                                            color.rgb = pow1_5(color.rgb);
                                            lmCoordM = vec2(0.0);
                                            #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                                if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                    color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                            #endif
                                        } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                            // Lava Particles
                                            emission = 2.0;
                                            color.b *= 0.5;
                                            color.r *= 1.2;
                                            color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                            emission *= LAVA_EMISSION;
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                            #endif
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 3136 && texCoordScaled.x < 3200 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12368) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 3240) {
                            if (texCoordScaled.x < 2880) {
                                if (texCoordScaled.x >= 104 && texCoordScaled.x < 168 && texCoordScaled.y >= 12384 && texCoordScaled.y < 12448) {
                                    if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                        materialMask = 0.0;
                                        color.rgb = sqrt3(color.rgb);
                                        color.rgb *= 0.7;
                                        if (dither > 0.4) discard;
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    #ifdef OVERWORLD
                                    } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= rainTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                    } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= snowTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                    #endif
                                    } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                        color.rgb = sqrt2(color.rgb) * 0.35;
                                        if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                    }
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                        // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                        emission = clamp(color.r * 8.0, 1.6, 5.0);
                                        color.rgb = pow1_5(color.rgb);
                                        lmCoordM = vec2(0.0);
                                        #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                            if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                        #endif
                                    } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                        // Lava Particles
                                        emission = 2.0;
                                        color.b *= 0.5;
                                        color.r *= 1.2;
                                        color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                        emission *= LAVA_EMISSION;
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                        #endif
                                    }
                                }
                            } else {
                                if (texCoordScaled.x >= 2880 && texCoordScaled.x < 2944 && texCoordScaled.y >= 12384 && texCoordScaled.y < 12416) {
                                    if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                        materialMask = 0.0;
                                        color.rgb = sqrt3(color.rgb);
                                        color.rgb *= 0.7;
                                        if (dither > 0.4) discard;
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    #ifdef OVERWORLD
                                    } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= rainTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                    } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= snowTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                    #endif
                                    } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                        color.rgb = sqrt2(color.rgb) * 0.35;
                                        if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                    }
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                        // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                        emission = clamp(color.r * 8.0, 1.6, 5.0);
                                        color.rgb = pow1_5(color.rgb);
                                        lmCoordM = vec2(0.0);
                                        #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                            if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                        #endif
                                    } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                        // Lava Particles
                                        emission = 2.0;
                                        color.b *= 0.5;
                                        color.r *= 1.2;
                                        color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                        emission *= LAVA_EMISSION;
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                        #endif
                                    }
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 12496) {
                                if (texCoordScaled.x >= 3456 && texCoordScaled.x < 3520 && texCoordScaled.y >= 12488 && texCoordScaled.y < 12496) {
                                    materialMask = 0.0;
                                    color.rgb = sqrt3(color.rgb);
                                    color.rgb *= 0.7;
                                    if (dither > 0.4) discard;
                                    
                                    #ifdef NO_RAIN_ABOVE_CLOUDS
                                        if (cameraPosition.y > maximumCloudsHeight) discard;
                                    #endif
                                }
                            } else {
                                if (texCoordScaled.x < 3456) {
                                    if (texCoordScaled.x >= 3240 && texCoordScaled.x < 3304 && texCoordScaled.y >= 12496 && texCoordScaled.y < 12560) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 3456 && texCoordScaled.x < 3520 && texCoordScaled.y >= 12496 && texCoordScaled.y < 12552) {
                                        materialMask = 0.0;
                                        color.rgb = sqrt3(color.rgb);
                                        color.rgb *= 0.7;
                                        if (dither > 0.4) discard;
                                        
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (texCoordScaled.y < 12416) {
                        if (texCoordScaled.x < 6624) {
                            if (texCoordScaled.y < 12360) {
                                if (texCoordScaled.x >= 6304 && texCoordScaled.x < 6368 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12360) {
                                    if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                        materialMask = 0.0;
                                        color.rgb = sqrt3(color.rgb);
                                        color.rgb *= 0.7;
                                        if (dither > 0.4) discard;
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    #ifdef OVERWORLD
                                    } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= rainTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                    } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= snowTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                    #endif
                                    } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                        color.rgb = sqrt2(color.rgb) * 0.35;
                                        if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                    }
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                        // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                        emission = clamp(color.r * 8.0, 1.6, 5.0);
                                        color.rgb = pow1_5(color.rgb);
                                        lmCoordM = vec2(0.0);
                                        #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                            if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                        #endif
                                    } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                        // Lava Particles
                                        emission = 2.0;
                                        color.b *= 0.5;
                                        color.r *= 1.2;
                                        color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                        emission *= LAVA_EMISSION;
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                        #endif
                                    }
                                }
                            } else {
                                if (texCoordScaled.x < 6304) {
                                    if (texCoordScaled.x >= 4400 && texCoordScaled.x < 4464 && texCoordScaled.y >= 12360 && texCoordScaled.y < 12416) {
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                        #endif
                                        
                                        emission = 2.0;
                                    }
                                } else {
                                    if (texCoordScaled.x >= 6304 && texCoordScaled.x < 6368 && texCoordScaled.y >= 12360 && texCoordScaled.y < 12416) {
                                        if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                            materialMask = 0.0;
                                            color.rgb = sqrt3(color.rgb);
                                            color.rgb *= 0.7;
                                            if (dither > 0.4) discard;
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        #ifdef OVERWORLD
                                        } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        
                                            if (color.a < 0.1 || isEyeInWater == 3) discard;
                                            color.a *= rainTexOpacity;
                                            color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                        } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        
                                            if (color.a < 0.1 || isEyeInWater == 3) discard;
                                            color.a *= snowTexOpacity;
                                            color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                        #endif
                                        } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                            color.rgb = sqrt2(color.rgb) * 0.35;
                                            if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                        }
                                        
                                        float dotColor = dot(color.rgb, color.rgb);
                                        if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                            // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                            emission = clamp(color.r * 8.0, 1.6, 5.0);
                                            color.rgb = pow1_5(color.rgb);
                                            lmCoordM = vec2(0.0);
                                            #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                                if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                    color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                            #endif
                                        } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                            // Lava Particles
                                            emission = 2.0;
                                            color.b *= 0.5;
                                            color.r *= 1.2;
                                            color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                            emission *= LAVA_EMISSION;
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                            #endif
                                        }
                                    }
                                }
                            }
                        } else {
                            if (texCoordScaled.x < 8544) {
                                if (texCoordScaled.x >= 6624 && texCoordScaled.x < 6688 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12416) {
                                    if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                        materialMask = 0.0;
                                        color.rgb = sqrt3(color.rgb);
                                        color.rgb *= 0.7;
                                        if (dither > 0.4) discard;
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    #ifdef OVERWORLD
                                    } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= rainTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                    } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                        #ifdef NO_RAIN_ABOVE_CLOUDS
                                            if (cameraPosition.y > maximumCloudsHeight) discard;
                                        #endif
                                    
                                        if (color.a < 0.1 || isEyeInWater == 3) discard;
                                        color.a *= snowTexOpacity;
                                        color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                    #endif
                                    } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                        color.rgb = sqrt2(color.rgb) * 0.35;
                                        if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                    }
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                        // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                        emission = clamp(color.r * 8.0, 1.6, 5.0);
                                        color.rgb = pow1_5(color.rgb);
                                        lmCoordM = vec2(0.0);
                                        #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                            if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                                color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                        #endif
                                    } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                        // Lava Particles
                                        emission = 2.0;
                                        color.b *= 0.5;
                                        color.r *= 1.2;
                                        color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                        emission *= LAVA_EMISSION;
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                        #endif
                                    }
                                }
                            } else {
                                if (texCoordScaled.x >= 8544 && texCoordScaled.x < 9056 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12416) {
                                    #ifdef GLOWING_POTION_EFFECT
                                        emission = 4.0 * pow2(pow2(colorP.r));
                                    #endif
                                }
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 7680) {
                            if (texCoordScaled.y < 12488) {
                                if (texCoordScaled.x >= 4400 && texCoordScaled.x < 4464 && texCoordScaled.y >= 12416 && texCoordScaled.y < 12424) {
                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                    #endif
                                    #ifdef PURPLE_END_FIRE_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                    #endif
                                    
                                    emission = 2.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 3584 && texCoordScaled.x < 3648 && texCoordScaled.y >= 12488 && texCoordScaled.y < 12552) {
                                    materialMask = 0.0;
                                    color.rgb = sqrt3(color.rgb);
                                    color.rgb *= 0.7;
                                    if (dither > 0.4) discard;
                                    
                                    #ifdef NO_RAIN_ABOVE_CLOUDS
                                        if (cameraPosition.y > maximumCloudsHeight) discard;
                                    #endif
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 12480) {
                                if (texCoordScaled.x >= 10288 && texCoordScaled.x < 10352 && texCoordScaled.y >= 12416 && texCoordScaled.y < 12480) {
                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                    #endif
                                    #ifdef PURPLE_END_FIRE_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                    #endif
                                    
                                    emission = 2.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 7680 && texCoordScaled.x < 8128 && texCoordScaled.y >= 12480 && texCoordScaled.y < 12544) {
                                    emission = 3.0 * pow2(color.b);
                                    color.rgb *= color.rgb;
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (texCoordScaled.y < 11776) {
                if (texCoordScaled.x < 14912) {
                    if (texCoordScaled.y < 11392) {
                        if (texCoordScaled.y < 11008) {
                            if (texCoordScaled.x >= 11536 && texCoordScaled.x < 12160 && texCoordScaled.y >= 9984 && texCoordScaled.y < 10240) {
                                #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                #endif
                                #ifdef PURPLE_END_FIRE_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                #endif
                                
                                emission = 2.0;
                            }
                        } else {
                            if (texCoordScaled.x >= 11536 && texCoordScaled.x < 12792 && texCoordScaled.y >= 11008 && texCoordScaled.y < 11136) {
                                color.a *= 0.5;
                                materialMask = 0.0;
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 12392) {
                            if (texCoordScaled.x >= 11536 && texCoordScaled.x < 12392 && texCoordScaled.y >= 11648 && texCoordScaled.y < 11776) {
                                emission = 2.5 * smoothstep1(color.a);
                            }
                        } else {
                            if (texCoordScaled.y < 11648) {
                                if (texCoordScaled.x >= 12392 && texCoordScaled.x < 13928 && texCoordScaled.y >= 11392 && texCoordScaled.y < 11520) {
                                    color.a *= 0.5;
                                    materialMask = 0.0;
                                }
                            } else {
                                if (texCoordScaled.x >= 12392 && texCoordScaled.x < 13760 && texCoordScaled.y >= 11648 && texCoordScaled.y < 11776) {
                                    emission = 2.5 * smoothstep1(color.a);
                                }
                            }
                        }
                    }
                } else {
                    if (texCoordScaled.y < 11648) {
                        if (texCoordScaled.x >= 15208 && texCoordScaled.x < 15976 && texCoordScaled.y >= 11264 && texCoordScaled.y < 11392) {
                            emission = pow2(color.b);
                        }
                    } else {
                        if (texCoordScaled.x >= 14912 && texCoordScaled.x < 15680 && texCoordScaled.y >= 11648 && texCoordScaled.y < 11776) {
                            emission = 1.6 * pow2(color.b);
                        }
                    }
                }
            } else {
                if (texCoordScaled.x < 13568) {
                    if (texCoordScaled.y < 12288) {
                        if (texCoordScaled.x < 12544) {
                            if (texCoordScaled.x < 12032) {
                                if (texCoordScaled.x >= 11776 && texCoordScaled.x < 11904 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                    if (color.b > 0.6 && color.a > 0.9) {
                                        color.rgb = pow1_5(color.rgb);
                                        emission = 2.5;
                                    }
                                }
                            } else {
                                if (texCoordScaled.x < 12288) {
                                    if (texCoordScaled.x >= 12032 && texCoordScaled.x < 12160 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 12288 && texCoordScaled.x < 12416 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            }
                        } else {
                            if (texCoordScaled.x < 13056) {
                                if (texCoordScaled.x < 12800) {
                                    if (texCoordScaled.x >= 12544 && texCoordScaled.x < 12672 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 12800 && texCoordScaled.x < 12928 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            } else {
                                if (texCoordScaled.x < 13312) {
                                    if (texCoordScaled.x >= 13056 && texCoordScaled.x < 13184 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 13312 && texCoordScaled.x < 13440 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 12640) {
                            if (texCoordScaled.x >= 11536 && texCoordScaled.x < 11760 && texCoordScaled.y >= 12600 && texCoordScaled.y < 12632) {
                                if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                                    materialMask = 0.0;
                                    color.rgb = sqrt3(color.rgb);
                                    color.rgb *= 0.7;
                                    if (dither > 0.4) discard;
                                    #ifdef NO_RAIN_ABOVE_CLOUDS
                                        if (cameraPosition.y > maximumCloudsHeight) discard;
                                    #endif
                                #ifdef OVERWORLD
                                } else if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                                    #ifdef NO_RAIN_ABOVE_CLOUDS
                                        if (cameraPosition.y > maximumCloudsHeight) discard;
                                    #endif
                                
                                    if (color.a < 0.1 || isEyeInWater == 3) discard;
                                    color.a *= rainTexOpacity;
                                    color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                                } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                                    #ifdef NO_RAIN_ABOVE_CLOUDS
                                        if (cameraPosition.y > maximumCloudsHeight) discard;
                                    #endif
                                
                                    if (color.a < 0.1 || isEyeInWater == 3) discard;
                                    color.a *= snowTexOpacity;
                                    color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                                #endif
                                } else if (color.r == color.g && color.r - 0.5 * color.b < 0.06) { // Underwater Particle
                                    color.rgb = sqrt2(color.rgb) * 0.35;
                                    if (fract(playerPos.y + cameraPosition.y) > 0.25) discard;
                                }
                                
                                float dotColor = dot(color.rgb, color.rgb);
                                if (dotColor > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                                    // Ender Particle, Crying Obsidian Particle, Redstone Particle
                                    emission = clamp(color.r * 8.0, 1.6, 5.0);
                                    color.rgb = pow1_5(color.rgb);
                                    lmCoordM = vec2(0.0);
                                    #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                                        if (color.b > color.r * color.r && color.g < 0.16 && color.r > 0.2)
                                            color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0); // Nether Portal
                                    #endif
                                } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                                    // Lava Particles
                                    emission = 2.0;
                                    color.b *= 0.5;
                                    color.r *= 1.2;
                                    color.rgb += vec3(min(pow2(pow2(emission * 0.35)), 0.4)) * LAVA_TEMPERATURE * 0.5;
                                    emission *= LAVA_EMISSION;
                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                                    #endif
                                    #ifdef PURPLE_END_FIRE_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                                    #endif
                                }
                            }
                        } else {
                            if (texCoordScaled.x >= 12640 && texCoordScaled.x < 12960 && texCoordScaled.y >= 12288 && texCoordScaled.y < 12352) {
                                #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                                #endif
                                #ifdef PURPLE_END_FIRE_INTERNAL
                                    color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                                #endif
                                
                                emission = 2.0;
                            }
                        }
                    }
                } else {
                    if (texCoordScaled.y < 12288) {
                        if (texCoordScaled.x < 14080) {
                            if (texCoordScaled.y < 11904) {
                                if (texCoordScaled.x < 13824) {
                                    if (texCoordScaled.x >= 13568 && texCoordScaled.x < 13696 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 13824 && texCoordScaled.x < 13952 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            } else {
                                if (texCoordScaled.x >= 13824 && texCoordScaled.x < 14080 && texCoordScaled.y >= 11904 && texCoordScaled.y < 12032) {
                                    color.a *= 0.5;
                                    materialMask = 0.0;
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 11904) {
                                if (texCoordScaled.x < 14336) {
                                    if (texCoordScaled.x >= 14080 && texCoordScaled.x < 14208 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 14336 && texCoordScaled.x < 14464 && texCoordScaled.y >= 11776 && texCoordScaled.y < 11904) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            } else {
                                if (texCoordScaled.x >= 14080 && texCoordScaled.x < 15360 && texCoordScaled.y >= 11904 && texCoordScaled.y < 12032) {
                                    color.a *= 0.5;
                                    materialMask = 0.0;
                                }
                            }
                        }
                    } else {
                        if (texCoordScaled.x < 14944) {
                            if (texCoordScaled.y < 12480) {
                                if (texCoordScaled.x >= 14624 && texCoordScaled.x < 14944 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12416) {
                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.5 + 0.1;
                                }
                            } else {
                                if (texCoordScaled.x < 14016) {
                                    if (texCoordScaled.x >= 13824 && texCoordScaled.x < 14016 && texCoordScaled.y >= 12480 && texCoordScaled.y < 12544) {
                                        if (color.a > 0.0) {
                                            emission = 1.0;
                                            color.rgb *= color.rgb;
                                        }
                                    }
                                } else {
                                    if (texCoordScaled.x >= 14016 && texCoordScaled.x < 14080 && texCoordScaled.y >= 12480 && texCoordScaled.y < 12544) {
                                        if (color.b > 0.6 && color.a > 0.9) {
                                            color.rgb = pow1_5(color.rgb);
                                            emission = 2.5;
                                        }
                                    }
                                }
                            }
                        } else {
                            if (texCoordScaled.y < 12352) {
                                if (texCoordScaled.x >= 14944 && texCoordScaled.x < 15264 && texCoordScaled.y >= 12288 && texCoordScaled.y < 12352) {
                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = 0.6 * dotColor;
                                }
                            } else {
                                if (texCoordScaled.x < 16192) {
                                    if (texCoordScaled.x >= 14944 && texCoordScaled.x < 15136 && texCoordScaled.y >= 12352 && texCoordScaled.y < 12416) {
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.5 + 0.1;
                                    }
                                } else {
                                    if (texCoordScaled.x < 16320) {
                                        if (texCoordScaled.x >= 16192 && texCoordScaled.x < 16256 && texCoordScaled.y >= 12480 && texCoordScaled.y < 12544) {
                                            materialMask = 0.0;
                                            color.rgb = sqrt3(color.rgb);
                                            color.rgb *= 0.7;
                                            if (dither > 0.4) discard;
                                            
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        }
                                    } else {
                                        if (texCoordScaled.x >= 16320 && texCoordScaled.x < 16384 && texCoordScaled.y >= 12480 && texCoordScaled.y < 12544) {
                                            materialMask = 0.0;
                                            color.rgb = sqrt3(color.rgb);
                                            color.rgb *= 0.7;
                                            if (dither > 0.4) discard;
                                            
                                            #ifdef NO_RAIN_ABOVE_CLOUDS
                                                if (cameraPosition.y > maximumCloudsHeight) discard;
                                            #endif
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    bool noSmoothLighting = false;

    #else
        #if defined OVERWORLD && defined NO_RAIN_ABOVE_CLOUDS || defined NETHER && (defined BIOME_COLORED_NETHER_PORTALS || defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL)
            if (atlasSize.x < 900.0) {
                if (color.b > 1.15 * (color.r + color.g) && color.g > color.r * 1.25 && color.g < 0.425 && color.b > 0.75) { // Water Particle
                    #ifdef NO_RAIN_ABOVE_CLOUDS
                        if (cameraPosition.y > maximumCloudsHeight) discard;
                    #endif
                }
                #ifdef OVERWORLD
                if (color.b > 0.7 && color.r < 0.28 && color.g < 0.425 && color.g > color.r * 1.4) { // physics mod rain
                    #ifdef NO_RAIN_ABOVE_CLOUDS
                        if (cameraPosition.y > maximumCloudsHeight) discard;
                    #endif
                    if (color.a < 0.1 || isEyeInWater == 3) discard;
                    color.a *= rainTexOpacity;
                    color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + ambientColor * lmCoord.y * (0.7 + 0.35 * sunFactor));
                    color.rgb *= vec3(WEATHER_TEX_R, WEATHER_TEX_G, WEATHER_TEX_B);
                } else if (color.rgb == vec3(1.0) && color.a < 0.765 && color.a > 0.605) { // physics mod snow (default snow opacity only)
                    #ifdef NO_RAIN_ABOVE_CLOUDS
                        if (cameraPosition.y > maximumCloudsHeight) discard;
                    #endif
                    if (color.a < 0.1 || isEyeInWater == 3) discard;
                    color.a *= snowTexOpacity;
                    color.rgb = sqrt2(color.rgb) * (blocklightCol * 2.0 * lmCoord.x + lmCoord.y * (0.7 + 0.35 * sunFactor) + ambientColor * 0.2);
                    color.rgb *= vec3(WEATHER_TEX_R, WEATHER_TEX_G, WEATHER_TEX_B);
                }
                #endif
                if (color.r == 1.0 && color.b < 0.778 && color.g < 0.97) { // Fire Particle
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                    #endif
                    emission = 2.0;
                }
                if (max(abs(colorP.r - colorP.b), abs(colorP.b - colorP.g)) < 0.001) {
                    if (dot(color.rgb, color.rgb) > 0.25 && color.g < 0.5 && (color.b > color.r * 1.1 && color.r > 0.3 || color.r > (color.g + color.b) * 3.0)) {
                        #if defined NETHER && defined BIOME_COLORED_NETHER_PORTALS
                            vec3 color2 = pow1_5(color.rgb);
                            if (color2.b > color2.r * color2.r && color2.g < 0.16 && color2.r > 0.2) {
                                emission = clamp(color2.r * 8.0, 1.6, 5.0);
                                color.rgb = color.rgb = changeColorFunction(color.rgb, 10.0, netherColor, 1.0);
                                lmCoordM = vec2(0.0);
                            }
                        #endif
                    } else if (color.r > 0.83 && color.g > 0.23 && color.b < 0.4) {
                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 3.5, colorSoul, inSoulValley);
                        #endif
                        #ifdef PURPLE_END_FIRE_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 3.5, colorEndBreath, 1.0);
                        #endif
                    }
                }
            }
        #endif
    bool noSmoothLighting = true;
    #endif

    #ifdef REDUCE_CLOSE_PARTICLES
        if (lViewPos - 1.0 < dither) discard;
    #endif

    #ifdef GLOWING_COLORED_PARTICLES
        if (atlasSize.x < 900.0) {
            if (dot(glColor.rgb, vec3(1.0)) < 2.99) {
                emission = 5.0;
            }
        }
    #endif

    #if MONOTONE_WORLD > 0
        #if MONOTONE_WORLD == 1
            color.rgb = vec3(1.0);
        #elif MONOTONE_WORLD == 2
            color.rgb = vec3(0.0);
        #else
            color.rgb = vec3(0.5);
        #endif
    #endif

    #ifdef SS_BLOCKLIGHT
        blocklightCol = ApplyMultiColoredBlocklight(blocklightCol, screenPos, playerPos, lmCoord.x);
    #endif

    float auroraSpookyMix = 0.0;
    #if defined SPOOKY && BLOOD_MOON > 0
        ambientColor *= mix(vec3(1.0), vec3(1.0, 0.0, 0.0) * 3.0, getBloodMoon(moonPhase, sunVisibility));
        auroraSpookyMix = getBloodMoon(moonPhase, sunVisibility);
    #endif
    #ifdef AURORA_INFLUENCE
        ambientColor = mix(AuroraAmbientColor(ambientColor, viewPos), ambientColor, auroraSpookyMix);
    #endif

    bool isLightSource = lmCoord.x > 0.99;

    DoLighting(color, shadowMult, playerPos, viewPos, lViewPos, geoNormal, normalM, dither,
               worldGeoNormal, lmCoordM, noSmoothLighting, false, true,
               false, 0, 0.0, 1.0, emission, purkinjeOverwrite, isLightSource);

    #if MC_VERSION >= 11500
        vec3 nViewPos = normalize(viewPos);

        float VdotU = dot(nViewPos, upVec);
        float VdotS = dot(nViewPos, sunVec);
        float sky = 0.0;

        DoFog(color.rgb, sky, lViewPos, playerPos, VdotU, VdotS, dither);
    #endif

    vec3 translucentMult = mix(vec3(0.666), color.rgb * (1.0 - pow2(pow2(color.a))), color.a);

    float SSBLMask = 0.0;
    #ifdef ENTITIES_ARE_LIGHT
        SSBLMask = 1.0;
    #endif

    #ifdef COLOR_CODED_PROGRAMS
        ColorCodeProgram(color, -1);
    #endif

    /* DRAWBUFFERS:063 */
    gl_FragData[0] = color;
    gl_FragData[1] = vec4(0.0, materialMask, 0.0, lmCoord.x + clamp01(purkinjeOverwrite) + clamp01(emission));
    gl_FragData[2] = vec4(1.0 - translucentMult, 1.0);

    #ifdef SS_BLOCKLIGHT
        /* DRAWBUFFERS:06389 */
        gl_FragData[3] = vec4(0.0, 0.0, 0.0, SSBLMask);
        gl_FragData[4] = vec4(0.0, 0.0, 0.0, SSBLMask);
    #endif
}

#endif

//////////Vertex Shader//////////Vertex Shader//////////Vertex Shader//////////
#ifdef VERTEX_SHADER

out vec2 texCoord;
out vec2 lmCoord;

flat out vec3 upVec, sunVec;
out vec3 normal;

flat out vec4 glColor;

#ifdef CLOUD_SHADOWS
    flat out vec3 eastVec;

    #if SUN_ANGLE != 0
        flat out vec3 northVec;
    #endif
#endif

//Attributes//

#if defined WAVE_EVERYTHING || defined ATLAS_ROTATION
    attribute vec4 mc_midTexCoord;
#endif

//Common Variables//

//Common Functions//

//Includes//

#if defined MIRROR_DIMENSION || defined WORLD_CURVATURE
    #include "/lib/misc/distortWorld.glsl"
#endif

#ifdef WAVE_EVERYTHING
    #include "/lib/materials/materialMethods/wavingBlocks.glsl"
#endif

//Program//
void main() {
    gl_Position = ftransform();

    texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    #ifdef ATLAS_ROTATION
        texCoord += texCoord * float(hash33(mod(cameraPosition * 0.5, vec3(100.0))));
    #endif
    lmCoord  = GetLightMapCoordinates();

    glColor = gl_Color;

    normal = normalize(gl_NormalMatrix * gl_Normal);
    upVec = normalize(gbufferModelView[1].xyz);
    sunVec = GetSunVector();

    #ifdef FLICKERING_FIX
        gl_Position.z -= 0.000002;
    #endif

    #ifdef CLOUD_SHADOWS
        eastVec = normalize(gbufferModelView[0].xyz);

        #if SUN_ANGLE != 0
            northVec = normalize(gbufferModelView[2].xyz);
        #endif
    #endif
}

#endif
