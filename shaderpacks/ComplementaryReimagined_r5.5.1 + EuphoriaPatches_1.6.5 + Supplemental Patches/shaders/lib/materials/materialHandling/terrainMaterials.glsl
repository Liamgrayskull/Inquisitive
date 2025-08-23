#include "/lib/shaderSettings/materials.glsl"
#include "/lib/shaderSettings/water.glsl"
#include "/lib/shaderSettings/blueScreen.glsl"
#include "/lib/shaderSettings/emissiveFlowers.glsl"

if (mat >= 10000) {
if (mat < 11024) {
    if (mat < 10512) {
        if (mat < 10256) {
            if (mat < 10126) { // MV: Normal Mycelium
                if (mat < 10064) {
                    if (mat < 10032) {
                        if (mat < 10014) { // MV: Foliage
                            if (mat < 10006) { // MV: Leaves
                                if (mat < 10002) { // No directional shading, MV: Flowers
                                    noDirectionalShading = true;

                                    sandNoiseIntensity = 0.4, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10006)*/ { // Grounded Waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS
                                        if (mat == 10003 && max(color.b, color.r * 1.3) > color.g) { // Flowers
                                            emission = 2.0 * skyLightCheck;
                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            #if EMISSIVE_FLOWERS > 0
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            } else {
                                if (mat < 10012) { // Leaves
                                    #include "/lib/materials/specificMaterials/terrain/leaves.glsl"

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (mat == 10011 && max(color.b, color.r * 0.7) > color.g) { // Flowering Azalea Leaves
                                            emission = skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                    #ifdef PINKER_CHERRY_LEAVES
                                        if (mat == 10007 && color.b > 0.5 && color.r > 0.85) {
                                            color.rgb *= vec3(1.0, 0.66, 0.87) + 0.2;
                                            color.rgb = clamp01(color.rgb);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10014)*/ { // Vine
                                    subsurfaceMode = 3, centerShadowBias = true; noSmoothLighting = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    float factor = color.g;
                                    smoothnessG = factor * 0.5;
                                    highlightMult = factor * 4.0 + 2.0;
                                    float fresnel = clamp(1.0 + dot(normalM, normalize(viewPos)), 0.0, 1.0);
                                    highlightMult *= 1.0 - pow2(pow2(fresnel));

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            }
                        } else {
                            if (mat < 10024) {
                                if (mat < 10020) { // Non-waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                    if (mat == 10019) {
                                        #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                            if (max(color.b * 1.25, color.r * 0.91) > color.g) { // Flowers
                                                emission = 1.5 * skyLightCheck;

                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                emission *= EMISSIVE_FLOWERS_STRENGTH;
                                            }
                                        #endif
                                        #ifdef PINKER_CHERRY_LEAVES
                                            if (color.b > 0.5 && color.r > 0.85) color.rgb *= vec3(1.0, 0.87, 0.97); // Pink Petals
                                        #endif
                                    }
                                }
                                else /*if (mat < 10024)*/ { // Upper Waving Foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 + invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS
                                        if (mat == 10023 && max(color.b, color.r * 1.25) > color.g) { // Large Flowers Upper Half
                                            #if EMISSIVE_FLOWERS > 0
                                                emission = 2.0 * skyLightCheck;
                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            } else { 
                                if (mat < 10025) { // Auto Modded Ores - Stone
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10026) {  // Short Foliage / Foliage Lower Half - No Subsurface Scattering
                                    noSmoothLighting = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                } else if (mat < 10027) { // Auto Modded Ores - Netherrack
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10028) { // Tall Foliage / Foliage Upper Half - No Subsurface Scattering
                                    noSmoothLighting = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 + invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;

                                } else if (mat < 10029) { // Auto Modded Ores - Endstone
                                    #ifdef GLOWING_ORE_MODDED
                                        #include "/lib/materials/specificMaterials/terrain/autoModdedOres.glsl"
                                        if (emission < 0.1) {
                                            #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                        }
                                        emission *= GLOWING_ORE_MULT;
                                        //color.rgb = avgBorderColor;

                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                        #endif
                                    #endif
                                } else if (mat < 10030) { // Crimson Roots
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = mix(color.rgb, saturateColors(color.rgb * vec3(0.9, 0.7, 0.1), 0.85), inSoulValley); // Color curve to make it look better
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                } else if (mat < 10032) { // Short foliage - no interactive foliage
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoFoliageColorTweaks(color.rgb, shadowMult, snowMinNdotU, viewPos, nViewPos, lViewPos, dither);

                                        #ifdef COATED_TEXTURES
                                            doTileRandomisation = false;
                                        #endif
                                    #endif

                                    #if SHADOW_QUALITY == -1
                                        shadowMult *= 1.0 - 0.3 * (signMidCoordPos.y + 1.0) * (1.0 - abs(signMidCoordPos.x))
                                        + 0.5 * (1.0 - signMidCoordPos.y) * invNoonFactor; // consistency357381
                                    #endif

                                    sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            }
                        }
                    } else {
                        if (mat < 10048) {
                            if (mat < 10040) {
                                if (mat < 10035) { // Stone Bricks++
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else if (mat < 10036){ // Sugar Cane
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10040)*/ { // Anvil+
                                    #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                }
                            } else {
                                if (mat < 10044) { // Rails
                                    #if ANISOTROPIC_FILTER == 0
                                        color = texture2DLod(tex, texCoord, 0);
                                    #endif

                                    noSmoothLighting = true;
                                    if (color.r > 0.1 && color.g + color.b < 0.1) { // Redstone Parts
                                        noSmoothLighting = true; noDirectionalShading = true;
                                        lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                        if (color.r > 0.5) {
                                            color.rgb *= color.rgb;
                                            emission = 8.0 * color.r;

                                            overlayNoiseIntensity = 0.35, overlayNoiseEmission = 0.2;
                                        } else if (color.r > color.g * 2.0) {
                                            materialMask = OSIEBCA * 5.0; // Redstone Fresnel

                                            float factor = pow2(color.r);
                                            smoothnessG = 0.4;
                                            highlightMult = factor + 0.4;

                                            smoothnessD = factor * 0.7 + 0.3;
                                        }
                                    } else if (abs(color.r - color.b) < 0.15) { // Iron Parts
                                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    } else if (color.g > color.b * 2.0) { // Gold Parts
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    } else { // Wood Parts
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                    }
                                }
                                else /*if (mat < 10048)*/ { // Empty Cauldron, Hopper
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    #include "/lib/materials/specificMaterials/terrain/anvil.glsl"

                                    if (mat == 10047) { // Disabled Hopper
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10056) {
                                if (mat < 10052) { // Water Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 && fractPos.y > 0.3 && NdotU > 0.9) {
                                        #ifdef SHADER_WATER
                                            #if WATER_STYLE < 3 || PIXEL_WATER == 1
                                                vec3 colorP = color.rgb / glColor.rgb;
                                                smoothnessG = min(pow2(pow2(dot(colorP.rgb, colorP.rgb) * 0.4)), 1.0);
                                                highlightMult = 3.25;
                                                smoothnessD = 0.8;
                                            #else
                                                smoothnessG = 0.3;
                                                smoothnessD = 1.0;
                                            #endif

                                            #include "/lib/materials/specificMaterials/translucents/water.glsl"

                                            #ifdef COATED_TEXTURES
                                                noiseFactor = 0.0;
                                            #endif
                                        #endif

                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                                else /*if (mat < 10056)*/ { // Powder Snow Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 &&
                                        fractPos.y > 0.3 &&
                                        NdotU > 0.9) {

                                        #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                        overlayNoiseIntensity = 0.4;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10060) { // Lava Cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);

                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 &&
                                        fractPos.y > 0.3 &&
                                        NdotU > 0.9) {

                                        #include "/lib/materials/specificMaterials/terrain/lava.glsl"

                                        sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                }
                                else /*if (mat < 10061)*/ { // Lever
                                    if (color.r > color.g + color.b) {
                                        color.rgb *= color.rgb;
                                        emission = 4.0;

                                        overlayNoiseIntensity = 0.1, overlayNoiseEmission = 0.3;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10096) {
                        if (mat < 10080) {
                            if (mat < 10072) {
                                if (mat < 10068) { // Lectern
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                }
                                else /*if (mat < 10072)*/ { // Lava
                                    #include "/lib/materials/specificMaterials/terrain/lava.glsl"

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 4.5, lViewPos);
                                    #endif

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                            } else {
                                if (mat < 10076) { // Fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 2.35;
                                    color.rgb *= sqrt1(GetLuminance(color.rgb));

                                    overlayNoiseIntensity = 0.0;

                                    #if (defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL) && defined GBUFFERS_TERRAIN
                                        float uniformValue = 1.0;
                                        vec3 colorFire = vec3(0.0);
                                        #ifdef NETHER
                                            uniformValue = inSoulValley;
                                            colorFire = colorSoul;
                                            float gradient = mix(1.0, 0.0, clamp01(blockUV.y + 3.0 * blockUV.y));
                                        #endif
                                        #ifdef END
                                            uniformValue = 1.0;
                                            colorFire = colorEndBreath * 1.5;
                                            float gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.15 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                        #endif
                                        color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                        color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                    #endif
                                }
                                else /*if (mat < 10080)*/ { // Soul Fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 1.5;
                                    color.rgb = pow1_5(color.rgb);

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        } else {
                            if (mat < 10088) {
                                if (mat < 10084) { // Stone+, Coal Ore, Smooth Stone+, Grindstone, Stonecutter
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    if (mat == 10083) { // Powered Stone Pressure Plate and Stone Button
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10088)*/ { // Granite+
                                    smoothnessG = pow2(pow2(color.r)) * 0.75;
                                    smoothnessD = smoothnessG;
                                }
                            } else {
                                if (mat < 10092) { // Diorite+
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif
                                }
                                else /*if (mat < 10096)*/ { // Andesite+
                                    smoothnessG = pow2(pow2(color.g)) * 1.3;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                }
                            }
                        }
                    } else {
                        if (mat < 10112) {
                            if (mat < 10104) {
                                if (mat < 10100) { // Polished Granite+
                                    smoothnessG = 0.1 + color.r * 0.4;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10104)*/ { // Polished Diorite+
                                    smoothnessG = pow2(color.g) * 0.7;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            } else {
                                if (mat < 10108) { // Polished Andesite+, Packed Mud, Mud Bricks+, Bricks+
                                    smoothnessG = pow2(color.g);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10112)*/ { // Deepslate:Non-polished Variants, Deepslate Coal Ore
                                    #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                }
                            }
                        } else {
                            if (mat < 10120) {
                                if (mat < 10116) { // Deepslate:Polished Variants, Mud, Mangrove Roots, Muddy Mangrove Roots
                                    #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10120)*/ { // Calcite
                                    highlightMult = pow2(color.g) + 1.0;
                                    smoothnessG = 1.0 - color.g * 0.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.75, shadowMult, highlightMult);
                                    #endif
                                }
                            } else {
                                if (mat < 10124) { // Dripstone+, Daylight Detector
                                    smoothnessG = color.r * 0.35 + 0.2;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif

                                    #ifdef REDSTONE_IPBR
                                        if (mat == 10123) { // Daylight Detector
                                            if (color.r > 0.5 && color.g > 0.5 && color.b > 0.5) smoothnessD = 1.0;
                                            redstoneIPBR(color.rgb, emission);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10128)*/ { // Snowy Variants of Grass Block, Podzol, Mycelium
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 1.5) { // Snowy Variants:Snowy Part
                                        #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                        overlayNoiseIntensity = 0.0;
                                    } else { // Snowy Variants:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10192) {
                    if (mat < 10160) {
                        if (mat < 10144) {
                            if (mat < 10136) {
                                if (mat < 10132) { // Dirt, Coarse Dirt, Rooted Dirt, Podzol:Normal, Mycelium:Normal, Farmland:Dry
                                    #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                }
                                else /*if (mat < 10136)*/ { // Grass Block:Normal
                                    if (glColor.b < 0.999) { // Grass Block:Normal:Grass Part
                                        smoothnessG = pow2(color.g);

                                        #ifdef SNOWY_WORLD
                                            snowMinNdotU = min(pow2(pow2(color.g)) * 1.9, 0.1);
                                            color.rgb = color.rgb * 0.5 + 0.5 * (color.rgb / glColor.rgb);
                                        #endif
                                    } else { //Grass Block:Normal:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10140) { // Farmland:Wet
                                    if (NdotU > 0.99) { // Farmland:Wet:Top Part
                                        #if MC_VERSION >= 11300
                                            smoothnessG = clamp(pow2(pow2(1.0 - color.r)) * 2.5, 0.5, 1.0);
                                            highlightMult = 0.5 + smoothnessG * smoothnessG * 2.0;
                                            smoothnessD = smoothnessG * 0.75;
                                        #else
                                            smoothnessG = 0.5 * (1.0 + abs(color.r - color.b) + color.b);
                                            smoothnessD = smoothnessG * 0.5;
                                        #endif
                                    } else { // Farmland:Wet:Dirt Part
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                                else /*if (mat < 10144)*/ { // Netherrack
                                    #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                }
                            }
                        } else {
                            if (mat < 10151) { // MV: Piston, Dispenser, Dropper
                                if (mat < 10148) { // Warped Nylium, Warped Wart Block
                                    if (color.g == color.b && color.g > 0.0001) { // Warped Nylium:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    } else { // Warped Nylium:Nylium Part, Warped Wart Block
                                        smoothnessG = color.g * 0.5;
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif

                                        #ifdef GLOWING_WART
                                            if (mat == 10146 && color.g > 0.7) { // Warped Wart Block
                                                overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                                emission = 2.4;
                                                #ifdef GBUFFERS_TERRAIN
                                                    vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                              + floor(playerPos.y + cameraPosition.y + 0.5);
                                                    bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                    emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                    emission *= 4.0;
                                                #endif
                                            }
                                        #endif
                                    }
                                }
                                else /*if (mat < 10152)*/ { // Crimson Nylium, Nether Wart Block
                                    if (color.g == color.b && color.g > 0.0001 && color.r < 0.522) { // Crimson Nylium:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    } else { // Crimson Nylium:Nylium Part, Nether Wart Block
                                        smoothnessG = color.r * 0.5;
                                        smoothnessD = smoothnessG;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            if (mat == 10148) color.rgb = mix(color.rgb, saturateColors(color.rgb * vec3(1.2, 0.7, 0.8) * 0.7, 0.8), inSoulValley); // Color curve to make it look better
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif

                                        #ifdef GLOWING_WART
                                            if (mat == 10150 && color.r > 0.6) { // Nether Wart Block
                                                overlayNoiseEmission = 0.28;
                                                emission = 16.0 * color.g;
                                                #ifdef GBUFFERS_TERRAIN
                                                    vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                              + floor(playerPos.y + cameraPosition.y + 0.5);
                                                    bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                    emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                    emission *= 4.0;
                                                #endif
                                            }
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10156) { // Cobblestone+, Mossy Cobblestone+, Furnace:Unlit, Smoker:Unlit, Blast Furnace:Unlit, Moss Block+, Lodestone, Piston, Sticky Piston, Dispenser, Dropper
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    if (mat == 10151) { // Extended Piston and Sticky Piston and Powered Dispenser and Dropper
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                    else if (mat == 10154 || mat == 10155) { // Moss Block+
                                        mossNoiseIntensity = 0.0;
                                    }
                                }
                                else /*if (mat < 10160)*/ { // Oak Planks++:Clean Variants, Bookshelf, Crafting Table, Tripwire Hook
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"

                                    if (mat == 10159) { // Powered Oak Button, Pressure Plate, Fence Gate and Tripwire Hook
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10176) {
                            if (mat < 10168) {
                                if (mat < 10164) { // Oak Log, Oak Wood
                                    if (color.g > 0.48 ||
                                        CheckForColor(color.rgb, vec3(126, 98, 55)) ||
                                        CheckForColor(color.rgb, vec3(150, 116, 65))) { // Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                    } else { // Oak Log:Wood Part, Oak Wood
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                }
                                else /*if (mat < 10168)*/ { // Spruce Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"

                                    if (mat == 10167) { // Powered Spruce Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10172) { // Spruce Log, Spruce Wood
                                    if (color.g > 0.25) { // Spruce Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                                    } else { // Spruce Log:Wood Part, Spruce Wood
                                        smoothnessG = pow2(color.g) * 2.5;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10176)*/ { // Birch Planks++:Clean Variants, Scaffolding, Loom
                                    #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"

                                    if (mat == 10175) { // Powered Birch Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10184) {
                                if (mat < 10180) { // Birch Log, Birch Wood
                                    if (color.r - color.b > 0.15) { // Birch Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"
                                    } else { // Birch Log:Wood Part, Birch Wood
                                        smoothnessG = pow2(color.g) * 0.25;
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 1.25;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10184)*/ { // Jungle Planks++:Clean Variants, Composter
                                    #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"

                                    if (mat == 10183) { // Powered Jungle Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10188) { // Jungle Log, Jungle Wood
                                    if (color.g > 0.405) { // Jungle Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"
                                    } else { // Jungle Log:Wood Part, Jungle Wood
                                        smoothnessG = pow2(pow2(color.g)) * 5.0;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10192)*/ { // Acacia Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"

                                    if (mat == 10191) { // Powered Acacia Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10224) {
                        if (mat < 10208) {
                            if (mat < 10200) {
                                if (mat < 10196) { // Acacia Log, Acacia Wood
                                    if (color.r - color.b > 0.2) { // Acacia Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"
                                    } else { // Acacia Log:Wood Part, Acacia Wood
                                        smoothnessG = pow2(color.b) * 1.3;
                                        smoothnessG = min1(smoothnessG);
                                        smoothnessD = smoothnessG;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10200)*/ { // Dark Oak Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"

                                    if (mat == 10199) { // Powered Dark Oak Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10204) { // Dark Oak Log, Dark Oak Wood
                                    if (color.r - color.g > 0.08 ||
                                        CheckForColor(color.rgb, vec3(48, 30, 14))) { // Dark Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                    } else { // Dark Oak Log:Wood Part, Dark Oak Wood
                                        smoothnessG = color.r * 0.4;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10208)*/ { // Mangrove Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"

                                    if (mat == 10207) { // Powered Mangrove Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10216) {
                                if (mat < 10212) { // Mangrove Log, Mangrove Wood
                                    if (color.r - color.g > 0.2) { // Mangrove Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"
                                    } else { // Mangrove Log:Wood Part, Mangrove Wood
                                        smoothnessG = pow2(color.r) * 0.6;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10216)*/ { // Crimson Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    if (mat == 10215) { // Powered Crimson Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10220) { // Crimson Stem, Crimson Hyphae
                                    if (color.r / color.b <= 2.5) { // Flat Part
                                        #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    #ifdef GLOWING_NETHER_TREES
                                    } else { // Emissive Part
                                        emission = pow2(color.r) * 6.5;
                                        color.gb *= 0.5;
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.15;
                                    #endif
                                    }
                                }
                                else /*if (mat < 10224)*/ { // Warped Planks++:Clean Variants
                                    #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    if (mat == 10223) { // Powered Warped Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10240) {
                            if (mat < 10232) {
                                if (mat < 10228) { // Warped Stem, Warped Hyphae
                                    //if (color.r < 0.12 || color.r + color.g * 3.0 < 3.4 * color.b) { // Emissive Part
                                    if (color.r >= 0.37 * color.b && color.r + color.g * 3.0 >= 3.4 * color.b) { // Flat Part
                                        #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    #ifdef GLOWING_NETHER_TREES
                                    } else { // Emissive Part
                                        emission = pow2(color.g + 0.2 * color.b) * 4.5 + 0.15;
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                    #endif
                                    }
                                }
                                else /*if (mat < 10232)*/ { // Bedrock
                                    smoothnessG = color.b * 0.2 + 0.1;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10236) { // Sand, Suspicious Sand
                                    smoothnessG = pow(color.g, 16.0) * 2.0;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.0;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);

                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                }
                                else /*if (mat < 10240)*/ { // Red Sand
                                    smoothnessG = pow(color.r * 1.08, 16.0) * 2.0;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.0;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10248) {
                                if (mat < 10244) { // Sandstone+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10248)*/ { // Red Sandstone+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.r * 1.08)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10252) { // Netherite Block
                                    #include "/lib/materials/specificMaterials/terrain/netheriteBlock.glsl"
                                }
                                else /*if (mat < 10256)*/ { // Ancient Debris
                                    smoothnessG = pow2(color.r);
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif

                                    #ifdef GLOWING_ORE_ANCIENTDEBRIS
                                        emission = min(pow2(color.g * 6.0), 8.0);
                                        overlayNoiseIntensity = 0.2, overlayNoiseEmission = 0.8;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (mat < 10384) {
                if (mat < 10320) {
                    if (mat < 10288) {
                        if (mat < 10272) {
                            if (mat < 10264) {
                                if (mat < 10260) { // Iron Bars
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                }
                                else /*if (mat < 10264)*/ { // ACL solid blocks with no properties
                                    
                                }
                            } else {
                                if (mat < 10268) { // Iron Block, Heavy Weighted Pressure Plate
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    color.rgb *= max(color.r, 0.85) * 0.9;

                                    // color.rgb = vec3(0);
                                    // smoothnessD = 1.0;
                                    // smoothnessG = smoothnessD;
                                    // noGeneratedNormals = true;
                                    // overlayNoiseIntensity = 0.0;

                                    if (mat == 10267) { // Powered Heavy Weighted Pressure Plate
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10272)*/ { // Raw Iron Block
                                    #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = pow1_5(color.r) * 1.5;

                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10280) {
                                if (mat < 10276) { // Iron Ore
                                    if (color.r != color.g) { // Iron Ore:Raw Iron Part
                                        #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                        #ifdef GLOWING_ORE_IRON
                                            if (color.r - color.b > 0.15) {
                                                emission = pow1_5(color.r) * 1.5;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Iron Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                                else /*if (mat < 10280)*/ { // Deepslate Iron Ore
                                    if (color.r != color.g) { // Deepslate Iron Ore:Raw Iron Part
                                        #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                        #ifdef GLOWING_ORE_IRON
                                            if (color.r - color.b > 0.15) {
                                                emission = pow1_5(color.r) * 1.5;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Iron Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10284) { // Raw Copper Block
                                    #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = pow2(color.r) * 1.5 + color.g * 1.3 + 0.2;

                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                                else /*if (mat < 10288)*/ { // Copper Ore
                                    if (color.r != color.g) { // Copper Ore:Raw Copper Part
                                        #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                        #ifdef GLOWING_ORE_COPPER
                                            if (max(color.r * 0.5, color.g) - color.b > 0.05) {
                                                emission = color.r * 2.0 + 0.7;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Copper Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10304) {
                            if (mat < 10296) {
                                if (mat < 10292) { // Deepslate Copper Ore
                                    if (color.r != color.g) { // Deepslate Copper Ore:Raw Copper Part
                                        #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                        #ifdef GLOWING_ORE_COPPER
                                            if (max(color.r * 0.5, color.g) - color.b > 0.05) {
                                                emission = color.r * 2.0 + 0.7;

                                                overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Copper Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10296)*/ { // Copper Block++:All Non-raw Variants
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                }
                            } else {
                                if (mat < 10300) { // Raw Gold Block
                                    #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = color.g * 1.5;

                                        overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                                else if (mat < 10302) { // Gold Ore
                                    if (color.r != color.g || color.r > 0.99) { // Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GOLD
                                            if (color.g - color.b > 0.15 || color.r > 0.99) {
                                                emission = color.r + 1.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Gold Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                } else /*if (mat < 10302)*/ { // Deepslate Gold Ore
                                    if (color.r != color.g || color.r > 0.99) { // Deepslate Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GOLD
                                            if (color.g - color.b > 0.15 || color.r > 0.99) {
                                                emission = color.r + 1.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Gold Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            }
                        } else {
                            if (mat < 10312) {
                                if (mat < 10308) { // Pink and Purple Modded Ores
                                    // if (mat < 10306) { // Pink Modded Ores
                                        if (color.r - color.g > 0.1) { // Redstone Ore:Lit:Redstone Part
                                            #ifdef GLOWING_ORE_MODDED
                                                emission = min(1.5, pow2(color.r) * color.r * 4.5 * color.b);
                                                overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                #endif
                                            #endif
                                        } else { // Redstone Ore:Lit:Stone Part
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        }
                                        noSmoothLighting = true;
                                    // } else { // Purple Modded Ores

                                    // }
                                }
                                else /*if (mat < 10312)*/ { // Nether Gold Ore
                                    if (color.g != color.b) { // Nether Gold Ore:Raw Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_NETHERGOLD
                                            emission = color.g * 1.5;
                                            emission *= GLOWING_ORE_MULT;

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Nether Gold Ore:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10316) { // Gold Block, Light Weighted Pressure Plate
                                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"

                                    if (mat == 10315) { // Powered Light Weighted Pressure Plate
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10320)*/ { // Diamond Block
                                    #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10352) {
                        if (mat < 10336) {
                            if (mat < 10328) {
                                if (mat < 10324) { // Diamond Ore
                                    if (color.b / color.r > 1.5 || color.b > 0.75) { // Diamond Ore:Diamond Part
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef GLOWING_ORE_DIAMOND
                                            emission = color.g + 1.5;

                                            overlayNoiseIntensity = 0.75, overlayNoiseEmission = 0.4;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Diamond Ore:Stone Part, Diamond Ore:StoneToDiamond part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                                else /*if (mat < 10328)*/ { // Deepslate Diamond Ore
                                    if (color.b / color.r > 1.5 || color.b > 0.8) { // Deepslate Diamond Ore:Diamond Part
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef GLOWING_ORE_DIAMOND
                                            emission = color.g + 1.5;

                                            overlayNoiseIntensity = 0.75, overlayNoiseEmission = 0.4;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Diamond Ore:Deepslate Part, Deepslate Diamond Ore:DeepslateToDiamond part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10332) { // Amethyst Block, Budding Amethyst
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.r);
                                    highlightMult = factor * 3.0;
                                    color.rgb *= 0.7 + 0.3 * GetLuminance(color.rgb);

                                    #if GLOWING_AMETHYST >= 2
                                        emission = dot(color.rgb, color.rgb) * 0.3;
                                        overlayNoiseEmission = 0.5;
                                    #endif
                                    
                                    #if ALTERNATIVE_AMETHYST_STYLE == 0
                                        smoothnessG = 0.8 - factor * 0.3;
                                        smoothnessD = factor;
                                    #elif ALTERNATIVE_AMETHYST_STYLE == 1
                                        smoothnessG = max(sqrt(1.0 - factor), 0.04);
                                        smoothnessD = factor * 2;
                                        color.rgb *= 1.75 - 0.4 * GetLuminance(color.rgb);
                                        color.g *= 0.85 * pow2(color.g);
                                        color.rgb = saturateColors(color.rgb, 0.6);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10336)*/ { // Amethyst Cluster, Amethyst Buds
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.r);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;

                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.85;

                                    #if GLOWING_AMETHYST >= 1
                                        #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                            vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                            vec3 blockPos = abs(fract(worldPos) - vec3(0.5));
                                            float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                            emission = pow2(max0(1.0 - maxBlockPos * 1.85) * color.g) * 7.0;

                                            if (CheckForColor(color.rgb, vec3(254, 203, 230)))
                                                emission = pow(emission, max0(1.0 - 0.2 * max0(emission - 1.0)));

                                            color.g *= 1.0 - emission * 0.07;

                                            emission *= 1.3;
                                        #else
                                            emission = pow2(color.g + color.b) * 0.4;
                                        #endif

                                        overlayNoiseIntensity = 0.5;
                                    #endif

                                    #if ALTERNATIVE_AMETHYST_STYLE == 1
                                        color.rgb = pow1_5(color.rgb);
                                        color.rgb *= 1.5;
                                        color.g *= 0.6;
                                        color.rgb = saturateColors(color.rgb, 0.7);
                                    #endif                                

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10344) {
                                if (mat < 10340) { // Emerald Block
                                    #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"

                                    #ifdef GLOWING_EMERALD_BLOCK
                                        emission = pow2(pow(color.g, 2.8)) * 3.0 + 0.3;
                                        color.rgb *= color.rgb;
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10344)*/ { // Emerald Ore
                                    float dif = GetMaxColorDif(color.rgb);
                                    if (dif > 0.25 || color.b > 0.85) { // Emerald Ore:Emerald Part
                                        #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"
                                        #ifdef GLOWING_ORE_EMERALD
                                            emission = 2.0;

                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Emerald Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10348) { // Deepslate Emerald Ore
                                    float dif = GetMaxColorDif(color.rgb);
                                    if (dif > 0.25 || color.b > 0.85) { // Deepslate Emerald Ore:Emerald Part
                                        #include "/lib/materials/specificMaterials/terrain/emeraldBlock.glsl"
                                        #ifdef GLOWING_ORE_EMERALD
                                            emission = 2.0;

                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Emerald Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10352)*/ { // Azalea, Flowering Azalea
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (max(color.b, color.r * 0.7) > color.g) {
                                            emission = skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            }
                        }
                    } else {
                        if (mat < 10368) {
                            if (mat < 10360) {
                                if (mat < 10356) { // Lapis Block
                                    #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"

                                    #ifdef EMISSIVE_LAPIS_BLOCK
                                        emission = pow2(dot(color.rgb, color.rgb)) * 10.0;

                                        overlayNoiseIntensity = 0.4, overlayNoiseEmission = 0.28;
                                    #endif
                                }
                                else /*if (mat < 10360)*/ { // Lapis Ore
                                    if (color.r != color.g) { // Lapis Ore:Lapis Part
                                        #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                        smoothnessG *= 0.5;
                                        smoothnessD *= 0.5;
                                        #ifdef GLOWING_ORE_LAPIS
                                            if (color.b - color.r > 0.2) {
                                                emission = 2.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Lapis Ore:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10364) { // Deepslate Lapis Ore
                                    if (color.r != color.g) { // Deepslate Lapis Ore:Lapis Part
                                        #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                        smoothnessG *= 0.5;
                                        smoothnessD *= 0.5;
                                        #ifdef GLOWING_ORE_LAPIS
                                            if (color.b - color.r > 0.2) {
                                                emission = 2.0;

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                                #ifdef SITUATIONAL_ORES
                                                    emission *= skyLightCheck;
                                                    color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(min1(GLOWING_ORE_MULT))), skyLightCheck);
                                                #else
                                                    color.rgb *= pow(color.rgb, vec3(min1(GLOWING_ORE_MULT)));
                                                #endif
                                                emission *= GLOWING_ORE_MULT;
                                            }
                                        #endif
                                    } else { // Deepslate Lapis Ore:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                                else /*if (mat < 10368)*/ { // Quartz Block++
                                    #include "/lib/materials/specificMaterials/terrain/quartzBlock.glsl"
                                }
                            }
                        } else {
                            if (mat < 10376) {
                                if (mat < 10372) { // Nether Quartz Ore
                                    if (color.g != color.b) { // Nether Quartz Ore:Quartz Part
                                        #include "/lib/materials/specificMaterials/terrain/quartzBlock.glsl"
                                        #ifdef GLOWING_ORE_NETHERQUARTZ
                                            emission = pow2(color.b * 1.6);
                                            emission *= GLOWING_ORE_MULT;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Nether Quartz Ore:Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"
                                    }
                                }
                                else /*if (mat < 10376)*/ { // Obsidian
                                    #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                }
                            } else {
                                if (mat < 10380) { // Purpur Block+
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(color.r) * 0.6;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10384)*/ { // 8 Layer Snow, Snow Block, Powder Snow
                                    #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10448) {
                    if (mat < 10416) {
                        if (mat < 10400) {
                            if (mat < 10392) {
                                if (mat < 10388) { // Packed Ice
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.g);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif

                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                                else /*if (mat < 10392)*/ { // Blue Ice
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = min1(pow2(color.g) * 1.38);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = pow1_5(color.g);

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif

                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                            } else {
                                if (mat < 10396) { // Pumpkin, Carved Pumpkin
                                    #include "/lib/materials/specificMaterials/terrain/pumpkin.glsl"
                                }
                                else /*if (mat < 10400)*/ { // Jack o'Lantern
                                    #include "/lib/materials/specificMaterials/terrain/pumpkin.glsl"
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    lmCoordM.y = 0.0;
                                    lmCoordM.x = 1.0;

                                    #if MC_VERSION >= 11300
                                        if (color.b > 0.28 && color.r > 0.9) {
                                            float factor = pow2(color.g);
                                            emission = pow2(factor) * factor * 5.0;
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 1.5, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 1.5, colorEndBreath, 1.0);
                                            #endif
                                        }
                                    #else
                                        if (color.b < 0.4)
                                            emission = clamp01(color.g * 1.3 - color.r) * 5.0;
                                    #endif

                                    overlayNoiseIntensity = 0.3;

                                    #ifdef SPOOKY
                                        float noiseAdd = 0.0;
                                        #ifdef GBUFFERS_TERRAIN
                                            noiseAdd = hash13(mod(floor(worldPos + atMidBlock / 64) + frameTimeCounter * 0.000001, vec3(100)));
                                        #endif
                                        emission *= mix(0.0, 1.0, smoothstep(0.2, 0.9, texture2D(noisetex, vec2(frameTimeCounter * 0.025 + noiseAdd)).r));
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10408) {
                                if (mat < 10404) { // Sea Pickle:Not Waterlogged
                                    noSmoothLighting = true;

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10408)*/ { // Sea Pickle:Waterlogged
                                    noSmoothLighting = true;

                                    overlayNoiseIntensity = 0.3;

                                    if (color.b > 0.5) { // Sea Pickle:Emissive Part
                                        #ifdef GBUFFERS_TERRAIN
                                            color.g *= 1.1;
                                            emission = 5.0;
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10412) { // Basalt+
                                    smoothnessG = color.r * 0.45;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                                else /*if (mat < 10416)*/ { // Glowstone
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(0.9, 0.0);

                                    emission = max0(color.g - 0.3) * 4.6;
                                    color.rg += emission * vec2(0.15, 0.05);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif

                                    sandNoiseIntensity = 0.6, mossNoiseIntensity = 0.6;
                                }
                            }
                        }
                    } else {
                        if (mat < 10432) {
                            if (mat < 10424) {
                                if (mat < 10420) { // Nether Bricks+
                                    float factor = smoothstep1(min1(color.r * 1.5));
                                    factor = factor > 0.12 ? factor : factor * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;
                                }
                                else /*if (mat < 10424)*/ { // Red Nether Bricks+
                                    float factor = color.r * 0.9;
                                    factor = color.r > 0.215 ? factor : factor * 0.25;
                                    smoothnessG = factor;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            } else {
                                if (mat < 10428) { // Melon
                                    smoothnessG = color.r * 0.75;
                                    smoothnessD = color.r * 0.5;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10432)*/ { // End Stone++,
                                    #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                }
                            }
                        } else {
                            if (mat < 10440) {
                                if (mat < 10436) { // Terracotta+
                                    smoothnessG = 0.25;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.17;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                }
                                else /*if (mat < 10440)*/ { // Glazed Terracotta+
                                    smoothnessG = 0.75;
                                    smoothnessD = 0.35;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            } else {
                                if (mat < 10444) { // Prismarine+, Prismarine Bricks+
                                    smoothnessG = pow2(color.g) * 0.8;
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                                else /*if (mat < 10448)*/ { // Dark Prismarine+
                                    smoothnessG = min1(pow2(color.g) * 2.0);
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10480) {
                        if (mat < 10464) {
                            if (mat < 10456) {
                                if (mat < 10452) { // Sea Lantern
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = 0.85;

                                    smoothnessD = min1(max0(0.5 - color.r) * 2.0);
                                    smoothnessG = color.g;

                                    #ifndef IPBR_COMPATIBILITY_MODE
                                        float blockRes = absMidCoordPos.x * atlasSize.x;
                                        vec2 signMidCoordPosM = (floor((signMidCoordPos + 1.0) * blockRes) + 0.5) / blockRes - 1.0;
                                        float dotsignMidCoordPos = dot(signMidCoordPosM, signMidCoordPosM);
                                        float factor = pow2(max0(1.0 - 1.7 * pow2(pow2(dotsignMidCoordPos))));
                                    #else
                                        float factor = pow2(pow2(min(dot(color.rgb, color.rgb), 2.5) / 2.5));
                                    #endif
                                    
                                    emission = pow2(color.b) * 1.6 + 2.2 * factor;
                                    emission *= 0.4 + max0(0.6 - 0.006 * lViewPos);

                                    color.rb *= vec2(1.13, 1.1);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif

                                    overlayNoiseIntensity = 0.5;
                                }
                                else /*if (mat < 10456)*/ { // Magma Block
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(0.75, 0.0);

                                    if (color.g > 0.22) { // Emissive Part
                                        emission = pow2(pow2(color.r)) * 4.0;

                                        #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                            noPuddles = color.g * 4.0;
                                        #endif

                                        color.gb *= max(2.0 - 11.0 * pow2(color.g), 0.5);

                                        maRecolor = vec3(emission * 0.075);

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else { // Netherrack Part
                                        #include "/lib/materials/specificMaterials/terrain/netherrack.glsl"

                                        emission = 0.2;
                                    }

                                }
                            } else {
                                if (mat < 10460) { // Command Block+
                                    color = texture2DLod(tex, texCoord, 0);

                                    vec2 coord = signMidCoordPos;
                                    float blockRes = absMidCoordPos.x * atlasSize.x;
                                    vec2 absCoord = abs(coord);
                                    float maxCoord = max(absCoord.x, absCoord.y);

                                    float dif = GetMaxColorDif(color.rgb);

                                    if ( // This mess exists because Iris' midCoord is slightly inaccurate
                                        dif > 0.1 && maxCoord < 0.375 &&
                                        !CheckForColor(color.rgb, vec3(111, 73, 43)) &&
                                        !CheckForColor(color.rgb, vec3(207, 166, 139)) &&
                                        !CheckForColor(color.rgb, vec3(155, 139, 207)) &&
                                        !CheckForColor(color.rgb, vec3(161, 195, 180)) &&
                                        !CheckForColor(color.rgb, vec3(201, 143, 107)) &&
                                        !CheckForColor(color.rgb, vec3(135, 121, 181)) &&
                                        !CheckForColor(color.rgb, vec3(131, 181, 145))
                                    ) {
                                        emission = 6.0;
                                        color.rgb *= color.rgb;
                                        highlightMult = 2.0;
                                        maRecolor = vec3(0.5);

                                        overlayNoiseIntensity = 0.1;
                                    } else {
                                        smoothnessG = dot(color.rgb, color.rgb) * 0.33;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                                else /*if (mat < 10464)*/ { // Concrete+ except Lime
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10472) {
                                if (mat < 10468) { // Concrete Powder+
                                    smoothnessG = 0.2;
                                    smoothnessD = 0.1;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10472)*/ { // Coral Block+
                                    #include "/lib/materials/specificMaterials/terrain/coral.glsl"
                                    // if (abs(color.r - color.g - color.b) < lColor * 0.49 || color.b > color.g) emission = (GetLuminance(color.rgb) - color.g * 0.6) * 2.5;
                                }
                            } else {
                                if (mat < 10476) { // Coral Fan+, Coral+
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/coral.glsl"
                                    isFoliage = false;
                                }
                                else /*if (mat < 10480)*/ { // Crying Obsidian
                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.7;
                                }
                            }
                        }
                    } else {
                        if (mat < 10496) {
                            if (mat < 10488) {
                                if (mat < 10484) { // Blackstone++
                                    #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"

                                    if (mat == 10483) { // Powered Blackstone Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10488)*/ { // Gilded Blackstone
                                    if (color.r > color.b * 3.0) { // Gilded Blackstone:Gilded Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GILDEDBLACKSTONE
                                            emission = color.g * 1.5;
                                            emission *= GLOWING_ORE_MULT;

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Gilded Blackstone:Blackstone Part
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }

                                }
                            } else {
                                if (mat < 10492) { // Lily Pad
                                    noSmoothLighting = true;
                                    subsurfaceMode = 2;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    #ifdef IPBR
                                        float factor = min1(color.g * 2.0);
                                        smoothnessG = factor * 0.5;
                                        highlightMult = factor;
                                    #endif
                                }
                                else /*if (mat < 10496)*/ { // Dirt Path
                                    #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    #ifdef GBUFFERS_TERRAIN
                                        glColor.a = sqrt(glColor.a);
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10504) {
                                if (mat < 10500) { // Torch
                                    noDirectionalShading = true;

                                    if (color.r > 0.95) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 1.0;
                                        emission = GetLuminance(color.rgb) * 4.1;
                                        #ifndef GBUFFERS_TERRAIN
                                            emission *= 0.65;
                                        #endif
                                        color.r *= 1.4;
                                        color.b *= 0.5;
                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            if (color.g > 0.999) color.rgb = changeColorFunction(color.rgb, 1.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            if (color.g > 0.5) color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } 
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        else if (abs(NdotU) < 0.5) {
                                            #ifndef IPBR_COMPATIBILITY_MODE
                                                #if MC_VERSION >= 12102 // torch model got changed in 1.21.2
                                                    lmCoordM.x = min1(0.7 + 0.3 * smoothstep1(max0(0.4 - signMidCoordPos.y)));
                                                #else
                                                    lmCoordM.x = min1(0.7 + 0.3 * pow2(1.0 - signMidCoordPos.y));
                                                #endif
                                            #else
                                                lmCoordM.x = 0.82;
                                            #endif
                                        }
                                    #else
                                        else {
                                            color.rgb *= 1.5;
                                        }
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    emission += 0.0001; // No light reducing during noon
                                }
                                else /*if (mat < 10504)*/ { // End Rod
                                    noDirectionalShading = true;

                                    #ifdef GBUFFERS_TERRAIN
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.92;
                                    #else
                                        lmCoordM.x = 0.9;
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 2.0) {
                                        emission = 3.3;
                                        emission *= 0.4 + max0(0.6 - 0.006 * lViewPos);
                                        vec2 noiseAdd = vec2(0.0);
                                        #if RAINBOW_END_ROD_COORD_OFFSET > 0 && defined GBUFFERS_TERRAIN
                                            noiseAdd = texture2D(noisetex, 0.00048 * (playerPos.xz + cameraPosition.xz)).rg;
                                            noiseAdd *= RAINBOW_END_ROD_COORD_OFFSET;
                                        #endif
                                        #if END_ROD_COLOR_PROFILE == 1
                                            color.rgb = pow2(vec3(END_ROD_R, END_ROD_G, END_ROD_B) / 255) * END_ROD_I;
                                        #elif END_ROD_COLOR_PROFILE == 2 || (END_ROD_COLOR_PROFILE == 3 && defined OVERWORLD)
                                            color.rgb = pow2(getRainbowColor(noiseAdd, END_ROD_RAINBOW_ANIMATE));
                                        #else
                                            color.rgb = pow2(color.rgb);
                                            color.g *= 0.95;
                                        #endif
                                    }

                                    #ifdef GBUFFERS_TERRAIN
                                        else { // Directional Self-light Effect
                                            vec3 fractPos = abs(fract(playerPos + cameraPosition) - 0.5);
                                            float maxCoord = max(fractPos.x, max(fractPos.y, fractPos.z));
                                            if (maxCoord < 0.4376) {
                                                lmCoordM.x = 1.0;
                                                color.rgb *= 1.8;
                                            }
                                        }
                                    #endif

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 4.0, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                            } else {
                                if (mat < 10508) { // Chorus Plant

                                }
                                else /*if (mat < 10512)*/ { // Chorus Flower:Alive
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor > 1.0) {
                                        emission = pow2(pow2(pow2(dotColor * 0.33))) + 0.2 * dotColor;
                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.6;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } else {
        if (mat < 10768) {
            if (mat < 10640) {
                if (mat < 10576) {
                    if (mat < 10544) {
                        if (mat < 10528) {
                            if (mat < 10520) {
                                if (mat < 10516) { // Chorus Flower:Dead
                                    vec3 checkColor = texture2DLod(tex, texCoord, 0).rgb;
                                    if (CheckForColor(checkColor, vec3(164, 157, 126)) ||
                                        CheckForColor(checkColor, vec3(201, 197, 176)) ||
                                        CheckForColor(checkColor, vec3(226, 221, 188)) ||
                                        CheckForColor(checkColor, vec3(153, 142, 95))
                                    ) {
                                        emission = min(GetLuminance(color.rgb), 0.75) / 0.75;
                                        emission = pow2(pow2(emission)) * 6.5;
                                        color.gb *= 0.85;

                                        overlayNoiseIntensity = 0.1, overlayNoiseEmission = 0.8;
                                    } else emission = max0(GetLuminance(color.rgb) - 0.5) * 3.0;
                                }
                                else /*if (mat < 10520)*/ { // Furnace:Lit
                                    lmCoordM.x *= 0.95;

                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                    color.r *= 1.0 + 0.1 * emission;

                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                        overlayNoiseIntensity = 0.0;
                                    }
                                }
                            } else {
                                if (mat < 10524) { // Cactus
                                    float factor = sqrt1(color.r);
                                    smoothnessG = factor * 0.5;
                                    highlightMult = factor;

                                    mossNoiseIntensity = 0.0, sandNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10528)*/ { // Note Block, Jukebox
                                    float factor = color.r * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif

                                    if (mat == 10526) { // Powered Note Block
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10536) {
                                if (mat < 10532) { // Soul Torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                    if (color.b > 0.6) {
                                        emission = 2.7;
                                        color.rgb = pow1_5(color.rgb);
                                        color.r = min1(color.r + 0.1);

                                        overlayNoiseIntensity = 0.0;
                                    }
                                    emission += 0.0001; // No light reducing during noon

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(0.5, 1.0, 1.0, 1.0), emission, 3.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10536)*/ { // Brown Mushroom Block
                                    if (color.r > color.g && color.g > color.b && color.b > 0.37) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = pow2(color.r) * color.r * 0.8;
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.9;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            } else {
                                if (mat < 10540) { // Red Mushroom Block
                                    if (color.r > color.g && color.g > color.b && color.b > 0.37) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = min1(pow2(color.g) + 0.25);
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.7;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                                else /*if (mat < 10544)*/ { // Mushroom Stem,
                                    if (color.r > color.g && color.g > color.b && color.b < 0.6) {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    } else {
                                        float factor = pow2(pow2(color.g));
                                        highlightMult = 1.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor * 0.5;

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10560) {
                            if (mat < 10552) {
                                if (mat < 10548) { // Glow Lichen
                                    noSmoothLighting = true;

                                    #if GLOWING_LICHEN > 0
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(dotColor) * dotColor) * 1.4 + dotColor * 0.9, 6.0);
                                        emission = mix(emission, dotColor * 1.5, min1(lViewPos / 96.0)); // Less noise in the distance

                                        #if GLOWING_LICHEN == 1
                                            float skyLightFactor = pow2(1.0 - min1(lmCoord.y * 2.9));
                                            emission *= skyLightFactor;

                                            color.r *= 1.0 + 0.15 * skyLightFactor;
                                        #else
                                            color.r *= 1.15;
                                        #endif
                                    #endif

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10552)*/ { // Enchanting Table:Base
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (dotColor < 0.19 && color.r < color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                    } else if (color.g >= color.r) {
                                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                                        #ifdef EMISSIVE_ENCHANTING_TABLE
                                            emission = color.b + 0.4 + (1.0 - pow2(color.g)) * 0.8;
                                        #endif
                                    } else {
                                        smoothnessG = color.r * 0.3 + 0.1;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            } else {
                                if (mat < 10556) { // End Portal Frame:Inactive
                                    noSmoothLighting = true;

                                    if (abs(color.r - color.g - 0.05) < 0.10) {
                                        #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/endPortalFrame.glsl"
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10560)*/ { // End Portal Frame:Active
                                    noSmoothLighting = true;

                                    if (abs(color.r - color.g - 0.05) < 0.10) {
                                        #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/endPortalFrame.glsl"

                                        vec2 absCoord = abs(fract(playerPos.xz + cameraPosition.xz) - 0.5);
                                        float maxCoord = max(absCoord.x, absCoord.y);
                                        if (maxCoord < 0.2505) { // End Portal Frame:Eye of Ender
                                            smoothnessG = 0.5;
                                            smoothnessD = 0.5;
                                            emission = pow2(min(color.g, 0.25)) * 170.0 * (0.28 - maxCoord);

                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                        } else {
                                            float minCoord = min(absCoord.x, absCoord.y);
                                            if (CheckForColor(color.rgb, vec3(153, 198, 147))
                                            && minCoord > 0.25) { // End Portal Frame:Emissive Corner Bits
                                                emission = 1.4;
                                                color.rgb = vec3(0.45, 1.0, 0.6);

                                                overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                            }
                                        }
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10568) {
                                if (mat < 10564) { // Lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = 0.77;

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"

                                    emission = 4.3 * max0(color.r - color.b);
                                    emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                    color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.0;

                                    #ifdef SS_BLOCKLIGHT // fix lanterns with custom models emitting blue light
                                        if (emission < 0.01) emission = 0.0;
                                    #endif

                                    #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                        if(color.g > color.b){
                                            float uniformValue = 1.0;
                                            float gradient = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            #if defined NETHER
                                                #ifdef GBUFFERS_TERRAIN
                                                    float lanternOffset = 0.0;
                                                    if (mat == 10562) lanternOffset = 0.1; // Hanging Lantern
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y - lanternOffset + 3.0 * blockUV.y - lanternOffset));
                                                #else
                                                    gradient = 0.0;
                                                #endif
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                            #endif
                                            #ifdef END
                                                colorFire = colorEndBreath;
                                            #endif
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        }
                                    #endif
                                }
                                else /*if (mat < 10568)*/ { // Soul Lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"

                                    emission = 1.45 * max0(color.g - color.r * 2.0);
                                    emission += 1.17 * min(pow2(pow2(0.55 * dot(color.rgb, color.rgb))), 3.5);

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(0.5, 1.0, 1.0, 1.0), emission, 3.0, lViewPos);
                                    #endif

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                            } else {
                                if (mat < 10572) { // Turtle Egg, Sniffer Egg
                                    smoothnessG = (color.r + color.g) * 0.35;
                                    smoothnessD = (color.r + color.g) * 0.25;
                                }
                                else /*if (mat < 10576)*/ { // Dragon Egg
                                    #ifdef EMISSIVE_DRAGON_EGG
                                        emission = float(color.b > 0.1) * 10.0 + 1.25;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10608) {
                        if (mat < 10592) {
                            if (mat < 10584) {
                                if (mat < 10580) { // Smoker:Lit
                                    lmCoordM.x *= 0.95;

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        emission = 2.5 * dotColor;
                                        color.r *= 1.5;

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                                else /*if (mat < 10584)*/ { // Blast Furnace:Lit
                                    lmCoordM.x *= 0.95;

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        emission = pow2(color.g) * (20.0 - 13.7 * float(color.b > 0.25));
                                        color.r *= 1.5;

                                        overlayNoiseIntensity = 0.0;

                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10588) { // Coal Block
                                    smoothnessG = dot(color.rgb, vec3(0.5));
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10592)*/ { // Respawn Anchor:Unlit
                                    noSmoothLighting = true;

                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"
                                    emission += 0.2;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10600) {
                                if (mat < 10596) { // Respawn Anchor:Lit
                                    noSmoothLighting = true;

                                    #include "/lib/materials/specificMaterials/terrain/cryingObsidian.glsl"

                                    vec2 absCoord = abs(signMidCoordPos);
                                    if (NdotU > 0.9 && max(absCoord.x, absCoord.y) < 0.754) { // Portal
                                        highlightMult = 0.0;
                                        smoothnessD = 0.0;
                                        emission = pow2(color.r) * color.r * 16.0;
                                        maRecolor = vec3(0.0);

                                        overlayNoiseIntensity = 0.0;
                                    } else if (color.r + color.g > 1.3) { // Respawn Anchor:Glowstone Part
                                        emission = 4.5 * sqrt3(max0(color.r + color.g - 1.3));
                                    }

                                    emission += 0.3;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10600)*/ { // Redstone Wire:Lit
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"

                                    #if COLORED_LIGHTING_INTERNAL == 0
                                        emission = pow2(min(color.r, 0.9)) * 4.0;
                                    #else
                                        vec3 colorP = color.rgb / glColor.rgb;
                                        emission = pow2((colorP.r + color.r) * 0.5) * 3.5;
                                    #endif

                                    color.gb *= 0.25;

                                    overlayNoiseIntensity = 0.0;
                                }
                            } else {
                                if (mat < 10604) { // Redstone Wire:Unlit
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"

                                    overlayNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10608)*/ { // Redstone Torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);

                                    #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"
                                    emission += 0.0001; // No light reducing during noon

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.0, 0.0, 1.0), emission, 5.0, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        }
                    } else {
                        if (mat < 10624) {
                            if (mat < 10616) {
                                if (mat < 10612) { // Redstone Block
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                    #ifdef EMISSIVE_REDSTONE_BLOCK
                                        emission = 0.75 + 3.0 * pow2(pow2(color.r));
                                        color.gb *= 0.65;

                                        #ifdef SNOWY_WORLD
                                            snowFactor = 0.0;
                                        #endif

                                        overlayNoiseIntensity = 0.5, sandNoiseIntensity = 0.5, mossNoiseIntensity = 0.5;
                                    #endif
                                }
                                else /*if (mat < 10616)*/ { // Redstone Ore:Unlit
                                    if (color.r - color.g > 0.2) { // Redstone Ore:Unlit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        #ifdef GLOWING_ORE_REDSTONE
                                            emission = color.r * pow1_5(color.r) * 4.0;

                                            overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.gb = mix(color.gb, color.gb * (1.0 - 0.9 * min1(GLOWING_ORE_MULT)), skyLightCheck);
                                            #else
                                                color.gb *= 1.0 - 0.9 * min1(GLOWING_ORE_MULT);
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Redstone Ore:Unlit:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10620) { // Redstone Ore:Lit
                                    if (color.r - color.g > 0.2) { // Redstone Ore:Lit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        emission = pow2(color.r) * color.r * 5.5;
                                        color.gb *= 0.1;

                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                    } else { // Redstone Ore:Lit:Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10624)*/ { // Deepslate Redstone Ore:Unlit
                                    if (color.r - color.g > 0.2) { // Deepslate Redstone Ore:Unlit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        #ifdef GLOWING_ORE_REDSTONE
                                            emission = color.r * pow1_5(color.r) * 4.0;

                                            overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;

                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.gb = mix(color.gb, color.gb * (1.0 - 0.9 * min1(GLOWING_ORE_MULT)), skyLightCheck);
                                            #else
                                                color.gb *= 1.0 - 0.9 * min1(GLOWING_ORE_MULT);
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else { // Deepslate Redstone Ore:Unlit:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            }
                        } else {
                            if (mat < 10632) {
                                if (mat < 10628) { // Deepslate Redstone Ore:Lit
                                    if (color.r - color.g > 0.2) { // Deepslate Redstone Ore:Lit:Redstone Part
                                        #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                        emission = pow2(color.r) * color.r * 6.0;
                                        color.gb *= 0.05;

                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.5;
                                    } else { // Deepslate Redstone Ore:Lit:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10632)*/ { // Cave Vines:No Glow Berries
                                    subsurfaceMode = 1;
                                    lmCoordM.x *= 0.875;

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                            } else {
                                if (mat < 10636) { // Cave Vines:With Glow Berries
                                    subsurfaceMode = 1;
                                    lmCoordM.x *= 0.875;

                                    if (color.r > 0.64) {
                                        emission = color.r < 0.75 ? 2.5 : 8.0;
                                        color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                        isFoliage = false;
                                    } else {
                                        isFoliage = true;
                                    }

                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10640)*/ { // Redstone Lamp:Unlit
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    smoothnessG = color.r * 0.5 + 0.2;
                                    float factor = pow2(smoothnessG);
                                    highlightMult = factor * 2.0 + 1.0;
                                    smoothnessD = min1(factor * 2.0);

                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10704) {
                    if (mat < 10672) {
                        if (mat < 10656) {
                            if (mat < 10648) {
                                if (mat < 10644) { // Redstone Lamp:Lit
                                    noDirectionalShading = true;
                                    lmCoordM.x = 0.84;

                                    materialMask = OSIEBCA; // Intense Fresnel
                                    smoothnessG = color.r * 0.35 + 0.2;
                                    float factor = pow2(smoothnessG);
                                    highlightMult = factor * 2.0 + 1.0;
                                    smoothnessD = min1(factor * 2.0);

                                    if (color.b > 0.1) {
                                        float dotColor = dot(color.rgb, color.rgb);
                                        #if MC_VERSION >= 11300
                                            emission = pow2(dotColor) * 1.0;
                                        #else
                                            emission = dotColor * 1.2;
                                        #endif
                                        color.rgb = pow1_5(color.rgb);
                                        maRecolor = vec3(emission * 0.2);

                                        overlayNoiseIntensity = 0.3;
                                    }

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 5.0, lViewPos);
                                    #endif
                                }
                                else /*if (mat < 10648)*/ { // Repeater, Comparator
                                    noSmoothLighting = true;
                                    
                                    #if ANISOTROPIC_FILTER > 0
                                        color = texture2D(tex, texCoord); // Fixes artifacts
                                        color.rgb *= glColor.rgb;
                                    #endif

                                    vec3 absDif = abs(vec3(color.r - color.g, color.g - color.b, color.r - color.b));
                                    float maxDif = max(absDif.r, max(absDif.g, absDif.b));
                                    if (maxDif > 0.125 || color.b > 0.99) { // Redstone Parts
                                        if (color.r < 0.999 && color.b > 0.4) color.gb *= 0.5; // Comparator:Emissive Wire

                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"

                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.2;
                                    } else { // Quartz Base
                                        float factor = pow2(color.g) * 0.6;

                                        smoothnessG = factor;
                                        highlightMult = 1.0 + 2.5 * factor;
                                        smoothnessD = factor;
                                    }
                                }
                            } else {
                                if (mat < 10652) { // Shroomlight
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(1.0, 0.0);

                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;

                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                    #endif

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10656)*/ { // Campfire:Lit
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));

                                        #ifdef LIGHTMAP_CURVES
                                            float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                            lmCoordM.x *= campfireBrightnessFactor;
                                        #endif
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b && color.r - color.g < 0.15 && dotColor < 1.4) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    } else if (color.r > color.b || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 3.5;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));

                                        overlayNoiseIntensity = 0.0;

                                        #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                            float uniformValue = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            float gradient = 0.0;
                                            #if defined NETHER
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.5 * blockUV.y));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, handUV + 0.4);
                                                #endif
                                            #endif
                                            #ifdef END 
                                                colorFire = colorEndBreath;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.07 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, clamp01(handUV + 0.3 - 1.3 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * handUV)));
                                                #endif
                                            #endif
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        #endif
                                    }
                                }
                            }
                        } else {
                            if (mat < 10664) {
                                if (mat < 10660) { // Soul Campfire:Lit
                                    #if COLORED_LIGHTING_INTERNAL == 0
                                        noSmoothLighting = true;
                                    #else
                                        #ifdef GBUFFERS_TERRAIN
                                            vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                            lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                            lmCoordM.x *= 0.95;
                                        #endif
                                    #endif

                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    } else if (color.g - color.r > 0.1 || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 2.1;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));

                                        overlayNoiseIntensity = 0.0;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10664)*/ { // Campfire:Unlit, Soul Campfire:Unlit
                                    noSmoothLighting = true;

                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10668) { // Observer
                                    if (color.r > 0.1 && color.g + color.b < 0.1) {
                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"

                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.15;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                    }
                                }
                                else if (mat < 10671) { // Wool+, Carpet+ except Lime, MV: Tripwire
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*(mat == )*/ { // Tripwire
                                    redstoneIPBR(color.rgb, emission);
                                }
                            }
                        }
                    } else {
                        if (mat < 10688) {
                            if (mat < 10680) {
                                if (mat < 10676) { // Bone Block
                                    smoothnessG = color.r * 0.2;
                                    smoothnessD = smoothnessG;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                }
                                else /*if (mat < 10680)*/ { // Barrel, Beehive, Bee Nest, Honeycomb Block
                                    #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            } else {
                                if (mat < 10684) { // Ochre Froglight
                                    float frogPow = 8.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10688)*/ { // Verdant Froglight
                                    float frogPow = 16.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        } else {
                            if (mat < 10696) {
                                if (mat < 10692) { // Pearlescent Froglight
                                    float frogPow = 24.0;
                                    #include "/lib/materials/specificMaterials/terrain/froglights.glsl"

                                    overlayNoiseIntensity = 0.3;
                                }
                                else /*if (mat < 10696)*/ { // Reinforced Deepslate
                                    if (abs(color.r - color.g) < 0.01) { // Reinforced Deepslate:Deepslate Part
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    } else { // Reinforced Deepslate:Sculk
                                        float boneFactor = max0(color.r * 1.25 - color.b);

                                        if (boneFactor < 0.0001) emission = 0.15;

                                        smoothnessG = min1(boneFactor * 1.7);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            } else {
                                //#define INTENSE_DEEP_DARK
                                if (mat < 10700) { // Sculk, Sculk Catalyst, Sculk Vein, Sculk Sensor:Unlit
                                    float boneFactor = max0(color.r * 1.25 - color.b);

                                    float sculkEmission = pow2(max0(color.g - color.r)) * 1.7;
                                    if (boneFactor < 0.0001) {
                                        overlayNoiseIntensity = 0.0;
                                        #ifdef INTENSE_DEEP_DARK
                                            emission = mix(sculkEmission, sculkEmission * 5.0, darknessFactor);
                                        #else
                                            emission = sculkEmission;
                                        #endif

                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.501)
                                                    + floor(playerPos.y + cameraPosition.y + 0.501);
                                            bpos = bpos * 0.01 + 0.003 * frameTimeCounter;
                                            emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                            emission *= 6.0;
                                        #endif
                                    }

                                    smoothnessG = min1(boneFactor * 1.7);
                                    smoothnessD = smoothnessG;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                                else /*if (mat < 10704)*/ { // Sculk Shrieker
                                    float boneFactor = max0(color.r * 1.25 - color.b);

                                    if (boneFactor < 0.0001) {
                                        overlayNoiseIntensity = 0.0;
                                        float sculkEmission = pow2(max0(color.g - color.r)) * 2.0;
                                        #ifdef INTENSE_DEEP_DARK
                                            emission = mix(sculkEmission, sculkEmission * 3.0, darknessFactor);
                                        #else
                                            emission = sculkEmission;
                                        #endif

                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 coordFactor = abs(fract(playerPos.xz + cameraPosition.xz) - 0.5);
                                            float coordFactorM = max(coordFactor.x, coordFactor.y);
                                            if (coordFactorM < 0.43) emission += color.g * 7.0;
                                        #endif
                                    }

                                    smoothnessG = min1(boneFactor * 1.7);
                                    smoothnessD = smoothnessG;

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10736) {
                        if (mat < 10720) {
                            if (mat < 10712) {
                                if (mat < 10708) { // Sculk Sensor:Lit
                                    lmCoordM = vec2(0.0, 0.0);
                                    emission = pow2(max0(color.g - color.r)) * 7.0 + 0.7;

                                    overlayNoiseIntensity = 0.0;
                                    redstoneIPBR(color.rgb, emission);
                                }
                                else /*if (mat < 10712)*/ { // Spawner
                                    smoothnessG = color.b + 0.2;
                                    smoothnessD = smoothnessG;

                                    emission = 7.0 * float(CheckForColor(color.rgb, vec3(110, 4, 83)));

                                    overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.15;
                                }
                            } else {
                                if (mat < 10716) { // Tuff++
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10720)*/ { // Clay
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.g)) * 0.5;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG * 0.7;

                                    #ifdef GBUFFERS_TERRAIN
                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10728) {
                                if (mat < 10724) { // Ladder
                                    noSmoothLighting = true;
                                }
                                else /*if (mat < 10728)*/ { // Gravel, Suspicious Gravel
                                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"

                                    #ifdef GBUFFERS_TERRAIN
                                        DoOceanBlockTweaks(smoothnessD);
                                    #endif

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.25;
                                    #endif
                                }
                            } else {
                                if (mat < 10732) { // Flower Pot, Potted Stuff:Without Subsurface
                                    noSmoothLighting = true;

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10736)*/ { // Potted Stuff:With Subsurface
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                    #if defined GBUFFERS_TERRAIN && (EMISSIVE_FLOWERS > 0 || defined EMISSIVE_BLOOD_MOON_FLOWERS)
                                        if (mat == 10735 && blockUV.y > 0.4 && max(color.b, color.r * 1.3) > color.g) { // Potted Flowers
                                            isFoliage = false;
                                            #if EMISSIVE_FLOWERS > 0
                                                emission = 2.0 * skyLightCheck;
                                                #if EMISSIVE_FLOWERS == 2
                                                    emission = max(emission, rainFactor + 1.0 * rainFactor);
                                                #endif
                                                #if EMISSIVE_FLOWERS_TYPE == 1
                                                    if (color.b < max(color.r, color.g * 1.1) * 0.95) emission = 0.0;
                                                #elif EMISSIVE_FLOWERS_TYPE == 2
                                                    if (color.r < max(color.b * 1.15, color.g * 1.1) * 0.95) emission = 0.0;
                                                #endif
                                            #else
                                                emission *= int(color.r > max(color.b * 1.15, color.g * 2.5) * 0.95) * getBloodMoon(moonPhase, sunVisibility);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif
                                }
                            }
                        }
                    } else {
                        if (mat < 10752) {
                            if (mat < 10744) {
                                if (mat < 10738) { // Pitcher Crop
                                    noSmoothLighting = true;
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                    #if EMISSIVE_FLOWERS > 0 && EMISSIVE_FLOWERS_TYPE < 2
                                        if (max(color.b * 1.25, color.r * 0.91) > color.g) { // Flowers
                                            emission = 1.5 * skyLightCheck;

                                            #if EMISSIVE_FLOWERS == 2
                                                emission = max(emission, rainFactor + 1.0 * rainFactor);
                                            #endif
                                            emission *= EMISSIVE_FLOWERS_STRENGTH;
                                        }
                                    #endif

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    } else {
                                        emission = 0.0;
                                    }
                                }
                                else if (mat < 10740) { // Structure Block, Jigsaw Block, Test Block, Test Instance Block
                                    float blockRes = absMidCoordPos.x * atlasSize.x;
                                    vec2 signMidCoordPosM = (floor((signMidCoordPos + 1.0) * blockRes) + 0.5) / blockRes - 1.0;
                                    float dotsignMidCoordPos = dot(signMidCoordPosM, signMidCoordPosM);
                                    float lBlockPosM = pow2(max0(1.0 - 1.125 * pow2(dotsignMidCoordPos)));

                                    emission = 2.5 * lBlockPosM + 1.0;
                                    color.rgb = mix(color.rgb, pow2(color.rgb), 0.5);

                                    overlayNoiseIntensity = 0.45, overlayNoiseEmission = 0.2;
                                }
                                else /*if (mat < 10744)*/ { // Chain
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523

                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                }
                            } else {
                                if (mat < 10748) { // Soul Sand, Soul Soil
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = color.r * 0.25;
                                    #if defined GBUFFERS_TERRAIN && defined EMISSIVE_SOUL_SAND
                                        if (mat == 10744) {
                                            vec3 playerPosM = playerPos + relativeEyePosition;
                                            if (length(playerPosM) < 3.0 && length(playerPosM.y) > 1.1)
                                            if (color.r < 0.26 && color.r > 0.257 && color.g < 0.2 && color.b < 0.17 && blockUV.y > 0.9999 // A lot of hardcoded stuff
                                            &&(blockUV.x > 0.625 && blockUV.z < 0.5 && blockUV.z > 0.375 
                                            || blockUV.x < 0.5 && blockUV.x > 0.25 && blockUV.z < 0.1875
                                            || blockUV.x < 0.375 && blockUV.z > 0.8125)) {
                                                float randomPos = step(0.5, hash13(mod(floor(worldPos + atMidBlock / 64) + frameTimeCounter * 0.0001, vec3(100))));
                                                vec2 flickerNoiseBlock = texture2D(noisetex, vec2(frameTimeCounter * 0.04)).rb;
                                                float noise = mix(1.0, min1(max(flickerNoiseBlock.r, flickerNoiseBlock.g) * 1.7), 0.6) * (clamp(3.0 / length(vec3(playerPosM.x * 1.5, playerPosM.y, playerPosM.z * 1.5)) - 1.0, 0.0, 0.25) * 2.0) * randomPos;
                                                color.rgb = changeColorFunction(color.rgb, 80.0, colorSoul, noise);
                                                emission = 4.0 * noise;
                                                overlayNoiseIntensity = 1.0 - noise;
                                            }
                                        }
                                    #endif
                                }
                                else /*if (mat < 10752)*/ { // Dried Kelp Block
                                    smoothnessG = pow2(color.b) * 0.8;
                                    smoothnessD = smoothnessG;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10760) {
                                if (mat < 10756) { // Bamboo
                                    if (absMidCoordPos.x > 0.005)
                                        subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;
                                    // No further material properties as bamboo jungles are already slow

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                }
                                else /*if (mat < 10760)*/ { // Block of Bamboo, Bamboo Planks++
                                    #include "/lib/materials/specificMaterials/planks/bambooPlanks.glsl"
                                    if (mat == 10759) { // Powered Bamboo Blocks
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10764) { // Cherry Planks++
                                    #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"

                                    if (mat == 10763) { // Powered Cherry Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10768)*/ { // Cherry Log, Cherry Wood
                                    if (color.g > 0.33) { // Cherry Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"
                                    } else { // Cherry Log:Wood Part, Cherry Wood
                                        smoothnessG = pow2(color.r);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            if (mat < 10896) {
                if (mat < 10832) {
                    if (mat < 10800) {
                        if (mat < 10784) {
                            if (mat < 10776) {
                                if (mat < 10772) { // Torchflower
                                    #include "/lib/materials/specificMaterials/terrain/torchflower.glsl"
                                }
                                else /*if (mat < 10776)*/ { // Potted Torchflower
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/torchflower.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10780) { // Crimson Fungus, Warped Fungus
                                    noSmoothLighting = true;

                                    if (color.r > 0.91) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);

                                        overlayNoiseIntensity = 0.5;
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0; isFoliage = false;
                                }
                                else /*if (mat < 10784)*/ { // Potted Crimson Fungus, Potted Warped Fungus
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        if (color.r > 0.91) {
                                            emission = 3.0 * color.g;
                                            color.r *= 1.2;
                                            maRecolor = vec3(0.1);
                                        }
                                    }

                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                }
                            }
                        } else {
                            if (mat < 10792) {
                                if (mat < 10788) { // Calibrated Sculk Sensor:Unlit
                                    #if ANISOTROPIC_FILTER == 0
                                        vec4 checkColor = color;
                                    #else
                                        vec4 checkColor = texture2D(tex, texCoord); // Fixes artifacts
                                    #endif
                                    if (checkColor.r + checkColor.b > checkColor.g * 2.2 || checkColor.r > 0.99) { // Amethyst Part
                                        #if GLOWING_AMETHYST >= 1
                                            #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                                vec2 absCoord = abs(signMidCoordPos);
                                                float maxBlockPos = max(absCoord.x, absCoord.y);
                                                emission = pow2(max0(1.0 - maxBlockPos) * color.g) * 5.4 + 1.2 * color.g;

                                                color.g *= 1.0 - emission * 0.07;
                                                color.rgb *= color.g;
                                            #else
                                                emission = pow2(color.g + color.b) * 0.32;
                                            #endif
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    } else { // Sculk Part
                                        float boneFactor = max0(color.r * 1.25 - color.b);

                                        if (boneFactor < 0.0001) emission = pow2(max0(color.g - color.r));

                                        smoothnessG = min1(boneFactor * 1.7);
                                        smoothnessD = smoothnessG;
                                    }

                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif

                                    overlayNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10792)*/ { // Calibrated Sculk Sensor:Lit
                                    lmCoordM = vec2(0.0, 0.0);

                                    #if ANISOTROPIC_FILTER == 0
                                        vec4 checkColor = color;
                                    #else
                                        vec4 checkColor = texture2D(tex, texCoord); // Fixes artifacts
                                    #endif
                                    if (checkColor.r + checkColor.b > checkColor.g * 2.2 || checkColor.r > 0.99) { // Amethyst Part
                                        lmCoordM.x = 1.0;

                                        #if GLOWING_AMETHYST >= 1
                                            #if defined GBUFFERS_TERRAIN && !defined IPBR_COMPATIBILITY_MODE
                                                vec2 absCoord = abs(signMidCoordPos);
                                                float maxBlockPos = max(absCoord.x, absCoord.y);
                                                emission = pow2(max0(1.0 - maxBlockPos) * color.g) * 5.4 + 1.2 * color.g;

                                                color.g *= 1.0 - emission * 0.07;
                                                color.rgb *= color.g;
                                            #else
                                                emission = pow2(color.g + color.b) * 0.32;
                                            #endif
                                        #endif

                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.66;
                                        #endif
                                    } else { // Sculk Part
                                        emission = pow2(max0(color.g - color.r)) * 7.0 + 0.7;
                                    }

                                    overlayNoiseIntensity = 0.0;
                                    redstoneIPBR(color.rgb, emission);
                                }
                            } else {
                                if (mat < 10796) { // Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"

                                    if (mat == 10795) { // Powered Oak Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10800)*/ { // Spruce Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"

                                    if (mat == 10799) { // Powered Spruce Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10816) {
                            if (mat < 10808) {
                                if (mat < 10804) { // Birch Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"

                                    if (mat == 10803) { // Powered Birch Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10808)*/ { // Jungle Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"

                                    if (mat == 10807) { // Powered Jungle Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10812) { // Acacia Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/acaciaPlanks.glsl"

                                    if (mat == 10811) { // Powered Acacia Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10816)*/ { // Dark Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"

                                    if (mat == 10815) { // Powered Dark Oak Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else {
                            if (mat < 10824) {
                                if (mat < 10820) { // Mangrove Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/mangrovePlanks.glsl"

                                    if (mat == 10819) { // Powered Mangrove Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10824)*/ { // Crimson Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"

                                    if (mat == 10823) { // Powered Crimson Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else {
                                if (mat < 10828) { // Warped Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"

                                    if (mat == 10827) { // Powered Warped Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10832)*/ { // Bamboo Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/bambooPlanks.glsl"

                                    if (mat == 10831) { // Powered Bamboo Door
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10864) {
                        if (mat < 10848) {
                            if (mat < 10840) {
                                if (mat < 10836) { // Cherry Door, Cherry Trapdoor
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/cherryPlanks.glsl"

                                    if (mat == 10835) { // Powered Cherry Door and Cherry Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                                else /*if (mat < 10840)*/ { // Brewing Stand
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos + cameraPosition;
                                        vec3 fractPos = fract(worldPos.xyz);
                                        vec3 coordM = abs(fractPos.xyz - 0.5);
                                        float cLength = dot(coordM, coordM) * 1.3333333;
                                        cLength = pow2(1.0 - cLength);

                                        if (color.r + color.g > color.b * 3.0 && max(coordM.x, coordM.z) < 0.07) {
                                            emission = 2.5 * pow1_5(cLength);
                                        } else {
                                            lmCoordM.x = max(lmCoordM.x * 0.9, cLength);

                                            #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                                        }
                                    #else
                                        emission = max0(color.r + color.g - color.b * 1.8 - 0.3) * 2.2;
                                    #endif

                                    overlayNoiseIntensity = 0.0;

                                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                    #endif
                                    #ifdef PURPLE_END_FIRE_INTERNAL
                                        color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                    #endif
                                }
                            } else {
                                if (mat < 10841) { // Lime Concrete
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif

                                    #ifdef GREEN_SCREEN_LIME
                                        materialMask = OSIEBCA * 240.0; // Green Screen Lime Blocks
                                    #endif
                                }
                                else if (mat < 10844) { // Blue Carpet, Blue Wool
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #ifdef BLUE_SCREEN
                                        materialMask = OSIEBCA * 239.0; // Blue Screen Blue Blocks
                                    #endif
                                }
                                else if (mat < 10846) { // Lime Carpet, Lime Wool, MV: Green stuff
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif

                                    #ifdef GREEN_SCREEN_LIME
                                        materialMask = OSIEBCA * 240.0; // Green Screen Lime Blocks
                                    #endif
                                }
                                else /*if (mat < 10847)*/ { // Blue Concrete
                                    smoothnessG = 0.4;
                                    highlightMult = 1.5;
                                    smoothnessD = 0.3;

                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.2;
                                    #endif

                                    #ifdef BLUE_SCREEN
                                        materialMask = OSIEBCA * 239.0; // Blue Screen Blue Blocks
                                    #endif
                                }
                            }
                        } else {
                            if (mat < 10856) {
                                if (mat < 10852) { // Crafter
                                    smoothnessG = pow2(color.b);
                                    smoothnessD = max(smoothnessG, 0.2);

                                    if (color.r > 2.5 * (color.g + color.b)) {
                                        emission = 4.0;
                                        color.rgb *= color.rgb;
                                    }
                                }
                                else /*if (mat < 10856)*/ { // Copper Bulb:BrighterOnes
                                    #include "/lib/materials/specificMaterials/terrain/copperBulb.glsl"
                                }
                            } else {
                                if (mat < 10860) { // Copper Bulb:DimmerOnes
                                    #include "/lib/materials/specificMaterials/terrain/copperBulb.glsl"
                                    emission *= 0.85;
                                }
                                else /*if (mat < 10864)*/ { // Copper Door+, Copper Trapdoor+
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"

                                    if (mat == 10863) { // Powered Copper Door+, Copper Trapdoor+
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else {
                        if (mat < 10880) {
                            if (mat < 10872) {
                                if (mat < 10868) { // Copper Trapdoor+
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                }
                                else /*if (mat < 10872)*/ { // Trial Spawner:NotOminous:Active, Vault:NotOminous:Active
                                    smoothnessG = max0(color.b - color.r * 0.5);
                                    smoothnessD = smoothnessG;

                                    emission = max0(color.r - color.b) * 3.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + 0.5 * sqrt(emission)));
                                }
                            } else {
                                if (mat < 10876) { // Trial Spawner:Inactive, Vault:Inactive
                                    smoothnessG = max0(color.b - color.r * 0.5);
                                    smoothnessD = smoothnessG;
                                }
                                else /*if (mat < 10880)*/ { // Trial Spawner:Ominous:Active, Vault:Ominous:Active
                                    float maxComponent = max(max(color.r, color.g), color.b);
                                    float minComponent = min(min(color.r, color.g), color.b);
                                    float saturation = (maxComponent - minComponent) / (1.0 - abs(maxComponent + minComponent - 1.0));

                                    smoothnessG = max0(color.b - pow2(saturation) * 0.5) * 0.5 + 0.1;
                                    smoothnessD = smoothnessG;

                                    emission = saturation > 0.5 ? 4.0 : 0.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + (0.3 + 0.5 * color.r) * emission));
                                }
                            }
                        } else {
                            if (mat < 10888) {
                                if (mat < 10884) { //

                                }
                                else /*if (mat < 10888)*/ { // Weeping Vines, Twisting Vines
                                    noSmoothLighting = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    if (color.r > 0.91 && mat == 10884) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);
                                    }
                                    isFoliage = false;
                                }
                            } else {
                                if (mat < 10891) { // Hay Block
                                    smoothnessG = pow2(color.r) * 0.5;
                                    highlightMult *= 1.5;
                                    smoothnessD = float(color.r > color.g * 2.0) * 0.3;
                                }
                                else /*if (mat < 10896)*/ { // Iron Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    color.rgb *= 0.9;
                                    if (mat == 10893) { // Powered Iron Door and Iron Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (mat < 10960) {
                    if (mat < 10928) {
                        if (mat < 10900) { // Iron Trapdoor
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                            color.rgb *= 0.9;
                                    if (mat == 10899) { // Powered Iron Door and Iron Trapdoor
                                        redstoneIPBR(color.rgb, emission);
                                    }
                        }
                        else if (mat < 10923) { // Candles:Lit, Candle Cakes:Lit
                            #include "/lib/materials/specificMaterials/terrain/candle.glsl"
                        }
                        else if (mat < 10924) { // Pale Hanging Moss
                            subsurfaceMode = 3, centerShadowBias = true; noSmoothLighting = true;

                            #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                doTileRandomisation = false;
                            #endif

                            float factor = color.g;
                            smoothnessG = factor * 0.5;
                            highlightMult = factor * 4.0 + 2.0;
                            float fresnel = clamp(1.0 + dot(normalM, normalize(viewPos)), 0.0, 1.0);
                            highlightMult *= 1.0 - pow2(pow2(fresnel));

                            sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                        }
                        else /*if (mat < 10928)*/ { //
                            
                        }
                    } else {
                        if (mat < 10944) {
                            if (mat < 10936) {
                                if (mat < 10932) { // Pale Oak Planks++
                                    #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                }
                                else /*if (mat < 10936)*/ { // // Pale Oak Log, Pale Oak Wood
                                    if (color.g > 0.45) { // Pale Oak Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                    } else { // Pale Oak Log:Wood Part, Pale Oak Wood
                                        #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10940) { // Pale Oak Door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/paleOakPlanks.glsl"
                                }
                                else /*if (mat < 10944)*/ { // Resin++
                                    smoothnessG = color.r * 0.25;
                                    smoothnessD = smoothnessG;
                                }
                            }
                        } else {
                            if (mat < 10952) {
                                if (mat < 10948) { // Creaking Heart: Inactive
                                    #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"
                                }
                                else /*if (mat < 10952)*/ { // Creaking Heart: Active
                                    #include "/lib/materials/specificMaterials/terrain/paleOakWood.glsl"

                                    if (color.r + color.g > color.b * 4.0) {
                                        emission = pow2(color.r) * 2.5 + 0.2;
                                    }
                                }
                            } else {
                                if (mat < 10956) { // Snow: Layers 1 to 7
                                    #include "/lib/materials/specificMaterials/terrain/snow.glsl"

                                    #if defined GBUFFERS_TERRAIN && defined TAA
                                        float snowFadeOut = 0.0;
                                        snowFadeOut = clamp01((playerPos.y) * 0.1);
                                        snowFadeOut *= clamp01((lViewPos - 64.0) * 0.01);

                                        if (dither + 0.25 < snowFadeOut) discard;
                                    #endif

                                    overlayNoiseIntensity = 0.0;
                                }
                                else /*if (mat < 10960)*/ { // Target Block: Inactive
                                    smoothnessG = pow2(color.r) * 0.5;
                                    smoothnessD = smoothnessG * 0.5;
                                }
                            }
                        }
                    }
                } else {
                    if (mat < 10992) {
                        if (mat < 10976) {
                            if (mat < 10968) {
                                if (mat < 10964) { // Target Block: Active
                                    smoothnessG = pow2(color.r) * 0.5;
                                    smoothnessD = smoothnessG * 0.5;

                                    if (color.r > color.g + color.b) {
                                        if (CheckForColor(color.rgb, vec3(220, 74, 74))) {
                                            emission = 5.0;
                                            color.rgb *= mix(vec3(1.0), pow2(color.rgb), 0.9);
                                        } else {
                                            emission = 3.0;
                                            color.rgb *= pow2(color.rgb);
                                        }
                                    }
                                }
                                else /*if (mat < 10968)*/ { // Sponge
                                    smoothnessG = pow2(color.g) * 0.2;
                                    smoothnessD = smoothnessG * 0.5;
                                }
                            } else {
                                if (mat < 10972) { // Wet Sponge
                                    smoothnessG = color.g * 0.75;
                                    highlightMult = 0.3;
                                    smoothnessD = smoothnessG * 0.25;
                                }
                                else /*if (mat < 10976)*/ { // Firefly Bush
                                    subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;

                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif

                                    color.rgb *= 1.5;
                                }
                            }
                        } else {
                            if (mat < 10984) {
                                if (mat < 10980) { // Open Eyeblossom
                                    #include "/lib/materials/specificMaterials/terrain/openEyeblossom.glsl"
                                }
                                else /*if (mat < 10984)*/ { //
                                    noSmoothLighting = true;

                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/openEyeblossom.glsl"
                                    }
                                }
                            } else {
                                if (mat < 10988) { //

                                }
                                else /*if (mat < 10992)*/ { //

                                }
                            }
                        }
                    } else {
                        if (mat < 11008) {
                            if (mat < 11000) {
                                if (mat < 10996) { //

                                }
                                else /*if (mat < 11000)*/ { //

                                }
                            } else {
                                if (mat < 11004) { //

                                }
                                else /*if (mat < 11008)*/ { //

                                }
                            }
                        } else {
                            if (mat < 11016) {
                                if (mat < 11012) { //

                                }
                                else /*if (mat < 11016)*/ { //

                                }
                            } else {
                                if (mat < 11020) { //

                                }
                                else /*if (mat < 11024)*/ { //

                                }
                            }
                        }
                    }
                }
            }
        }
    }
} else {
    if (mat < 11112) { // No Properties Blocks
        isFoliage = false;
    } else if (mat > 20999 && mat < 21025) {
    #ifdef GBUFFERS_TERRAIN
        emission = DoAutomaticEmission(noSmoothLighting, noDirectionalShading, color.rgb, lmCoord.x, blockLightEmission, 1.0);
    #else
        bool doesNothing;
        emission = DoAutomaticEmission(noSmoothLighting, doesNothing, color.rgb, 0.0, 15, 1.0);
    #endif
} else if (mat < 13312) {
    if (mat < 12800) {
        if (mat < 12544) {
            if (mat < 12416) {
                if (mat < 12352) {
                    // block.12288 = vigil_candle
                    noSmoothLighting = true;
                    
                    if (
                        CheckForColor(color.rgb, vec3(140, 161, 163)) ||
                        CheckForColor(color.rgb, vec3(116, 137, 145)) ||
                        CheckForColor(color.rgb, vec3(98, 119, 112)) ||
                        CheckForColor(color.rgb, vec3(180, 189, 189))
                    ) {
                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                        if (mat % 2 == 0) lmCoordM.x *= 0.88;
                    } else if (mat % 2 == 0) {
                        vec3 originalColor = color.rgb;
                        emission = 1.2 * max(color.r, max(color.g, color.b));
                        color.rgb *= pow(originalColor, vec3(0.7));
                    
                        #ifdef GBUFFERS_TERRAIN
                            if (abs(NdotU) < 0.1) {
                                lmCoordM.x += 0.2 * (signMidCoordPos.y + 0.5);
                            }
                        #endif
                    }
                    
                    #ifdef SNOWY_WORLD
                        snowFactor = 0.0;
                    #endif
                    
                    overlayNoiseIntensity = 0.3;
                } else /*if (mat < 12416)*/ {
                    if (mat < 12384) {
                        if (mat < 12368) {
                            // block.12352 = corundum_clusters
                            float factor;
                            if (mat % 16 < 8) {
                                factor = color.b;
                            } else if (mat % 8 < 4) {
                                factor = 0.8 * color.g + 0.2 * color.r;
                            } else if (mat % 2 == 0) {
                                factor = color.g;
                            } else {
                                factor = (color.r + color.b + color.g) / 3;
                            }
                            
                            #include "/lib/materials/specificMaterials/terrain/corundumCluster.glsl"
                        } else /*if (mat < 12384)*/ {
                            if (mat < 12376) {
                                if (mat < 12372) {
                                    // block.12368 = black_sand
                                    if (color.g - color.r > 0.06) {
                                        smoothnessG = pow(5.0 * color.r, 8);
                                        smoothnessG = min(smoothnessG, 0.05);
                                        smoothnessD = smoothnessG;
                                    
                                        highlightMult = 2.5;
                                    } else {
                                        smoothnessG = pow2(color.g);
                                    }
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                } else /*if (mat < 12376)*/ {
                                    // block.12372 = black_sand
                                    if (color.g - color.r > 0.06) {
                                        smoothnessG = pow(5.0 * color.r, 8);
                                        smoothnessG = min(smoothnessG, 0.05);
                                        smoothnessD = smoothnessG;
                                    
                                        highlightMult = 2.5;
                                    } else {
                                        smoothnessG = pow2(color.g);
                                    }
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #if RAIN_PUDDLES >= 1 || defined SPOOKY_RAIN_PUDDLE_OVERRIDE
                                        noPuddles = 1.0;
                                    #endif
                                }
                            } else /*if (mat < 12384)*/ {
                                if (mat < 12380) {
                                    // block.12376 = blackstone_bulb
                                    emission = pow2(pow2(color.r));
                                } else /*if (mat < 12384)*/ {
                                    // block.12380 = brimstone
                                    smoothnessG = 0.3 * pow3(color.r);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        }
                    } else /*if (mat < 12416)*/ {
                        if (mat < 12400) {
                            if (mat < 12392) {
                                if (mat < 12388) {
                                    // block.12384 = burning_blossom
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    if (color.r > 0.78 || color.r - color.g > 0.1) {
                                        emission = 5.0 * color.r * color.g;
                                        color.rgb *= color.rgb;
                                        #ifdef GBUFFERS_TERRAIN
                                            lmCoordM.x += 0.5 - 0.7 * pow2(length(signMidCoordPos));
                                            lmCoordM.x = min1(lmCoordM.x);
                                        #endif
                                    }
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                } else /*if (mat < 12392)*/ {
                                    // block.12388 = flesh
                                    const uint voxelNumbers[4] = uint[](356u, 357u, 358u, 359u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    smoothnessG = 1.2 * color.r * (0.8 - color.r);
                                    smoothnessD = smoothnessG;
                                    
                                    if (mat % 4 == 1) {
                                        subsurfaceMode = 1, isFoliage = true;
                                    }
                                }
                            } else /*if (mat < 12400)*/ {
                                if (mat < 12396) {
                                    // block.12392 = glowflower
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    emission = 2.0 * pow2(5.0 * max0(color.r - 0.8));
                                    color.rgb = pow1_5(color.rgb);
                                } else /*if (mat < 12400)*/ {
                                    // block.12396 = glowshroom
                                    if (color.b - color.r > 0.35) {
                                        emission = 2.0 * pow2(color.b);
                                    } else {
                                        lmCoordM.x *= 0.88;
                                    }
                                }
                            }
                        } else /*if (mat < 12416)*/ {
                            if (mat < 12408) {
                                if (mat < 12404) {
                                    // block.12400 = glowworm_silk
                                    emission = 2.0 * pow2(pow2(pow2(color.b))) + color.r;
                                    
                                    if ((mat % 4 == 0 && color.r > 0.5) || (mat % 4 == 2 && color.r > 0.24)) {
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                      + floor(playerPos.y + cameraPosition.y + 0.5);
                                            bpos = bpos * 0.001 + 0.001 * frameTimeCounter;
                                            emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                            emission *= 10.0;
                                        #endif
                                    }
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                } else /*if (mat < 12408)*/ {
                                    // block.12404 = potted_burning_blossom
                                    noSmoothLighting = true;
                                    
                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                        if (color.r > 0.78 || color.r - color.g > 0.1) {
                                            emission = 5.0 * color.r * color.g;
                                            color.rgb *= color.rgb;
                                            #ifdef GBUFFERS_TERRAIN
                                                lmCoordM.x += 0.5 - 0.7 * pow2(length(signMidCoordPos));
                                            #endif
                                        }
                                    }
                                }
                            } else /*if (mat < 12416)*/ {
                                if (mat < 12412) {
                                    // block.12408 = potted_glowflower
                                    noSmoothLighting = true;
                                    
                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                        emission = 2.0 * pow2(5.0 * max0(color.r - 0.8));
                                        color.rgb = pow1_5(color.rgb);
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                } else /*if (mat < 12416)*/ {
                                    // block.12412 = potted_glowshroom
                                    noSmoothLighting = true;
                                    
                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        if (color.b - color.r > 0.35) {
                                            emission = 3.0 * pow2(color.b);
                                        } else {
                                            lmCoordM.x *= 0.88;
                                        }
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 12544)*/ {
                if (mat < 12480) {
                    if (mat < 12448) {
                        if (mat < 12432) {
                            if (mat < 12424) {
                                if (mat < 12420) {
                                    // block.12416 = rose_quartz_block
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = pow2(color.g);
                                    highlightMult = factor * 3.0;
                                    color.rgb *= 0.7 + 0.3 * GetLuminance(color.rgb);
                                    
                                    //#if GLOWING_ALLURITE >= 2
                                    //    emission = dot(color.rgb, color.rgb) * 0.3;
                                    //    overlayNoiseEmission = 0.5;
                                    //#endif
                                    
                                    smoothnessG = 0.8 - factor * 0.3;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                } else /*if (mat < 12424)*/ {
                                    // block.12420 = rose_quartz_cluster
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = pow2(color.b);
                                    smoothnessG = 1.0 - factor * 0.4;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    #if defined GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                        vec3 blockPos = abs(fract(worldPos) - vec3(0.5));
                                        float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                        emission = pow2(max0(1.0 - maxBlockPos * 1.85) * color.b) * 7.0;
                                        color.b *= 1.0 - emission * 0.07;
                                        emission *= 1.3;
                                    
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            } else /*if (mat < 12432)*/ {
                                if (mat < 12428) {
                                    // block.12424 = spider_egg
                                    if (color.r - color.b > 0.2) {
                                        emission = 0.7 * sqrt1(color.r) + 0.3;
                                    }
                                } else /*if (mat < 12432)*/ {
                                    // block.12428 = cupric_candle
                                    #include "/lib/materials/specificMaterials/terrain/candle.glsl"
                                }
                            }
                        } else /*if (mat < 12448)*/ {
                            if (mat < 12440) {
                                if (mat < 12436) {
                                    // block.12432 = ender_candle
                                    #include "/lib/materials/specificMaterials/terrain/candle.glsl"
                                } else /*if (mat < 12440)*/ {
                                    // block.12436 = honeycomb_bricks
                                    smoothnessG = 0.5 * pow3(color.r);
                                    smoothnessD = smoothnessG;
                                    
                                    if (mat % 4 == 2) {
                                        smoothnessG *= 1.3 * sqrt1(color.r);
                                        smoothnessD = smoothnessG;
                                        highlightMult = 2.5;
                                    }
                                }
                            } else /*if (mat < 12448)*/ {
                                if (mat < 12444) {
                                    // block.12440 = ender_candle
                                    #include "/lib/materials/specificMaterials/terrain/candle.glsl"
                                } else /*if (mat < 12448)*/ {
                                    // block.12444 = azalea_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/blueAzaleaPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12480)*/ {
                        if (mat < 12464) {
                            if (mat < 12456) {
                                if (mat < 12452) {
                                    // block.12448 = azalea_log
                                    if (color.b > color.r) { // Azalea Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/blueAzaleaPlanks.glsl"
                                    } else { // Azalea Log:Wood Part, Azalea Wood
                                        smoothnessG = pow2(color.r) * 0.5;
                                        smoothnessD = smoothnessG;
                                    
                                        mossNoiseIntensity = 0.45;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                } else /*if (mat < 12456)*/ {
                                    // block.12452 = azalea_wood
                                    #include "/lib/materials/specificMaterials/planks/blueAzaleaPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else /*if (mat < 12464)*/ {
                                if (mat < 12460) {
                                    // block.12456 = brazier [silver]
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                        float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                        lmCoordM.x *= campfireBrightnessFactor;
                                    #endif
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r - color.b > 0.1 || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 3.5;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    
                                        #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                            float uniformValue = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            float gradient = 0.0;
                                    
                                            #if defined NETHER
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.5 * blockUV.y));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, handUV + 0.4);
                                                #endif
                                            #endif
                                    
                                            #ifdef END
                                                colorFire = colorEndBreath;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.07 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, clamp01(handUV + 0.3 - 1.3 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * handUV)));
                                                #endif
                                            #endif
                                    
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12464)*/ {
                                    // block.12460 = copper_bars / copper_button
                                    #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                    
                                    if (mat % 4 == 1) {
                                        noSmoothLighting = true;
                                    } else if (mat % 4 == 3) {
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else /*if (mat < 12480)*/ {
                            if (mat < 12472) {
                                if (mat < 12468) {
                                    // block.12464 = cupric_brazier [silver]
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                        float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                        lmCoordM.x *= campfireBrightnessFactor;
                                    #endif
                                    
                                    if (color.g - color.r > 0.1 || (color.r > 0.8 && color.g > color.r)) {
                                        noDirectionalShading = true;
                                        emission = 2.60;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12472)*/ {
                                    // block.12468 = cupric_campfire
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                        float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                        lmCoordM.x *= campfireBrightnessFactor;
                                    #endif
                                    
                                    if (color.g - color.r > 0.1 || (color.r > 0.6 && color.g > color.r)) {
                                        noDirectionalShading = true;
                                        emission = 2.50;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                }
                            } else /*if (mat < 12480)*/ {
                                if (mat < 12476) {
                                    // block.12472 = cupric_fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 1.90;
                                    color.rgb = pow1_5(color.rgb);
                                    
                                    overlayNoiseIntensity = 0.0;
                                } else /*if (mat < 12480)*/ {
                                    // block.12476 = cupric_lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523
                                    
                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                    
                                    if (color.g > 0.65) {
                                        emission = 2.5 * pow2(color.g) + 0.5;
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 3.0, lViewPos);
                                    #endif
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        }
                    }
                } else /*if (mat < 12544)*/ {
                    if (mat < 12512) {
                        if (mat < 12496) {
                            if (mat < 12488) {
                                if (mat < 12484) {
                                    // block.12480 = cupric_torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);
                                    
                                    if (color.g - color.r > 0.1 || color.g > 0.7) {
                                        emission = 3.0;
                                        color.rgb = pow1_5(color.rgb);
                                        color.r = min1(color.r + 0.1);
                                    
                                        overlayNoiseIntensity = 0.0;
                                    }
                                    
                                    emission += 0.0001; // No light reducing during noon
                                } else /*if (mat < 12488)*/ {
                                    // block.12484 = lapis_lamp
                                    #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                    if (color.r > 0.5) {
                                        emission = 3.0 * color.r;
                                    }
                                }
                            } else /*if (mat < 12496)*/ {
                                if (mat < 12492) {
                                    // block.12488 = lava_lamp
                                    if (
                                        CheckForColor(color.rgb, vec3(237, 72, 53)) ||
                                        CheckForColor(color.rgb, vec3(253, 227, 117)) ||
                                        CheckForColor(color.rgb, vec3(252, 198, 98)) ||
                                        CheckForColor(color.rgb, vec3(252, 153, 88)) ||
                                        CheckForColor(color.rgb, vec3(251, 106, 62)) ||
                                        CheckForColor(color.rgb, vec3(200, 51, 43))
                                    ) {
                                        #include "/lib/materials/specificMaterials/terrain/lava.glsl"
                                        emission *= 1.5;
                                    } else {
                                        lmCoordM.x *= 0.95;
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        if (mat % 4 == 2) fractPos.zxy = fractPos.xyz;
                                        if (
                                            max(abs(fractPos.x), abs(fractPos.z)) > 0.25 &&
                                            abs(fractPos.y) < 0.45 &&
                                            abs(fractPos.y) > 0.35
                                        ) {
                                            float dist = min(
                                                length(abs(fractPos.xz) - vec2(min(abs(fractPos.x), 0.25), 0.25)),
                                                length(abs(fractPos.xz) - vec2(0.25, min(abs(fractPos.z), 0.25)))
                                            );
                                            lmCoordM.x += 40.0 * (0.45 - abs(fractPos.y)) * pow2(0.25 - dist);
                                        }
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 3.5, lViewPos);
                                    #endif
                                } else /*if (mat < 12496)*/ {
                                    // block.12492 = lava_lamp_2
                                    if (
                                        CheckForColor(color.rgb, vec3(237, 72, 53)) ||
                                        CheckForColor(color.rgb, vec3(253, 227, 117)) ||
                                        CheckForColor(color.rgb, vec3(252, 198, 98)) ||
                                        CheckForColor(color.rgb, vec3(252, 153, 88)) ||
                                        CheckForColor(color.rgb, vec3(251, 106, 62)) ||
                                        CheckForColor(color.rgb, vec3(200, 51, 43))
                                    ) {
                                        #include "/lib/materials/specificMaterials/terrain/lava.glsl"
                                        emission *= 1.5;
                                    } else {
                                        lmCoordM.x *= 0.95;
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        fractPos.xzy = fractPos.xyz;
                                        if (
                                            max(abs(fractPos.x), abs(fractPos.z)) > 0.25 &&
                                            abs(fractPos.y) < 0.45 &&
                                            abs(fractPos.y) > 0.35
                                        ) {
                                            float dist = min(
                                                length(abs(fractPos.xz) - vec2(min(abs(fractPos.x), 0.25), 0.25)),
                                                length(abs(fractPos.xz) - vec2(0.25, min(abs(fractPos.z), 0.25)))
                                            );
                                            lmCoordM.x += 40.0 * (0.45 - abs(fractPos.y)) * pow2(0.25 - dist);
                                        }
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 3.5, lViewPos);
                                    #endif
                                }
                            }
                        } else /*if (mat < 12512)*/ {
                            if (mat < 12504) {
                                if (mat < 12500) {
                                    // block.12496 = necronium
                                    #include "/lib/materials/specificMaterials/terrain/necroniumBlock.glsl"
                                } else /*if (mat < 12504)*/ {
                                    // block.12500 = rocky_dirt
                                    if (abs(color.r - color.b) < 0.02) {
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/dirt.glsl"
                                    }
                                }
                            } else /*if (mat < 12512)*/ {
                                if (mat < 12508) {
                                    // block.12504 = sanguine
                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/terrain/sanguineBlock.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12512)*/ {
                                    // block.12508 = silver_ore
                                    if (abs(color.b - color.r) > 0.05 || color.b > 0.8) {  // Raw Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SILVER_C
                                            emission = 2.0 * pow1_5(color.b) + min(0.6 * color.r, 0.1);
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                        }
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12544)*/ {
                        if (mat < 12528) {
                            if (mat < 12520) {
                                if (mat < 12516) {
                                    // block.12512 = soul_brazier [silver]
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.g - color.r > 0.1 || dotColor > 2.9) {
                                        noDirectionalShading = true;
                                        emission = 2.1;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12520)*/ {
                                    // block.12516 = soul_silver_ore
                                    if (color.b > 0.4) {  // Raw Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SOULSILVER
                                            emission = 2.0 * pow1_5(color.b) + min(0.6 * color.r, 0.1);
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Soul Soil Part
                                        smoothnessG = color.r * 0.4;
                                        smoothnessD = color.r * 0.25;
                                        #if defined GBUFFERS_TERRAIN && defined EMISSIVE_SOUL_SAND
                                            vec3 playerPosM = playerPos + relativeEyePosition;
                                            if (length(playerPosM) < 3.0 && length(playerPosM.y) > 1.1)
                                            if (
                                                color.r < 0.26 && color.r > 0.257 && color.g < 0.2 && color.b < 0.17 && blockUV.y > 0.9999 // A lot of hardcoded stuff
                                                && (
                                                    blockUV.x > 0.625 && blockUV.z < 0.5 && blockUV.z > 0.375
                                                    || blockUV.x < 0.5 && blockUV.x > 0.25 && blockUV.z < 0.1875
                                                    || blockUV.x < 0.375 && blockUV.z > 0.8125
                                                )
                                            ) {
                                                float randomPos = step(0.5, hash13(mod(floor(worldPos + atMidBlock / 64) + frameTimeCounter * 0.0001, vec3(100))));
                                                vec2 flickerNoiseBlock = texture2D(noisetex, vec2(frameTimeCounter * 0.04)).rb;
                                                float noise = mix(1.0, min1(max(flickerNoiseBlock.r, flickerNoiseBlock.g) * 1.7), 0.6) * (clamp(3.0 / length(vec3(playerPosM.x * 1.5, playerPosM.y, playerPosM.z * 1.5)) - 1.0, 0.0, 0.25) * 2.0) * randomPos;
                                                color.rgb = changeColorFunction(color.rgb, 80.0, colorSoul, noise);
                                                emission = 4.0 * noise;
                                                overlayNoiseIntensity = 1.0 - noise;
                                            }
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12528)*/ {
                                if (mat < 12524) {
                                    // block.12520 = spiked_rail
                                    #if ANISOTROPIC_FILTER == 0
                                        color = texture2DLod(tex, texCoord, 0);
                                    #endif
                                    
                                    noSmoothLighting = true;
                                    if (color.r > 0.1 && color.g + color.b < 0.1) { // Redstone Parts
                                        noSmoothLighting = true; noDirectionalShading = true;
                                        lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);
                                    
                                        if (color.r > 0.5) {
                                            color.rgb *= color.rgb;
                                            emission = 8.0 * color.r;
                                    
                                            overlayNoiseIntensity = 0.35, overlayNoiseEmission = 0.2;
                                        } else if (color.r > color.g * 2.0) {
                                            materialMask = OSIEBCA * 5.0; // Redstone Fresnel
                                    
                                            float factor = pow2(color.r);
                                            smoothnessG = 0.4;
                                            highlightMult = factor + 0.4;
                                    
                                            smoothnessD = factor * 0.7 + 0.3;
                                        }
                                    } else if (color.b > color.r) {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    } else if (abs(color.r - color.b) < 0.15) { // Iron Parts
                                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    } else if (color.g > color.b * 2.0) { // Gold Parts
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    } else { // Wood Parts
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                    }
                                } else /*if (mat < 12528)*/ {
                                    // block.12524 = spinel_block
                                    #include "/lib/materials/specificMaterials/terrain/spinelBlock.glsl"
                                }
                            }
                        } else /*if (mat < 12544)*/ {
                            if (mat < 12536) {
                                if (mat < 12532) {
                                    // block.12528 = spinel_lamp
                                    #include "/lib/materials/specificMaterials/terrain/spinelBlock.glsl"
                                    if (color.g > 0.78) {
                                        emission = 3.0 * color.g;
                                    }
                                } else /*if (mat < 12536)*/ {
                                    // block.12532 = spinel_ore
                                    if (color.r - color.g > 0.03) {  // Raw Spinel Part
                                        #include "/lib/materials/specificMaterials/terrain/spinelBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SPINEL
                                            emission = 0.45 * (1.6 * sqrt2(color.r) + 2.2 * pow2(color.r));
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                        }
                                    }
                                }
                            } else /*if (mat < 12544)*/ {
                                if (mat < 12540) {
                                    // block.12536 = sugilite
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = 0.6 * pow2(pow2(color.r + color.b));
                                    highlightMult = factor * 4.0;
                                    color.rgb *= 0.7 + 0.3 * GetLuminance(color.rgb);
                                    
                                    if (mat % 4 >= 2) factor *= 1.5;
                                    
                                    smoothnessG = factor * 0.3;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                } else /*if (mat < 12544)*/ {
                                    // block.12540 = acidian_lantern
                                    if (color.b < 0.4) {  // obsidian part
                                        lmCoordM.x *= 0.88;
                                        #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                    } else {
                                        emission = 2.0 * (0.5 * color.b + color.g);
                                        color.rgb *= pow(color.rgb, vec3(0.1 * emission));
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                    DoDistantLightBokehMaterial(emission, 3.0, lViewPos);
                                    #endif
                                }
                            }
                        }
                    }
                }
            }
        } else /*if (mat < 12800)*/ {
            if (mat < 12672) {
                if (mat < 12608) {
                    if (mat < 12576) {
                        if (mat < 12560) {
                            if (mat < 12552) {
                                if (mat < 12548) {
                                    // block.12544 = ender_brazier [silver]
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                        float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                        lmCoordM.x *= campfireBrightnessFactor;
                                    #endif
                                    
                                    if (
                                        (color.r - color.g > 0.1 && color.b - color.g > 0.1) ||
                                        (color.r > 0.85 && color.b > 0.85 && color.g > 0.85)
                                    ) {
                                        noDirectionalShading = true;
                                        emission = 3.50;
                                        color.rgb *= color.rgb;
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12552)*/ {
                                    // block.12548 = ender_campfire
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                        lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                        float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                        lmCoordM.x *= campfireBrightnessFactor;
                                    #endif
                                    
                                    if (
                                        (color.r - color.g > 0.1 && color.b - color.g > 0.1) ||
                                        (color.r > 0.85 && color.b > 0.85 && color.g > 0.85) ||
                                        CheckForColor(color.rgb, vec3(81, 56, 168))
                                    ) {
                                        noDirectionalShading = true;
                                        emission = 3.50;
                                        color.rgb *= color.rgb;
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                }
                            } else /*if (mat < 12560)*/ {
                                if (mat < 12556) {
                                    // block.12552 = ender_fire
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    emission = 2.35;
                                    color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                    overlayNoiseIntensity = 0.0;
                                } else /*if (mat < 12560)*/ {
                                    // block.12556 = ender_lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523
                                    
                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                    
                                    if (color.b > 0.5) {
                                        emission = 2.5 * pow2(color.b) + 0.5;
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 3.0, lViewPos);
                                    #endif
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        } else /*if (mat < 12576)*/ {
                            if (mat < 12568) {
                                if (mat < 12564) {
                                    // block.12560 = ender_torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);
                                    
                                    if (color.g - color.r > 0.1 || color.b > 0.8) {
                                        emission = 3.0;
                                    
                                        overlayNoiseIntensity = 0.0;
                                    }
                                    #ifdef GBUFFERS_TERRAIN
                                    else if (abs(NdotU) < 0.5) {
                                        #if MC_VERSION >= 12102 // torch model got changed in 1.21.2
                                            lmCoordM.x = min1(0.7 + 0.3 * smoothstep1(max0(0.4 - signMidCoordPos.y)));
                                        #else
                                            lmCoordM.x = min1(0.7 + 0.3 * pow2(1.0 - signMidCoordPos.y));
                                        #endif
                                    }
                                    #else
                                    else {
                                        color.rgb *= 1.5;
                                    }
                                    #endif
                                    
                                    emission += 0.0001; // No light reducing during noon
                                } else /*if (mat < 12568)*/ {
                                    // block.12564 = eumus
                                    if (mat % 4 < 2) {
                                        smoothnessG = color.r * 0.1 + 0.1;
                                        smoothnessD = smoothnessG;
                                        if (color.g > 0.5) {
                                            #include "/lib/materials/specificMaterials/terrain/endstone.glsl"
                                        }
                                    } else {  // bricks
                                        float factor = 1.5 * smoothstep1(clamp01(color.r * 2.5));
                                        smoothnessG = pow2(factor);
                                        smoothnessD = smoothnessG;
                                    
                                        highlightMult = 1.5 * smoothnessG;
                                    }
                                }
                            } else /*if (mat < 12576)*/ {
                                if (mat < 12572) {
                                    // block.12568 = mystical_obsidian
                                    if (color.g > 0.4 && abs(color.r - color.g) < 0.16) {  // endstone
                                        #include "/lib/materials/specificMaterials/terrain/endstone.glsl"
                                    } else {  // obsidian
                                        #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                                    
                                        emission = color.r > 0.5 ? 2.7 * sqrt(color.r) : 0.0;
                                    
                                        overlayNoiseIntensity = 0.65;
                                        overlayNoiseEmission = 0.6;
                                    }
                                } else /*if (mat < 12576)*/ {
                                    // block.12572 = poise_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/poisePlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12608)*/ {
                        if (mat < 12592) {
                            if (mat < 12584) {
                                if (mat < 12580) {
                                    // block.12576 = poise_stem
                                    #include "/lib/materials/specificMaterials/planks/poisePlanks.glsl"
                                    
                                    if (mat % 4 == 2) {
                                        if (color.r < 0.4 || CheckForColor(color.rgb, vec3(124, 67, 125))) {
                                            lmCoordM.x *= 0.88;
                                        } else {
                                            emission = 2.0 * pow2(min1(color.r * 1.8));
                                            color.rgb *= pow(color.rgb, vec3(emission * 0.4));
                                        }
                                    }
                                } else /*if (mat < 12584)*/ {
                                    // block.12580 = poise_wood
                                    #include "/lib/materials/specificMaterials/planks/poisePlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else /*if (mat < 12592)*/ {
                                if (mat < 12588) {
                                    // block.12584 = alluring_magnia
                                    if (mat % 4 < 3) {
                                        if (color.b < 0.99) {
                                            #include "/lib/materials/specificMaterials/terrain/alluringMagnia.glsl"
                                        } else {
                                            emission = 2.0 * color.r;
                                            color.rgb *= color.rgb;
                                        }
                                    } else {
                                        float NdotE = dot(normalM, eastVec);
                                        if (abs(abs(NdotE) - 0.5) < 0.4) {
                                            #include "/lib/materials/specificMaterials/terrain/alluringMagnia.glsl"
                                        }
                                    }
                                } else /*if (mat < 12592)*/ {
                                    // block.12588 = blinklamp
                                    smoothnessG = 0.7;
                                    smoothnessD = smoothnessG;
                                    
                                    emission = 2.0 * pow2(pow2(max(color.r, color.b)));
                                    color.rgb *= pow(color.rgb, vec3(0.5 * emission));
                                }
                            }
                        } else /*if (mat < 12608)*/ {
                            if (mat < 12600) {
                                if (mat < 12596) {
                                    // block.12592 = blinklight_vines
                                    const uint voxelNumbers[4] = uint[](185u, -1u, 186u, -1u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    if (mat % 2 == 0 && ((color.r - color.g > 0.05 && color.b - color.r > 0.15) || color.b > 0.83)) {
                                        smoothnessG = 0.7;
                                        smoothnessD = smoothnessG;
                                    
                                        emission = 4.0 * pow2(pow2(min(color.r, color.b)));
                                        color.rgb *= color.rgb;
                                    } else {
                                        subsurfaceMode = 1, noDirectionalShading = true, noSmoothLighting = true;
                                        isFoliage = true;
                                    }
                                } else /*if (mat < 12600)*/ {
                                    // block.12596 = bulb_flower
                                    if (color.r > 0.94) {
                                        emission = 1.3;
                                        color.rgb *= color.rgb;
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        float temp = 0.4 + 0.3 * min1(pow2(max0(1.5 - length(signMidCoordPos - vec2(0.0, -0.5)))));
                                        lmCoordM.x = max(lmCoordM.x, min1(temp));
                                    #endif
                                }
                            } else /*if (mat < 12608)*/ {
                                if (mat < 12604) {
                                    // block.12600 = bulb_lantern
                                    noSmoothLighting = true;
                                    
                                    if (color.b - color.r < 0.1) {
                                        #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                    }
                                    
                                    if (color.g - color.r < 0.05) {
                                        emission = 4.3 * max0(color.r - color.b);
                                        emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 4.7);
                                        color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission)));
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        if (abs(NdotU) < 0.1 && color.g > 0.6) {  // lantern side
                                            float factor = max0(1.4 - length(signMidCoordPos - vec2(0.0, 1.0)));
                                            lmCoordM.x += smoothstep1(0.4 * factor);
                                        } else if (NdotU < -0.9 && color.g > 0.8) {  // lantern base
                                            float factor = max0(1.6 - length(signMidCoordPos));
                                            lmCoordM.x += smoothstep1(factor);
                                        }
                                    #endif
                                } else /*if (mat < 12608)*/ {
                                    // block.12604 = celestial_growth
                                    const uint voxelNumbers[4] = uint[](187u, 187u, 187u, 187u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    #ifdef GLOWING_CELESTIAL_GROWTHS
                                    if (color.r > 0.8)
                                        emission = 0.9 * sqrt(color.r);
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            }
                        }
                    }
                } else /*if (mat < 12672)*/ {
                    if (mat < 12640) {
                        if (mat < 12624) {
                            if (mat < 12616) {
                                if (mat < 12612) {
                                    // block.12608 = chorus_flower
                                    #ifndef NOT_GLOWING_CHORUS_FLOWER
                                        vec3 checkColor = texture2DLod(tex, texCoord, 0).rgb;
                                        if (
                                            CheckForColor(checkColor, vec3(164, 157, 126)) ||
                                            CheckForColor(checkColor, vec3(201, 197, 176)) ||
                                            CheckForColor(checkColor, vec3(226, 221, 188)) ||
                                            CheckForColor(checkColor, vec3(153, 142, 95))
                                        ) {
                                            emission = min(GetLuminance(color.rgb), 0.75) / 0.75;
                                            emission = pow2(pow2(emission)) * 6.5;
                                            color.gb *= 0.85;
                                    
                                            overlayNoiseIntensity = 0.1, overlayNoiseEmission = 0.8;
                                        } else emission = max0(GetLuminance(color.rgb) - 0.5) * 3.0;
                                    #endif
                                } else /*if (mat < 12616)*/ {
                                    // block.12612 = chorus_sprouts
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    #ifndef NOT_GLOWING_CHORUS_FLOWER
                                        if (color.r < color.g * 1.2 || color.r > 0.78) {
                                            emission = 1.2;
                                        }
                                    #endif
                                }
                            } else /*if (mat < 12624)*/ {
                                if (mat < 12620) {
                                    // block.12616 = corrupt_growth
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    emission = color.b > 0.4 ? 0.2 : 0.0;
                                } else /*if (mat < 12624)*/ {
                                    // block.12620 = end_lamp
                                    vec2 coord = floor(signMidCoordPos * 8.0) / 8.0;
                                    emission = 0.6;
                                    color.rgb *= pow2(pow2(color.rgb));
                                    
                                    #ifdef ANIMATED_END_LAMP
                                        float factor = color.b > 0.94 ? 0.5 : 0.0;
                                        color.rgb *= ((1 - factor) + factor * Noise3D(vec3(0.5 * coord, frameTimeCounter * 0.008)));
                                    
                                        lmCoordM.x = max(lmCoordM.x, 1.0);
                                    #endif
                                    
                                    smoothnessG = 1.5 * factor;
                                    smoothnessD = smoothnessG;
                                    highlightMult = 1.0 + 1.5 * factor;
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                }
                            }
                        } else /*if (mat < 12640)*/ {
                            if (mat < 12632) {
                                if (mat < 12628) {
                                    // block.12624 = end_trial_spawner
                                    float maxComponent = max(max(color.r, color.g), color.b);
                                    float minComponent = min(min(color.r, color.g), color.b);
                                    float saturation = (maxComponent - minComponent) / (1.0 - abs(maxComponent + minComponent - 1.0));
                                    
                                    smoothnessG = max0(color.b - pow2(saturation) * 0.5) * 0.5 + 0.1;
                                    smoothnessD = smoothnessG;
                                    
                                    emission = saturation > 0.5 ? 2.5 : 0.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + 0.75 * emission));
                                } else /*if (mat < 12632)*/ {
                                    // block.12628 = mirestone
                                    #include "/lib/materials/specificMaterials/terrain/mirestone.glsl"
                                }
                            } else /*if (mat < 12640)*/ {
                                if (mat < 12636) {
                                    // block.12632 = nebulite_block
                                    #include "/lib/materials/specificMaterials/terrain/nebuliteBlock.glsl"
                                } else /*if (mat < 12640)*/ {
                                    // block.12636 = nebulite_ore
                                    if (color.r > color.g * 1.5) {  // Raw Nebulite Part
                                        #include "/lib/materials/specificMaterials/terrain/nebuliteBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_NEBULITE
                                            emission = 2.0 * sqrt(color.r);
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                    
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Endstone / Mirestone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/endstone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/mirestone.glsl"
                                        }
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12672)*/ {
                        if (mat < 12656) {
                            if (mat < 12648) {
                                if (mat < 12644) {
                                    // block.12640 = potted_blinklight_vines
                                    if (mat % 2 == 0 && ((color.r - color.g > 0.05 && color.b - color.r > 0.15) || color.b > 0.83)) {
                                        smoothnessG = 0.7;
                                        smoothnessD = smoothnessG;
                                    
                                        emission = 4.0 * pow2(pow2(min(color.r, color.b)));
                                        color.rgb *= color.rgb;
                                    } else {
                                        subsurfaceMode = 1, noDirectionalShading = true, noSmoothLighting = true;
                                        isFoliage = true;
                                    }
                                } else /*if (mat < 12648)*/ {
                                    // block.12644 = potted_bulb_flower
                                    float NdotE = dot(normalM, eastVec);
                                    if (abs(abs(NdotE) - 0.5) < 0.4) {
                                        if (color.r > 0.94) {
                                            emission = 1.0;
                                            color.rgb *= color.rgb;
                                        }
                                    
                                        #ifdef GBUFFERS_TERRAIN
                                            float temp = 0.4 + 0.3 * min1(pow2(max0(1.5 - length(signMidCoordPos - vec2(0.0, -0.5)))));
                                            lmCoordM.x = max(lmCoordM.x, min1(temp));
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12656)*/ {
                                if (mat < 12652) {
                                    // block.12648 = potted_celestial_growth
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    #ifdef GLOWING_CELESTIAL_GROWTHS
                                    if (color.r > 0.8)
                                        emission = 0.9 * sqrt(color.r);
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                } else /*if (mat < 12656)*/ {
                                    // block.12652 = chorus_sprouts
                                    subsurfaceMode = 1, noDirectionalShading = true, isFoliage = true;
                                    
                                    #ifndef NOT_GLOWING_CHORUS_FLOWER
                                        if (color.r < color.g * 1.2 || color.r > 0.78) {
                                            emission = 1.2;
                                        }
                                    #endif
                                }
                            }
                        } else /*if (mat < 12672)*/ {
                            if (mat < 12664) {
                                if (mat < 12660) {
                                    // block.12656 = raw_shadoline_block
                                    #include "/lib/materials/specificMaterials/terrain/rawShadolineBlock.glsl"
                                } else /*if (mat < 12664)*/ {
                                    // block.12660 = repulsive_magnia
                                    if (mat % 4 < 3) {
                                        if (color.r < 0.8) {
                                            #include "/lib/materials/specificMaterials/terrain/repulsiveMagnia.glsl"
                                        } else {
                                            emission = 2.5 * color.g;
                                            color.rgb *= color.rgb;
                                        }
                                    } else {
                                        float NdotE = dot(normalM, eastVec);
                                        if (abs(abs(NdotE) - 0.5) < 0.4) {
                                            #include "/lib/materials/specificMaterials/terrain/repulsiveMagnia.glsl"
                                        }
                                    }
                                }
                            } else /*if (mat < 12672)*/ {
                                if (mat < 12668) {
                                    // block.12664 = shadoline_block
                                    #include "/lib/materials/specificMaterials/terrain/shadolineBlock.glsl"
                                } else /*if (mat < 12672)*/ {
                                    // block.12668 = shadoline_ore
                                    if (color.g < 0.42 || CheckForColor(color.rgb, vec3(120, 146, 140))) {  // Raw Shadoline Part
                                        #include "/lib/materials/specificMaterials/terrain/rawShadolineBlock.glsl"
                                    } else {  // Endstone / Mirestone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/endstone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/mirestone.glsl"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 12800)*/ {
                if (mat < 12736) {
                    if (mat < 12704) {
                        if (mat < 12688) {
                            if (mat < 12680) {
                                if (mat < 12676) {
                                    // block.12672 = veradite
                                    smoothnessG = 0.5 * pow2(color.g) + 0.05;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                } else /*if (mat < 12680)*/ {
                                    // block.12676 = wisp_flower
                                    if (color.b > 0.95 && !CheckForColor(color.rgb, vec3(238, 235, 255))) {
                                        emission = 0.8 * (color.b - color.g) + 0.7;
                                        color.rgb = saturateColors(color.rgb, 1.5);
                                    }
                                }
                            } else /*if (mat < 12688)*/ {
                                if (mat < 12684) {
                                    // block.12680 = crates
                                    vec2 absCoord = abs(signMidCoordPos);
                                    if (
                                        (absCoord.x > 0.75 || absCoord.y > 0.75 && NdotU > 0.9) || (
                                            NdotU < 0.1 && NdotU > -0.1 && absCoord.x < 0.75 && (
                                                absCoord.y > 0.75 ||
                                                (signMidCoordPos.y < -0.25 && signMidCoordPos.y > -0.50) ||
                                                (signMidCoordPos.y > 0.0 && signMidCoordPos.y < 0.25) ||
                                                signMidCoordPos.y > 0.50
                                            )
                                        ) || NdotU < -0.9
                                    ) {
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                        if (mat % 4 == 0) lmCoordM.x -= 0.1;
                                    } else {
                                        if (mat % 4 == 0) {
                                            subsurfaceMode = 1;
                                            lmCoordM.x *= 0.875;
                                    
                                            if (color.r > 0.64) {
                                                emission = color.r < 0.75 ? 2.5: 8.0;
                                                color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                            }
                                        } else if (mat % 4 == 2) {
                                            #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                        }
                                    }
                                } else /*if (mat < 12688)*/ {
                                    // block.12684 = food_sack
                                    if (color.r > 0.7 && color.g > 0.7 && color.b > 0.7) {
                                        smoothnessG = pow(color.g, 16.0) * 2.0;
                                        smoothnessD = smoothnessG * 0.7;
                                        highlightMult = 2.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/sack.glsl"
                                    }
                                }
                            }
                        } else /*if (mat < 12704)*/ {
                            if (mat < 12696) {
                                if (mat < 12692) {
                                    // block.12688 = rope
                                    const uint voxelNumbers[4] = uint[](360u, 361u, 362u, 363u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    #include "/lib/materials/specificMaterials/terrain/sack.glsl"
                                } else /*if (mat < 12696)*/ {
                                    // block.12692 = stove
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if (color.r < 0.4 && color.b < 0.4 && color.g < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    } else if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                        emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                        color.r *= 1.0 + 0.1 * emission;
                                    
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        smoothnessG = pow2(color.g);
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12704)*/ {
                                if (mat < 12700) {
                                    // block.12696 = icy_trial_spawner
                                    float maxComponent = max(max(color.r, color.g), color.b);
                                    float minComponent = min(min(color.r, color.g), color.b);
                                    float saturation = (maxComponent - minComponent) / (1.0 - abs(maxComponent + minComponent - 1.0));
                                    
                                    smoothnessG = max0(color.b - pow2(saturation) * 0.5) * 0.5 + 0.1;
                                    smoothnessD = smoothnessG;
                                    
                                    emission = saturation > 0.5 ? 4.5 : 0.0;
                                    color.rgb = pow(color.rgb, vec3(1.0 + 0.3 * emission));
                                } else /*if (mat < 12704)*/ {
                                    // block.12700 = sun_lichen
                                    float maxComponent = max(max(color.r, color.g), color.b);
                                    float minComponent = min(min(color.r, color.g), color.b);
                                    float saturation = (maxComponent - minComponent) / (1.0 - abs(maxComponent + minComponent - 1.0));
                                    
                                    emission = (2.5 * saturation + 0.3) * color.r;
                                    emission *= mix(1.0, 0.1, min1(lViewPos / 96.0));  // fade-off into the distance
                                    color.rgb *= pow(color.rgb, vec3(0.1 + 0.2 * emission) * vec3(1.4, 1.0, 1.0));
                                    
                                    smoothnessG = 0.1;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                }
                            }
                        }
                    } else /*if (mat < 12736)*/ {
                        if (mat < 12720) {
                            if (mat < 12712) {
                                if (mat < 12708) {
                                    // block.12704 = allurite_block
                                    #include "/lib/materials/specificMaterials/terrain/alluriteBlock.glsl"
                                } else /*if (mat < 12712)*/ {
                                    // block.12708 = allurite_cluster
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(0.6 * color.b + 0.4 * color.g);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    #if GLOWING_ALLURITE >= 1 && defined GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                        vec3 blockPos = abs(fract(worldPos) - vec3(0.5));
                                        float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                        emission = pow2(max0(1.0 - maxBlockPos * 1.85) * (0.8 * color.r + 0.2 * color.g)) * 7.0;
                                        color.r *= 1.0 - emission * 0.07;
                                        emission *= 1.3;
                                    
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            } else /*if (mat < 12720)*/ {
                                if (mat < 12716) {
                                    // block.12712 = allurite_lamp
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(0.6 * color.b + 0.4 * color.g);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    emission = pow2(0.8 * color.r + 0.2 * color.g) * 5.5;
                                    color.r *= 1.0 - emission * 0.09;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                } else /*if (mat < 12720)*/ {
                                    // block.12716 = amethyst_lamp
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.r);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    emission = pow2(color.g) * 5.5;
                                    color.g *= 1.0 - emission * 0.09;
                                    overlayNoiseIntensity = 0.5;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                }
                            }
                        } else /*if (mat < 12736)*/ {
                            if (mat < 12728) {
                                if (mat < 12724) {
                                    // block.12720 = chandelier
                                    isFoliage = false;
                                    if (color.r - color.b > 0.35 || color.r < 0.4) {
                                        #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                    } else {
                                        emission = 2.0 * color.r;
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                } else /*if (mat < 12728)*/ {
                                    // block.12724 = combustion_table
                                    if (color.b > 0.8) {  // Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    } else {  // Wood Part
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                    }
                                }
                            } else /*if (mat < 12736)*/ {
                                if (mat < 12732) {
                                    // block.12728 = cured_membrane
                                    smoothnessG = 0.5 * pow3(color.r);
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 12736)*/ {
                                    // block.12732 = deepslate_silver_ore
                                    if (color.b / color.r > 1.2 || CheckForColor(color.rgb, vec3(177, 206, 206))) {  // Raw Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SILVER_G
                                            emission = 0.6 * (sqrt2(color.b) + 1.2 * pow1_5(color.b));
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            }
                        }
                    }
                } else /*if (mat < 12800)*/ {
                    if (mat < 12768) {
                        if (mat < 12752) {
                            if (mat < 12744) {
                                if (mat < 12740) {
                                    // block.12736 = lichen_cordyceps
                                    if (mat % 4 == 1) {
                                        subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;
                                        sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                    } else {
                                        if (color.r > 0.8) {
                                            emission = 1.3 * pow2(color.r);
                                            color.rgb *= pow(color.rgb, vec3(0.3));
                                        } else lmCoordM.x *= 0.92;
                                    }
                                } else /*if (mat < 12744)*/ {
                                    // block.12740 = lichen_moss
                                    if (mat % 4 == 2) lmCoordM.x -= 0.1;
                                    if (color.r > 0.5 && mat % 2 == 0) {
                                        emission = 7.0 * pow2(pow2(color.r));
                                    }
                                    
                                    smoothnessG = 0.10;
                                    smoothnessD = smoothnessG;
                                    
                                    mossNoiseIntensity = 0.8;
                                    
                                    if (mat % 2 == 1) {
                                        subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;
                                        sandNoiseIntensity = 0.8, mossNoiseIntensity = 0.0, isFoliage = true;
                                    }
                                }
                            } else /*if (mat < 12752)*/ {
                                if (mat < 12748) {
                                    // block.12744 = lumiere_block
                                    #include "/lib/materials/specificMaterials/terrain/lumiereBlock.glsl"
                                    
                                    if (mat % 4 == 2) {  // charged lumiere
                                        if (color.r > 0.6 && color.g > 0.6 && color.b > 0.4) {
                                            emission += 1.5 * pow2(color.r) + 0.1;
                                            color.rgb *= color.rgb;
                                        }
                                    }
                                } else /*if (mat < 12752)*/ {
                                    // block.12748 = lumiere_cluster
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(0.8 * color.g + 0.2 * color.r);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    #if GLOWING_LUMIERE >= 1 && defined GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                        vec3 blockPos = abs(fract(worldPos) - vec3(0.5));
                                        float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                        emission = pow2(max0(1.0 - maxBlockPos * 1.85) * color.b) * 7.0;
                                        color.b *= 1.0 - emission * 0.07;
                                        emission *= 1.3;
                                    
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            }
                        } else /*if (mat < 12768)*/ {
                            if (mat < 12760) {
                                if (mat < 12756) {
                                    // block.12752 = lumiere_composter
                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 && NdotU > 0.9) {
                                        #ifdef GLOWING_LUMIERE >= 1
                                            emission = 1.3 * pow2(color.r) + 3.8 * pow2(pow2(color.r));
                                        #endif
                                    
                                        smoothnessG = 3.0;
                                        smoothnessD = smoothnessG;
                                    } else {
                                        #include "/lib/materials/specificMaterials/planks/junglePlanks.glsl"
                                    }
                                } else /*if (mat < 12760)*/ {
                                    // block.12756 = lumiere_lamp
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(0.8 * color.g + 0.2 * color.r);
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    emission = pow2(color.b) * 5.5;
                                    color.b *= 1.0 - emission * 0.09;
                                    overlayNoiseIntensity = 0.5;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                }
                            } else /*if (mat < 12768)*/ {
                                if (mat < 12764) {
                                    // block.12760 = monstrometer
                                    if (mat % 4 == 0) {
                                        vec2 absCoord = abs(signMidCoordPos);
                                        if (color.r / color.b > 2.0 && NdotU > 0.9) {
                                            #include "/lib/materials/specificMaterials/terrain/lumiereBlock.glsl"
                                            float yellow = 0.5 * color.r + 0.5 * color.g;
                                            emission = 2.1 * pow2(yellow) + 0.4;
                                        } else if (
                                            absCoord.x < 0.5 &&
                                            signMidCoordPos.y > -5/8.0 &&
                                            signMidCoordPos.y < 0.25 && NdotU < 0.1
                                        ) {  // Lumiere Part
                                            #include "/lib/materials/specificMaterials/terrain/lumiereBlock.glsl"
                                            float yellow = 0.5 * color.r + 0.5 * color.g;
                                            emission = 2.1 * pow2(yellow) + 0.4;
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                        }
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                } else /*if (mat < 12768)*/ {
                                    // block.12764 = pink_salt
                                    #include "/lib/materials/specificMaterials/terrain/pinkSalt.glsl"
                                }
                            }
                        }
                    } else /*if (mat < 12800)*/ {
                        if (mat < 12784) {
                            if (mat < 12776) {
                                if (mat < 12772) {
                                    // block.12768 = pink_salt_chamber
                                    #include "/lib/materials/specificMaterials/terrain/polishedPinkSalt.glsl"
                                    
                                    vec2 absCoord = abs(signMidCoordPos);
                                    if (absCoord.x < 0.2 && absCoord.y < 0.2 && CheckForColor(color.rgb, vec3(246, 216, 212))) {
                                        emission = 6.0;
                                    }
                                } else /*if (mat < 12776)*/ {
                                    // block.12772 = pink_salt_cluster
                                    #include "/lib/materials/specificMaterials/terrain/pinkSalt.glsl"
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    #if GLOWING_PINK_SALT >= 1
                                        emission = pow2(color.g) * 2.0;
                                        color.g *= 1.0 - emission * 0.07;
                                        emission *= 1.3;
                                    #endif
                                    
                                    smoothnessG = pow2(color.g) * 2.0;
                                    smoothnessD = smoothnessG;
                                    
                                    overlayNoiseIntensity = 0.5;
                                }
                            } else /*if (mat < 12784)*/ {
                                if (mat < 12780) {
                                    // block.12776 = pink_salt_lamp
                                    #include "/lib/materials/specificMaterials/terrain/pinkSalt.glsl"
                                    
                                    emission = 2.1 * pow2(pow2((color.r + color.b + color.g) / 3.0));
                                    
                                    float distance = pow2(signMidCoordPos.x) + pow2(signMidCoordPos.y);
                                    emission /= (1 + 1.2 * sqrt2(distance));
                                    color.rgb *= (1 + 0.3 * color.rgb);
                                    
                                    overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.6;
                                } else /*if (mat < 12784)*/ {
                                    // block.12780 = polished_pink_salt
                                    #include "/lib/materials/specificMaterials/terrain/polishedPinkSalt.glsl"
                                }
                            }
                        } else /*if (mat < 12800)*/ {
                            if (mat < 12792) {
                                if (mat < 12788) {
                                    // block.12784 = raw_silver
                                    #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = 0.6 * (sqrt2(color.b) + 1.2 * pow1_5(color.b));
                                    
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                    
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                } else /*if (mat < 12792)*/ {
                                    // block.12788 = shadow_frame
                                    if (color.b > 0.9) {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    } else {
                                        smoothnessG = 0.5 * pow3(color.r);
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            } else /*if (mat < 12800)*/ {
                                if (mat < 12796) {
                                    // block.12792 = silver
                                    #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    
                                    if (mat % 4 == 3) {  // medium weighted pressure plate
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 12800)*/ {
                                    // block.12796 = silver_lattice
                                    noSmoothLighting = true;
                                    if (color.g > 1.3 * color.b && color.r < 0.5) {
                                        #include "/lib/materials/specificMaterials/terrain/leaves.glsl"
                                    } else if (color.r > 0.5 && color.b < 0.5) {
                                        subsurfaceMode = 1;
                                        lmCoordM.x *= 0.875;
                                    
                                        emission = color.r < 0.75 ? 2.5 : 8.0;
                                        color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                        isFoliage = false;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } else /*if (mat < 13312)*/ {
        if (mat < 13056) {
            if (mat < 12928) {
                if (mat < 12864) {
                    if (mat < 12832) {
                        if (mat < 12816) {
                            if (mat < 12808) {
                                if (mat < 12804) {
                                    // block.12800 = silver_ore
                                    if (color.b / color.r > 1.1) {  // Raw Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SILVER_G
                                            emission = 0.6 * (sqrt2(color.b) + 1.2 * pow1_5(color.b));
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                } else /*if (mat < 12808)*/ {
                                    // block.12804 = warped_anchor
                                    if (
                                        (
                                            CheckForColor(color.rgb, vec3(38, 201, 190)) ||
                                            CheckForColor(color.rgb, vec3(138, 255, 255)) ||
                                            CheckForColor(color.rgb, vec3(36, 246, 216))
                                        ) && NdotU < 0.1
                                    ) {
                                        emission = 4.5;
                                    } else if (color.r / color.b < 0.6 || color.b > 0.9) {  // Allurite Part
                                        emission = 2.5 * pow2(color.b) * sqrt(color.r);
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                        smoothnessD = 0;
                                        smoothnessG = 0;
                                    
                                    } else {  // Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                                    }
                                }
                            } else /*if (mat < 12816)*/ {
                                if (mat < 12812) {
                                    // block.12808 = gelatite
                                    smoothnessG = pow2((color.r + color.b) / 2) * 0.3;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*if (mat < 12816)*/ {
                                    // block.12812 = jelly
                                    smoothnessG = 0.5;
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.5;
                                }
                            }
                        } else /*if (mat < 12832)*/ {
                            if (mat < 12824) {
                                if (mat < 12820) {
                                    // block.12816 = luminous_jelly
                                    smoothnessG = 0.5;
                                    smoothnessD = smoothnessG;
                                    highlightMult = 2.5;
                                    
                                    emission = dot(color.rgb, color.rgb) * 0.3;
                                    color.rgb *= color.rgb;
                                } else /*if (mat < 12824)*/ {
                                    // block.12820 = blackstone_cabinet
                                    if (color.r > color.b * 3.0) { // Gilded Blackstone:Gilded Part
                                        #include "/lib/materials/specificMaterials/terrain/rawGoldBlock.glsl"
                                        #ifdef GLOWING_ORE_GILDEDBLACKSTONE
                                            emission = color.g * 1.5;
                                            emission *= GLOWING_ORE_MULT;
                                    
                                            overlayNoiseIntensity = 0.65, overlayNoiseEmission = 0.6;
                                    
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                            #endif
                                        #endif
                                    } else { // Gilded Blackstone:Blackstone Part
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }
                                }
                            } else /*if (mat < 12832)*/ {
                                if (mat < 12828) {
                                    // block.12824 = nether_stove
                                    lmCoordM.x *= 0.88;
                                    if (color.r - color.b > 0.1) {
                                        if (color.r < 0.28) {  // nether bricks
                                            float factor = smoothstep1(min1(color.r * 1.5));
                                            factor = factor > 0.12 ? factor : factor * 0.5;
                                            smoothnessG = factor;
                                            smoothnessD = factor;
                                        } else {  // fire
                                            float dotColor = dot(color.rgb, color.rgb);
                                            emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                            color.r *= 1.0 + 0.1 * emission;
                                    
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                            #endif
                                            overlayNoiseIntensity = 0.0;
                                        }
                                    } else if (color.b - color.r > 0.1 && color.b > 0.35) {
                                        emission = 1.5;
                                        color.rgb = pow1_5(color.rgb);
                                    } else if (abs(color.r - color.b) < 0.1) {  // blackstone
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }
                                } else /*if (mat < 12832)*/ {
                                    // block.12828 = powdery_cane
                                    bool bloomed = mat % 4 == 2;
                                    #include "/lib/materials/specificMaterials/terrain/powderyCane.glsl"
                                    
                                    if (mat % 4 == 3) {  // cane plants
                                        if (absMidCoordPos.x > 0.005)
                                            subsurfaceMode = 1, noSmoothLighting = true, noDirectionalShading = true;
                                    
                                        sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0, isFoliage = true;
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12864)*/ {
                        if (mat < 12848) {
                            if (mat < 12840) {
                                if (mat < 12836) {
                                    // block.12832 = powdery_torch
                                    bool bloomed = true;
                                    #include "/lib/materials/specificMaterials/terrain/powderyCane.glsl"
                                    
                                    float temp = mat % 4 == 0 ? 1.0 : 1.5;
                                    lmCoordM.x = 0.9 * min1(0.7 + 0.3 * pow2(temp - signMidCoordPos.y - 2.0 * absMidCoordPos.x));
                                } else /*if (mat < 12840)*/ {
                                    // block.12836 = resurgent_soil
                                    if (mat % 4 == 2) lmCoordM.x *= 0.9;
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = color.r * 0.25;
                                    
                                    float factor = color.b / color.r;
                                    if (factor > 1.1) {
                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                      + floor(playerPos.y + cameraPosition.y + 0.5);
                                            bpos = bpos * 0.05 + 0.004 * frameTimeCounter;
                                            emission = 12.0 * pow2(texture2D(noisetex, bpos).r * pow2(texture2D(noisetex, bpos * 0.5).r));
                                            emission *= factor;
                                            emission = min(emission, 5.0);
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12848)*/ {
                                if (mat < 12844) {
                                    // block.12840 = faars
                                    subsurfaceMode = 2, isFoliage = true;
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    
                                    smoothnessG = color.g * 0.35;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*if (mat < 12848)*/ {
                                    // block.12844 = nears
                                    subsurfaceMode = 2, isFoliage = true;
                                    
                                    if (color.b > color.r) {  // purple stem
                                        smoothnessG = 0.2 + 0.4 * color.b;
                                        smoothnessD = smoothnessG;
                                    } else {  // near
                                        #ifdef GLOWING_NEARS
                                            emission = color.r > 0.35 ? 3.0 * pow2(color.r) : 0.0;
                                        #endif
                                    
                                        smoothnessG = 0.4;
                                        smoothnessD = smoothnessG;
                                    }
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            }
                        } else /*if (mat < 12864)*/ {
                            if (mat < 12856) {
                                if (mat < 12852) {
                                    // block.12848 = soul_berry
                                    subsurfaceMode = 1;
                                    
                                    if (color.b - color.r > 0.1) {
                                        emission = 4.5 * (color.b + 0.4);
                                        color.rgb *= color.rgb;
                                        isFoliage = false;
                                    } else {
                                        isFoliage = true;
                                    }
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                } else /*if (mat < 12856)*/ {
                                    // block.12852 = ancient_burning_skull_block
                                    if (
                                        color.r > 3.0 * color.b ||
                                        (color.r > 0.9 && abs(color.g - color.b) < 0.1 && color.r + color.g + color.b < 2.6) ||
                                        CheckForColor(color.rgb, vec3(251, 244, 207))
                                    ) {
                                        emission = 4.00;
                                        color.rgb *= pow(GetLuminance(color.rgb), 0.3);
                                    } else {
                                        lmCoordM.x *= 0.88;
                                    
                                        if (mat % 4 < 2) {
                                            smoothnessG = color.r * 0.2;
                                            smoothnessD = smoothnessG;
                                    
                                            #ifdef GBUFFERS_TERRAIN
                                            DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                            #endif
                                        } else {
                                            smoothnessG = color.r * 2.3;
                                            smoothnessD = smoothnessG;
                                        }
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12864)*/ {
                                if (mat < 12860) {
                                    // block.12856 = ancient_campfire
                                    if (color.r > 3.0 * color.b || (color.r > 0.9 && abs(color.g - color.b) < 0.1)) {
                                        noDirectionalShading = true;
                                        emission = 4.00;
                                        color.rgb *= pow(GetLuminance(color.rgb), 0.3);
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/oakWood.glsl"
                                    }
                                } else /*if (mat < 12864)*/ {
                                    // block.12860 = ancient_candle
                                    noSmoothLighting = true;
                                    
                                    if (mat % 4 == 0)
                                        emission = 1.5 * max0(1.2 * color.b - color.r);
                                    
                                    color.rgb *= 1.0 + 0.7 * pow2(max(-signMidCoordPos.y + 0.8, float(NdotU > 0.9) * 1.6));
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                }
                            }
                        }
                    }
                } else /*if (mat < 12928)*/ {
                    if (mat < 12896) {
                        if (mat < 12880) {
                            if (mat < 12872) {
                                if (mat < 12868) {
                                    // block.12864 = ancient_fire
                                    noDirectionalShading = true;
                                    emission = 4.00;
                                    color.rgb *= pow(GetLuminance(color.rgb), 0.3);
                                    
                                    overlayNoiseIntensity = 0.0;
                                } else /*if (mat < 12872)*/ {
                                    // block.12868 = ancient_lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523
                                    
                                    #include "/lib/materials/specificMaterials/terrain/lanternMetal.glsl"
                                    
                                    if (color.r > 1.7 * color.b) {
                                        emission = 3.0 * pow2(color.r) + 0.5;
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                    #endif
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                }
                            } else /*if (mat < 12880)*/ {
                                if (mat < 12876) {
                                    // block.12872 = ancient_skeleton_skull_candle
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz);
                                        if (fractPos.y < 0.5 && abs(NdotU) < 0.1) {  // side of skull
                                            if (
                                                color.r > 3.0 * color.b ||
                                                (color.r > 0.9 && abs(color.g - color.b) < 0.1 && color.r + color.g + color.b < 2.6) ||
                                                CheckForColor(color.rgb, vec3(251, 244, 207))
                                            ) {
                                                emission = 4.00;
                                                color.rgb *= pow(GetLuminance(color.rgb), 0.3);
                                            }
                                        } else if (fractPos.y > 0.55) {  // candle
                                            color.rgb *= 1.0 + 0.7 * pow2(max(0.6 - signMidCoordPos.y, float(NdotU > 0.9) * 1.6));
                                        }
                                    #endif
                                    
                                    smoothnessG = color.r * 0.2;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif
                                } else /*if (mat < 12880)*/ {
                                    // block.12876 = ancient_torch
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM.x = min(lmCoordM.x * 0.9, 0.77);
                                    
                                    if (
                                        color.r > 3.0 * color.b ||
                                        (color.r > 0.9 && abs(color.g - color.b) < 0.1)
                                    ) {
                                        emission = 3.0;
                                        overlayNoiseIntensity = 0.0;
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        else if (abs(NdotU) < 0.5) {
                                            #if MC_VERSION >= 12102 // torch model got changed in 1.21.2
                                                lmCoordM.x = min1(0.7 + 0.3 * smoothstep1(max0(0.4 - signMidCoordPos.y)));
                                            #else
                                                lmCoordM.x = min1(0.7 + 0.3 * pow2(1.0 - signMidCoordPos.y));
                                            #endif
                                        }
                                    #else
                                        else {
                                            color.rgb *= 1.5;
                                        }
                                    #endif
                                    
                                    emission += 0.0001; // No light reducing during noon
                                }
                            }
                        } else /*if (mat < 12896)*/ {
                            if (mat < 12888) {
                                if (mat < 12884) {
                                    // block.12880 = basaltic_geyser
                                    if (color.r - color.b > 0.1) {
                                        emission = 6.0 * dot(color.rgb, color.rgb);
                                    } else {
                                        smoothnessG = color.r * 0.35;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                        #endif
                                    }
                                    
                                    if (mat % 4 == 0) {
                                        #ifdef GBUFFERS_TERRAIN
                                            vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz) - vec3(0.5);
                                            if (NdotU > 0.9) lmCoordM.x += 0.4 * smoothstep1(max0(1.0 - 2.0 * length(fractPos)));
                                        #endif
                                    }
                                } else /*if (mat < 12888)*/ {
                                    // block.12884 = black_ice
                                    #include "/lib/materials/specificMaterials/terrain/blackIce.glsl"

                                }
                            } else /*if (mat < 12896)*/ {
                                if (mat < 12892) {
                                    // block.12888 = brazier_chest
                                    if (color.r + color.b + color.g > 2.25) {  // bone part
                                        smoothnessG = color.r * 0.2;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef GBUFFERS_TERRAIN
                                            DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                        #endif
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    } else if (mat % 4 == 0 && (color.r > 3.0 * color.b || (color.r > 0.9 && abs(color.g - color.b) < 0.1))) {
                                        noDirectionalShading = true;
                                        emission = 5.00;
                                        color.rgb *= color.rgb;
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/soulSlate.glsl"
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        if (mat % 4 == 0 && NdotU > 0.9) {
                                            lmCoordM.x *= 1.0 + 0.3 * smoothstep1(max0(1.0 - length(signMidCoordPos)));
                                        }
                                    #endif
                                } else /*if (mat < 12896)*/ {
                                    // block.12892 = burning_skull_block
                                    if (color.r > 0.98 || color.r > 1.7 * color.g) {
                                        emission = 3.5;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    } else {
                                        lmCoordM.x *= 0.8;
                                    
                                        if (mat % 4 < 2) {
                                            smoothnessG = color.r * 0.2;
                                            smoothnessD = smoothnessG;
                                    
                                            #ifdef GBUFFERS_TERRAIN
                                                DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                            #endif
                                        } else {
                                            smoothnessG = color.r * 2.3;
                                            smoothnessD = smoothnessG;
                                        }
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12928)*/ {
                        if (mat < 12912) {
                            if (mat < 12904) {
                                if (mat < 12900) {
                                    // block.12896 = cerebrage_skull
                                    if (color.r - color.b > 0.1) {  // cerebrage
                                        #include "/lib/materials/specificMaterials/terrain/cerebrage.glsl"
                                    } else {  // bone
                                        smoothnessG = color.r * 0.2;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef GBUFFERS_TERRAIN
                                            DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                        #endif
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                } else /*if (mat < 12904)*/ {
                                    // block.12900 = claret_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/claretPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else /*if (mat < 12912)*/ {
                                if (mat < 12908) {
                                    // block.12904 = claret_hyphae
                                    if (color.r < color.g * 3.0) { // Cerebrage Claret Stem
                                        #include "/lib/materials/specificMaterials/terrain/cerebrage.glsl"
                                        subsurfaceMode = 0;
                                    } else { // Claret Wood
                                        #include "/lib/materials/specificMaterials/planks/claretPlanks.glsl"
                                    }
                                } else /*if (mat < 12912)*/ {
                                    // block.12908 = claret_wood
                                    #include "/lib/materials/specificMaterials/planks/claretPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else /*if (mat < 12928)*/ {
                            if (mat < 12920) {
                                if (mat < 12916) {
                                    // block.12912 = ecto_soul_sand
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = color.r * 0.25;
                                    
                                    if (color.b > color.r) {
                                        emission = pow1_5(max0(2.0 * color.b - color.r)) + 0.1;
                                        emission *= mix(1.0, 0.0, min1(lViewPos / 64.0));  // fade-off into the distance
                                        color.rgb = pow1_5(color.rgb);
                                    }
                                } else /*if (mat < 12920)*/ {
                                    // block.12916 = ectoplasm
                                    const uint voxelNumbers[4] = uint[](209u, 209u, 209u, 209u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    lmCoordM = vec2(0.0);
                                    
                                    emission = smoothstep1(sqrt1(color.b)) + 0.2;
                                    emission *= 2.0;
                                    
                                    color.rgb *= pow(color.rgb, vec3(0.5 + 0.3 * emission));
                                    
                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 4.5, lViewPos);
                                    #endif
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    
                                    #if ECTOPLASM_EDGE_EFFECT > 0
                                        float easeAmount = 1.5;
                                        vec3 edgeColor = vec3(0.15, 0.6, 0.7) * 3.25;
                                        float edgeEmission = 0.8 + emission * 1.2;
                                        #if ECTOPLASM_EDGE_EFFECT == 2
                                            edgeColor *= 0.08;
                                            edgeEmission = 0.5;
                                            easeAmount = 1.2;
                                        #endif
                                    
                                        #include "/lib/materials/specificMaterials/terrain/fluidEdgeEffect.glsl"
                                    #endif
                                }
                            } else /*if (mat < 12928)*/ {
                                if (mat < 12924) {
                                    // block.12920 = glowcheese
                                    if (color.r > 0.77 && color.r < color.g * 2.0) {
                                        emission = pow2(color.r) + pow2(color.g);
                                    }
                                } else /*if (mat < 12928)*/ {
                                    // block.12924 = nether_wart_beard
                                    subsurfaceMode = 1, isFoliage = true;
                                    
                                    smoothnessG = color.r * 0.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_WART
                                        if (color.r > 0.6) { // Nether Wart Block
                                            overlayNoiseEmission = 0.28;
                                            emission = 16.0 * color.g;
                                            #ifdef GBUFFERS_TERRAIN
                                                vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                          + floor(playerPos.y + cameraPosition.y + 0.5);
                                                bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                emission *= 4.0;
                                            #endif
                                        }
                                    #endif
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 13056)*/ {
                if (mat < 12992) {
                    if (mat < 12960) {
                        if (mat < 12944) {
                            if (mat < 12936) {
                                if (mat < 12932) {
                                    // block.12928 = nether_wart_block
                                    smoothnessG = color.r * 0.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef MOD_NETHEREXP
                                        if (color.r > 0.75) {
                                            emission = 3.0 * color.g;
                                            color.r *= 1.2;
                                            maRecolor = vec3(0.1);
                                        }
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_WART
                                        if (color.r > 0.6) { // Nether Wart Block
                                            overlayNoiseEmission = 0.28;
                                            emission = 16.0 * color.g;
                                            #ifdef GBUFFERS_TERRAIN
                                                vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                          + floor(playerPos.y + cameraPosition.y + 0.5);
                                                bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                emission *= 4.0;
                                            #endif
                                        }
                                    #endif
                                } else /*if (mat < 12936)*/ {
                                    // block.12932 = soul_slate
                                    #include "/lib/materials/specificMaterials/terrain/soulSlate.glsl"
                                    
                                    if (mat % 4 == 2) {
                                        lmCoordM.x *= 0.9;
                                    }
                                }
                            } else /*if (mat < 12944)*/ {
                                if (mat < 12940) {
                                    // block.12936 = rusty_netherite
                                    smoothnessG = pow2(color.r);
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif

                                } else /*if (mat < 12944)*/ {
                                    // block.12940 = rusty_netherite_grate
                                    smoothnessG = pow2(color.r);
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 1.5;
                                    #endif

                                }
                            }
                        } else /*if (mat < 12960)*/ {
                            if (mat < 12952) {
                                if (mat < 12948) {
                                    // block.12944 = shroomnight
                                    noSmoothLighting = true; noDirectionalShading = true;
                                    lmCoordM = vec2(1.0, 0.0);
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    emission = min(pow2(pow2(pow2(pow2(dotColor * 0.5)))), 5.0) * 0.4;
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                } else /*if (mat < 12952)*/ {
                                    // block.12948 = skeleton_skull_candle
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz);
                                        if (fractPos.y < 0.5 && abs(NdotU) < 0.1) {  // side of skull
                                            if (color.r > 0.98 || color.r > 1.7 * color.g) {
                                                emission = 4.0;
                                                color.rgb *= sqrt1(GetLuminance(color.rgb));
                                            }
                                        } else if (fractPos.y > 0.55) {  // candle
                                            color.rgb *= 1.0 + 0.3 * pow2(max(0.5 - signMidCoordPos.y, float(NdotU > 0.9) * 1.6));
                                        }
                                    #endif
                                    
                                    smoothnessG = color.r * 0.2;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif
                                }
                            } else /*if (mat < 12960)*/ {
                                if (mat < 12956) {
                                    // block.12952 = sorrowsquatch
                                    smoothnessG = color.g * 0.05;
                                    smoothnessD = smoothnessG;
                                    
                                    if (mat % 4 == 2 && color.b - color.r > 0.1) {
                                        emission = 2.1;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    }

                                } else /*if (mat < 12960)*/ {
                                    // block.12956 = soul_burning_skull_block
                                    if (color.b - color.r > 0.15 || color.b > 0.98) {
                                        emission = 2.1;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    } else {
                                        lmCoordM.x *= 0.88;
                                    
                                        if (mat % 4 < 2) {
                                            smoothnessG = color.r * 0.2;
                                            smoothnessD = smoothnessG;
                                    
                                            #ifdef GBUFFERS_TERRAIN
                                                DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                            #endif
                                        } else {
                                            smoothnessG = color.r * 2.3;
                                            smoothnessD = smoothnessG;
                                        }
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 12992)*/ {
                        if (mat < 12976) {
                            if (mat < 12968) {
                                if (mat < 12964) {
                                    // block.12960 = soul_candle
                                    noSmoothLighting = true;
                                    
                                    if (mat % 4 == 0)
                                        emission = 1.5 * max0(1.2 * color.b - color.r);
                                    
                                    color.rgb *= 1.0 + 0.7 * pow2(max(-signMidCoordPos.y + 0.8, float(NdotU > 0.9) * 1.6));
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                } else /*if (mat < 12968)*/ {
                                    // block.12964 = soul_magma
                                    smoothnessG = color.r * 0.4;
                                    smoothnessD = color.r * 0.25;
                                    
                                    if (color.b - color.r > 0.1) {
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = 1.3 * dotColor;
                                        color.rgb *= color.rgb;
                                    }
                                }
                            } else /*if (mat < 12976)*/ {
                                if (mat < 12972) {
                                    // block.12968 = soul_skeleton_skull_candle
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz);
                                        if (fractPos.y < 0.5 && abs(NdotU) < 0.1) {  // side of skull
                                            if (color.b - color.r > 0.15 || color.b > 0.98) {
                                                emission = 2.1;
                                                color.rgb *= sqrt1(GetLuminance(color.rgb));
                                            }
                                        } else if (fractPos.y > 0.55) {  // candle
                                            color.rgb *= 1.0 + 0.7 * pow2(max(0.6 - signMidCoordPos.y, float(NdotU > 0.9) * 1.6));
                                        }
                                    #endif
                                    
                                    smoothnessG = color.r * 0.2;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                    #endif
                                } else /*if (mat < 12976)*/ {
                                    // block.12972 = soul_slate
                                    #include "/lib/materials/specificMaterials/terrain/soulSlate.glsl"
                                    
                                    if (mat % 4 == 2) {
                                        lmCoordM.x *= 0.9;
                                    }
                                }
                            }
                        } else /*if (mat < 12992)*/ {
                            if (mat < 12984) {
                                if (mat < 12980) {
                                    // block.12976 = soul_swirls
                                    subsurfaceMode = 1, isFoliage = true;
                                    
                                    if (color.b > color.r) {
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = 0.7 * dotColor;
                                    }
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                } else /*if (mat < 12984)*/ {
                                    // block.12980 = treacherous_candle
                                    if (mat % 4 == 0) {
                                        #ifdef GBUFFERS_TERRAIN
                                            lmCoordM.x += 0.8 * NdotU * max0(0.3 - length(absMidCoordPos));
                                        #endif
                                    }
                                }
                            } else /*if (mat < 12992)*/ {
                                if (mat < 12988) {
                                    // block.12984 = twisting_vines
                                    const uint voxelNumbers[4] = uint[](212u, -1u, 213u, -1u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    noSmoothLighting = true;
                                    
                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif
                                    
                                    if (color.r > color.g) {
                                        emission = 1.5 * color.b;
                                    } else if (color.r > 0.4) {
                                        emission = pow2(color.r);
                                        maRecolor = vec3(0.1);
                                    
                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.501)
                                                      + floor(playerPos.y + cameraPosition.y + 0.501);
                                            bpos = bpos * 0.01 + 0.004 * frameTimeCounter;
                                            emission *= texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r);
                                            emission *= 16.0;
                                        #endif
                                    }
                                    
                                    isFoliage = false;
                                } else /*if (mat < 12992)*/ {
                                    // block.12988 = warped_fungus
                                    noSmoothLighting = true;
                                    
                                    #ifdef MOD_NETHEREXP
                                        if (color.r > 0.73 && color.b > 0.73) {
                                            emission = 1.5 * color.b;
                                    
                                            overlayNoiseIntensity = 0.5;
                                        }
                                    #endif
                                    
                                    if (color.r > 0.91) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);
                                    
                                        overlayNoiseIntensity = 0.5;
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                    isFoliage = false;
                                }
                            }
                        }
                    }
                } else /*if (mat < 13056)*/ {
                    if (mat < 13024) {
                        if (mat < 13008) {
                            if (mat < 13000) {
                                if (mat < 12996) {
                                    // block.12992 = warped_wart_beard
                                    subsurfaceMode = 1;
                                    
                                    smoothnessG = color.g * 0.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_WART
                                        if (color.g > 0.7) { // Warped Wart Block
                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                            emission = 2.4;
                                            #ifdef GBUFFERS_TERRAIN
                                                vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                          + floor(playerPos.y + cameraPosition.y + 0.5);
                                                bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                emission *= 4.0;
                                            #endif
                                        }
                                    #endif
                                } else /*if (mat < 13000)*/ {
                                    // block.12996 = warped_wart_block
                                    smoothnessG = color.g * 0.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef MOD_NETHEREXP
                                        if (color.r > 0.7) {
                                            emission = 1.5 * color.b;
                                            overlayNoiseIntensity = 0.5;
                                        }
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_WART
                                        if (color.g > 0.7) { // Warped Wart Block
                                            overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                            emission = 2.4;
                                            #ifdef GBUFFERS_TERRAIN
                                                vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                          + floor(playerPos.y + cameraPosition.y + 0.5);
                                                bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                                emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                                emission *= 4.0;
                                            #endif
                                        }
                                    #endif
                                }
                            } else /*if (mat < 13008)*/ {
                                if (mat < 13004) {
                                    // block.13000 = weeping_vines
                                    const uint voxelNumbers[4] = uint[](65u, 65u, 65u, 65u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                        doTileRandomisation = false;
                                    #endif
                                    
                                    if (color.r > 0.91) {
                                        emission = 3.0 * color.g;
                                        color.r *= 1.2;
                                        maRecolor = vec3(0.1);
                                    }
                                    
                                    isFoliage = false;
                                } else /*if (mat < 13008)*/ {
                                    // block.13004 = electrum
                                    #include "/lib/materials/specificMaterials/terrain/electrumBlock.glsl"
                                }
                            }
                        } else /*if (mat < 13024)*/ {
                            if (mat < 13016) {
                                if (mat < 13012) {
                                    // block.13008 = glance
                                    smoothnessG = pow2(pow2(color.b)) * 3.0;
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 13016)*/ {
                                    // block.13012 = goopy_lead
                                    float emissiveness = 3.5;
                                    #include "/lib/materials/specificMaterials/terrain/moltenLead.glsl"
                                }
                            } else /*if (mat < 13024)*/ {
                                if (mat < 13020) {
                                    // block.13016 = lead
                                    #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                                    
                                    if (mat % 4 == 2) {
                                        smoothnessG *= 0.5;
                                        smoothnessD *= 0.5;
                                    
                                        emission = GetLuminance(color.rgb) * 3.0;
                                        emission += pow2(color.b) * 0.7;
                                    }

                                } else /*if (mat < 13024)*/ {
                                    // block.13020 = lead_bolt_crate
                                    if (color.r > color.b) {
                                        #include "/lib/materials/specificMaterials/planks/birchPlanks.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 13056)*/ {
                        if (mat < 13040) {
                            if (mat < 13032) {
                                if (mat < 13028) {
                                    // block.13024 = lead_bulb
                                    #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                                    lmCoordM.x *= 0.85;
                                    
                                    if (color.b > 0.4) {
                                        lmCoordM.x = 1.0;
                                        emission = (pow1_5(color.b) - 0.3 * color.b) * 2.0 + 1.0;
                                        color.rgb *= color.rgb;
                                        color.r *= 1.2;
                                    }
                                } else /*if (mat < 13032)*/ {
                                    // block.13028 = lead_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                                    
                                    if (mat % 2 == 0) {
                                        if (mat % 4 == 0) {
                                            smoothnessG *= 0.5;
                                            smoothnessD *= 0.5;
                                    
                                            emission = GetLuminance(color.rgb) * 3.0;
                                            emission += pow2(color.b) * 0.7 + 0.1;
                                        } else {
                                            smoothnessG = 0.0;
                                            smoothnessD = 0.0;
                                    
                                            float emissiveness = 6.0;
                                            #include "/lib/materials/specificMaterials/terrain/moltenLead.glsl"
                                    
                                            color.rgb *= 1.1 - 0.1 * GetLuminance(color.rgb);
                                        }
                                    }
                                }
                            } else /*if (mat < 13040)*/ {
                                if (mat < 13036) {
                                    // block.13032 = lead_ore
                                    if (abs(color.b - color.r) > 0.04) {  // Raw Lead Part
                                        #include "/lib/materials/specificMaterials/terrain/rawLeadBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_LEAD
                                            emission = 3.0 * sqrt2(max(color.r, color.b));
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                        }
                                    }
                                } else /*if (mat < 13040)*/ {
                                    // block.13036 = molten_lead
                                    const uint voxelNumbers[4] = uint[](216u, 216u, 216u, 216u);
                                    uint voxelNumber = voxelNumbers[mat % 4];
                                    float emissiveness = 5.0;
                                    #include "/lib/materials/specificMaterials/terrain/moltenLead.glsl"
                                    
                                    #if MOLTEN_LEAD_EDGE_EFFECT > 0
                                        float easeAmount = 1.5;
                                        vec3 edgeColor = vec3(0.45, 0.5, 0.8) * 2.1;
                                        float edgeEmission = 1.0 + emission * 1.1;
                                        #if MOLTEN_LEAD_EDGE_EFFECT == 2
                                            edgeColor = vec3(0.18, 0.2, 0.3);
                                            edgeEmission = 0.0;
                                            easeAmount = 1.2;
                                        #endif
                                    
                                        #include "/lib/materials/specificMaterials/terrain/fluidEdgeEffect.glsl"
                                    #endif
                                }
                            }
                        } else /*if (mat < 13056)*/ {
                            if (mat < 13048) {
                                if (mat < 13044) {
                                    // block.13040 = molten_lead_cauldron
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.9333);
                                    
                                    vec3 worldPos = playerPos + cameraPosition;
                                    vec3 fractPos = fract(worldPos.xyz);
                                    vec2 coordM = abs(fractPos.xz - 0.5);
                                    if (max(coordM.x, coordM.y) < 0.375 && fractPos.y > 0.3 && NdotU > 0.9) {
                                        float emissiveness = 5.0;
                                        #include "/lib/materials/specificMaterials/terrain/moltenLead.glsl"
                                    
                                        sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/anvil.glsl"
                                    }
                                } else /*if (mat < 13048)*/ {
                                    // block.13044 = polished_glance
                                    smoothnessG = pow2(color.b);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                }
                            } else /*if (mat < 13056)*/ {
                                if (mat < 13052) {
                                    // block.13048 = raw_lead
                                    #include "/lib/materials/specificMaterials/terrain/rawLeadBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = 3.0 * sqrt2(max(color.r, color.b));
                                    
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                } else /*if (mat < 13056)*/ {
                                    // block.13052 = raw_silver
                                    #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = 2.0 * pow1_5(color.b);
                                    
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                    
                                        emission *= GLOWING_ORE_MULT;
                                    #endif
                                }
                            }
                        }
                    }
                }
            }
        } else /*if (mat < 13312)*/ {
            if (mat < 13184) {
                if (mat < 13120) {
                    if (mat < 13088) {
                        if (mat < 13072) {
                            if (mat < 13064) {
                                if (mat < 13060) {
                                    // block.13056 = silver_ore
                                    if (color.b - color.r > 0.05 || color.b > 0.8) {  // Raw Silver Part
                                        #include "/lib/materials/specificMaterials/terrain/rawSilverBlock.glsl"
                                    
                                        #ifdef GLOWING_ORE_SILVER_O
                                            emission = 2.0 * pow1_5(color.b);
                                    
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                            #ifdef SITUATIONAL_ORES
                                                emission *= skyLightCheck;
                                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                            #else
                                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                            #endif
                                            emission *= GLOWING_ORE_MULT;
                                        #endif
                                    } else {  // Stone Part
                                        if (mat % 4 == 0) {
                                            #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                        } else {
                                            #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                        }
                                    }
                                } else /*if (mat < 13064)*/ {
                                    // block.13060 = lampear
                                    if (mat % 4 == 0) {  // lampear
                                        #include "/lib/materials/specificMaterials/terrain/lampearBlock.glsl"
                                    } else {  // copper lampear
                                        #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                    
                                        emission = pow2(color.g) * 2.5 + 0.2;
                                    }
                                    
                                    #ifdef GBUFFERS_TERRAIN
                                        vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz);
                                        float r = length(fractPos - vec3(0.5, 0.3, 0.5));
                                        emission *= pow2(max0(1.7 - 2.4 * r) * color.b) * (mat % 4 == 0 ? 10.0 : 13.0);
                                        color.b *= 1 - 0.1 * emission;
                                    #endif
                                }
                            } else /*if (mat < 13072)*/ {
                                if (mat < 13068) {
                                    // block.13064 = lampear_block
                                    #include "/lib/materials/specificMaterials/terrain/lampearBlock.glsl"
                                    
                                    emission *= 0.7;
                                    color.rgb *= sqrt(color.rgb);
                                } else /*if (mat < 13072)*/ {
                                    // block.13068 = pigsteel
                                    #include "/lib/materials/specificMaterials/terrain/pigsteel.glsl"
                                }
                            }
                        } else /*if (mat < 13088)*/ {
                            if (mat < 13080) {
                                if (mat < 13076) {
                                    // block.13072 = pigsteel_chunks
                                    smoothnessG = 1.2 * color.r;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_RAW_BLOCKS
                                        emission = 3.5 * pow2(color.r);
                                    
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif

                                } else /*if (mat < 13080)*/ {
                                    // block.13076 = pigsteel_lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = 0.77;
                                    
                                    #include "/lib/materials/specificMaterials/terrain/pigsteel.glsl"
                                    
                                    if (color.r - color.b > 0.3 || color.r > 0.9) {
                                        emission = 4.3 * max0(color.r - color.b);
                                        emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                        color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.0;
                                    
                                    #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                        if (color.g > color.b) {
                                            float uniformValue = 1.0;
                                            float gradient = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            #if defined NETHER
                                                #ifdef GBUFFERS_TERRAIN
                                                    float lanternOffset = 0.0;
                                                    if (mat == 10562) lanternOffset = 0.1; // Hanging Lantern
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y - lanternOffset + 3.0 * blockUV.y - lanternOffset));
                                                #else
                                                    gradient = 0.0;
                                                #endif
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                            #endif
                                            #ifdef END
                                                colorFire = colorEndBreath;
                                            #endif
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        }
                                    #endif
                                }
                            } else /*if (mat < 13088)*/ {
                                if (mat < 13084) {
                                    // block.13080 = pigsteel_soul_lantern
                                    noSmoothLighting = true;
                                    lmCoordM.x = min(lmCoordM.x, 0.77); // consistency748523
                                    
                                    #include "/lib/materials/specificMaterials/terrain/pigsteel.glsl"
                                    
                                    if (color.b - color.r > 0.3 || color.b > 0.9) {
                                        emission = 1.45 * max0(color.g - color.r * 2.0);
                                        emission += 1.17 * min(pow2(pow2(0.55 * dot(color.rgb, color.rgb))), 3.5);
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(0.5, 1.0, 1.0, 1.0), emission, 3.0, lViewPos);
                                    #endif
                                    
                                    #ifdef SNOWY_WORLD
                                        snowFactor = 0.0;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.3;
                                } else /*if (mat < 13088)*/ {
                                    // block.13084 = porkslag
                                    smoothnessG = 1.2 * color.r;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_PORKSLAG
                                        emission = 3.5 * pow2(color.r);
                                    
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        #ifdef SITUATIONAL_ORES
                                            emission *= skyLightCheck;
                                            color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT))), skyLightCheck);
                                        #else
                                            color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORE_MULT)));
                                        #endif
                                        emission *= GLOWING_ORE_MULT;
                                    #endif

                                }
                            }
                        }
                    } else /*if (mat < 13120)*/ {
                        if (mat < 13104) {
                            if (mat < 13096) {
                                if (mat < 13092) {
                                    // block.13088 = ashen_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/ashenPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13096)*/ {
                                    // block.13092 = ashen_log
                                    if (color.r > 0.8 && color.b > 0.8 && color.g > 0.8) { // Ashen Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/ashenPlanks.glsl"
                                    } else { // Ashen Log:Wood Part, Ashen Wood
                                        smoothnessG = pow2(color.r) * 0.1;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 1.25;
                                        #endif
                                    }
                                }
                            } else /*if (mat < 13104)*/ {
                                if (mat < 13100) {
                                    // block.13096 = ashen_wood
                                    #include "/lib/materials/specificMaterials/planks/ashenPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13104)*/ {
                                    // block.13100 = azalea_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/azaleaPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        } else /*if (mat < 13120)*/ {
                            if (mat < 13112) {
                                if (mat < 13108) {
                                    // block.13104 = azalea_log
                                    if (color.g < 0.8) { // Azalea Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/azaleaPlanks.glsl"
                                    } else { // Azalea Log:Wood Part, Azalea Wood
                                        smoothnessG = pow2(color.r) * 0.1;
                                        smoothnessD = smoothnessG;
                                    
                                        mossNoiseIntensity = 0.45;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                } else /*if (mat < 13112)*/ {
                                    // block.13108 = azalea_wood
                                    #include "/lib/materials/specificMaterials/planks/azaleaPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else /*if (mat < 13120)*/ {
                                if (mat < 13116) {
                                    // block.13112 = blackstone_furnace
                                    #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    if (mat % 4 == 0) {
                                        lmCoordM.x *= 0.98;
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                        color.r *= 1.0 + 0.1 * emission;
                                    
                                        if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                            #endif
                                            overlayNoiseIntensity = 0.0;
                                        }
                                    } else if (mat % 4 == 2) {
                                        lmCoordM.x *= 0.98;
                                    
                                        emission = 1.5;
                                        color.rgb = pow1_5(color.rgb);
                                    }
                                } else /*if (mat < 13120)*/ {
                                    // block.13116 = blaze_lantern
                                    noSmoothLighting = true, noDirectionalShading = true;
                                    lmCoordM.x = 0.85;
                                    
                                    smoothnessD = min1(max0(0.5 - color.b) * 2.0);
                                    smoothnessG = color.b;
                                    
                                    float blockRes = absMidCoordPos.x * atlasSize.x;
                                    vec2 signMidCoordPosM = (floor((signMidCoordPos + 1.0) * blockRes) + 0.5) / blockRes - 1.0;
                                    float dotsignMidCoordPos = dot(signMidCoordPosM, signMidCoordPosM);
                                    float lBlockPosM = pow2(max0(1.0 - 1.7 * pow2(pow2(dotsignMidCoordPos))));
                                    emission = pow2(color.r) * 1.6 + 2.2 * lBlockPosM;
                                    emission *= 0.4 + max0(0.6 - 0.006 * lViewPos);
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                    
                                    overlayNoiseIntensity = 0.5;
                                }
                            }
                        }
                    }
                } else /*if (mat < 13184)*/ {
                    if (mat < 13152) {
                        if (mat < 13136) {
                            if (mat < 13128) {
                                if (mat < 13124) {
                                    // block.13120 = blue_nether_bricks
                                    float factor = color.b * 0.8;
                                    factor = color.b > 0.3 ? factor : factor * 0.25;
                                    smoothnessG = factor;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*if (mat < 13128)*/ {
                                    // block.13124 = white_corundum_cluster
                                    float factor = (color.r + color.g + color.b) / 2;
                                    
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    smoothnessG = 0.8 - factor * 0.3;
                                    highlightMult = factor * 3.0;
                                    smoothnessD = factor;
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.88;
                                    
                                    #if GLOWING_AMETHYST >= 1 && defined GBUFFERS_TERRAIN
                                        vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                        vec3 blockPos = abs(fract(worldPos) - vec3(0.65, 0.7, 0.4));
                                        float maxBlockPos = max(blockPos.x, max(blockPos.y, blockPos.z));
                                        emission = pow2(max0(1.0 - pow1_5(maxBlockPos) * 2.60) * pow2(pow2(min(color.r, min(color.g, color.b))))) * 6.0;
                                        if (color.r < color.b && color.r < color.g) {
                                            color.r *= 1.0 - emission * 0.07;
                                        } else if (color.g < color.r && color.g < color.b) {
                                            color.g *= 1.0 - emission * 0.07;
                                        } else {
                                            color.b *= 1.0 - emission * 0.07;
                                        }
                                    
                                        emission *= 1.3;
                                    
                                        overlayNoiseIntensity = 0.5;
                                    #endif
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                }
                            } else /*if (mat < 13136)*/ {
                                if (mat < 13132) {
                                    // block.13128 = deepslate_furnace
                                    #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    if (mat % 4 == 1) {
                                        lmCoordM.x *= 0.95;
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = 2.5 * dotColor * max0(pow2(pow2(pow2(color.r))) - color.b) + pow(dotColor * 0.35, 32.0);
                                        color.r *= 1.0 + 0.1 * emission;
                                    
                                        if (color.r > color.b * 2.0 && dotColor > 0.7) {
                                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                                            #endif
                                            #ifdef PURPLE_END_FIRE_INTERNAL
                                                color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                            #endif
                                            overlayNoiseIntensity = 0.0;
                                        }
                                    }
                                } else /*if (mat < 13136)*/ {
                                    // block.13132 = duskbound_lantern
                                    highlightMult = 2.0;
                                    smoothnessG = pow2(pow2(color.b));
                                    smoothnessD = smoothnessG;
                                    
                                    if (mat % 4 == 2) {
                                        if (color.b > 1.7 * color.r) {
                                            emission = 7.0 - 4.0 * pow2(color.b);
                                            #ifdef DISTANT_LIGHT_BOKEH
                                                DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                            #endif
                                        } else {
                                            lmCoordM.x -= 0.1;
                                        }
                                    }
                                }
                            }
                        } else /*if (mat < 13152)*/ {
                            if (mat < 13144) {
                                if (mat < 13140) {
                                    // block.13136 = ender_watcher
                                    // TODO improve ender watcher shader
                                    if (color.r > 0.5 && color.b < 0.3) {  // Redstone
                                        emission = 1.0;
                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"
                                    } else if (color.b > 0.5) {  // Eye of Ender
                                        smoothnessG = 1.0;
                                        highlightMult = 2.0;
                                        smoothnessD = 1.0;
                                    }
                                } else /*if (mat < 13144)*/ {
                                    // block.13140 = glow_shroom
                                    noSmoothLighting = true;
                                    
                                    if (color.g > color.b + 0.035 && color.g > 0.72) {
                                        emission = 1.25 * pow2(pow2(color.g)) + 0.3 * pow2(color.b);
                                    } else {
                                        sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0;
                                    }

                                }
                            } else /*if (mat < 13152)*/ {
                                if (mat < 13148) {
                                    // block.13144 = glowberry_sack
                                    vec2 absCoord = abs(signMidCoordPos);
                                    if (NdotU > 0.9 && (absCoord.x < 0.875 && absCoord.y < 0.875)) {
                                        subsurfaceMode = 1;
                                        lmCoordM.x *= 0.875;
                                    
                                        if (color.r > 0.64) {
                                            emission = color.r < 0.75 ? 1.0: 3.0;
                                            color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                        }
                                    } else {
                                        lmCoordM.x -= 0.15;
                                        #include "/lib/materials/specificMaterials/terrain/sack.glsl"
                                    }
                                } else /*if (mat < 13152)*/ {
                                    // block.13148 = gold_bars
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                }
                            }
                        }
                    } else /*if (mat < 13184)*/ {
                        if (mat < 13168) {
                            if (mat < 13160) {
                                if (mat < 13156) {
                                    // block.13152 = jasper
                                    smoothnessG = min(pow2(pow2(color.r)) * 2.0, 0.8);
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 13160)*/ {
                                    // block.13156 = magnet
                                    if (color.r - color.g > 0.2 || color.b - color.g > 0.2) {
                                        if (mat % 4 == 2) {
                                            emission = 3.0 * pow2(abs(color.r - color.b)) + 1.0;
                                            color.rgb *= color.rgb;
                                        }
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                }
                            } else /*if (mat < 13168)*/ {
                                if (mat < 13164) {
                                    // block.13160 = midori_block
                                    if (mat % 4 == 2) lmCoordM.x -= 0.15;
                                    
                                    highlightMult = 2.0;
                                    smoothnessG = pow3(color.g) + 0.2 * color.g;
                                    smoothnessD = smoothnessG;
                                    
                                    mossNoiseIntensity = 0.3, sandNoiseIntensity = 0.3;
                                    
                                    if (color.r > color.g) {
                                        emission = 2.5;
                                    }

                                } else /*if (mat < 13168)*/ {
                                    // block.13164 = myalite
                                    vec2 num = (playerPos.xz + cameraPosition.xz) + (playerPos.y + cameraPosition.y);
                                    vec2 noise = texture2D(noisetex, num / 128.0).rb;
                                    
                                    smoothnessG = 0.5 * pow2(color.b) * (0.4 + (pow2(sin(noise.r) + cos(noise.g))));
                                    smoothnessD = smoothnessG;
                                    highlightMult = 3.0 * pow2(pow2(color.r)) * smoothnessG;

                                }
                            }
                        } else /*if (mat < 13184)*/ {
                            if (mat < 13176) {
                                if (mat < 13172) {
                                    // block.13168 = polished_jasper
                                    smoothnessG = min(pow3(color.r) * 2.5, 1.0);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                } else /*if (mat < 13176)*/ {
                                    // block.13172 = polished_shale
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = pow2(color.b);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.3 - 0.7 * factor;
                                    highlightMult = factor2 * 3.0;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.20;
                                    #endif
                                }
                            } else /*if (mat < 13184)*/ {
                                if (mat < 13180) {
                                    // block.13176 = quark_potted_plants
                                    noSmoothLighting = true;
                                    
                                    vec3 worldPos = playerPos + cameraPosition;
                                    float fractPos = fract(worldPos.y);
                                    if (fractPos > 0.375) {
                                        subsurfaceMode = 1, noDirectionalShading = true;
                                    
                                        if (mat % 4 == 0) {  // glow berries
                                            lmCoordM.x *= 0.875;
                                    
                                            if (color.r > 0.64) {
                                                emission = color.r < 0.75 ? 2.5 : 8.0;
                                                color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                                                isFoliage = false;
                                            } else {
                                                isFoliage = true;
                                            }
                                        } else if (mat % 4 == 2) {  // glow lichen
                                            float dotColor = dot(color.rgb, color.rgb);
                                            emission = min(pow2(pow2(dotColor) * dotColor) * 1.4 + dotColor * 0.9, 6.0);
                                    
                                            color.r *= 1.15;
                                        }
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                } else /*if (mat < 13184)*/ {
                                    // block.13180 = quark_potted_plants_2
                                    noSmoothLighting = true;
                                    
                                    vec3 worldPos = playerPos + cameraPosition;
                                    float fractPos = fract(worldPos.y);
                                    if (fractPos > 0.375) {
                                        subsurfaceMode = 1, noDirectionalShading = true;
                                    
                                        if (mat % 4 == 0) {  // sea pickle
                                            if (color.b > 0.5) { // Sea Pickle:Emissive Part
                                                color.g *= 1.1;
                                                emission = 5.0;
                                            }
                                        } else if (mat % 4 == 2) {  // weeping vines
                                            #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                                doTileRandomisation = false;
                                            #endif
                                    
                                            if (color.r > 0.91) {
                                                emission = 3.0 * color.g;
                                                color.r *= 1.2;
                                                maRecolor = vec3(0.1);
                                            }
                                    
                                            isFoliage = false;
                                        }
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 13312)*/ {
                if (mat < 13248) {
                    if (mat < 13216) {
                        if (mat < 13200) {
                            if (mat < 13192) {
                                if (mat < 13188) {
                                    // block.13184 = quark_potted_plants_3
                                    noSmoothLighting = true;
                                    
                                    vec3 worldPos = playerPos + cameraPosition;
                                    float fractPos = fract(worldPos.y);
                                    if (fractPos > 0.375) {
                                        subsurfaceMode = 1, noDirectionalShading = true;
                                    
                                        if (mat % 4 == 0) {  // glow shroom
                                            if (color.g > color.b + 0.035 && color.g > 0.72) {
                                                emission = 1.25 * pow2(pow2(color.g)) + 0.3 * pow2(color.b);
                                            }
                                        }
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;

                                } else /*if (mat < 13192)*/ {
                                    // block.13188 = quark_stone_lamp
                                    if (color.r > 0.85) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 1.0;
                                        emission = GetLuminance(color.rgb) * 3.2;
                                    
                                        color.r *= 1.4;
                                        color.b *= 0.5;
                                        overlayNoiseIntensity = 0.0;
                                    
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            if (color.g > 0.999) color.rgb = changeColorFunction(color.rgb, 1.5, colorSoul, inSoulValley);
                                        #endif
                                        #ifdef PURPLE_END_FIRE_INTERNAL
                                            if (color.g > 0.5) color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                                        #endif
                                    } else {
                                        lmCoordM.x -= 0.13;
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                    
                                    #ifdef DISTANT_LIGHT_BOKEH
                                        DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                    #endif
                                }
                            } else /*if (mat < 13200)*/ {
                                if (mat < 13196) {
                                    // block.13192 = redstone_randomizer
                                    #if ANISOTROPIC_FILTER > 0
                                        color = texture2D(tex, texCoord); // Fixes artifacts
                                        color.rgb *= glColor.rgb;
                                    #endif
                                    
                                    vec3 absDif = abs(vec3(color.r - color.g, color.g - color.b, color.r - color.b));
                                    float maxDif = max(absDif.r, max(absDif.g, absDif.b));
                                    if (color.g - color.r > 0.1 || CheckForColor(color.rgb, vec3(229, 237, 229)) || CheckForColor(color.rgb, vec3(202, 225, 219))) { // Prismarine
                                        smoothnessG = pow2(color.g) * 0.8;
                                        highlightMult = 1.5;
                                        smoothnessD = smoothnessG;
                                    
                                        if (mat % 4 == 0) emission = pow1_5(color.r) * 2.5 + 0.2;
                                        overlayNoiseIntensity = 0.5, overlayNoiseEmission = 0.1;
                                    } else if (maxDif > 0.125 || color.b > 0.99) { // Redstone Parts
                                        if (color.r < 0.999 && color.b > 0.4) color.gb *= 0.5; // Comparator:Emissive Wire
                                    
                                        #include "/lib/materials/specificMaterials/terrain/redstoneTorch.glsl"
                                    
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.2;
                                    } else { // Quartz Base
                                        float factor = pow2(color.g) * 0.6;
                                    
                                        smoothnessG = factor;
                                        highlightMult = 1.0 + 2.5 * factor;
                                        smoothnessD = factor;
                                    }
                                } else /*if (mat < 13200)*/ {
                                    // block.13196 = shale
                                    float factor = pow2(color.b);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 0.6 * (1 - factor);
                                    highlightMult = factor2 * 3.0;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.45;
                                    #endif
                                }
                            }
                        } else /*if (mat < 13216)*/ {
                            if (mat < 13208) {
                                if (mat < 13204) {
                                    // block.13200 = storage_crate
                                    if (color.r - color.g > 0.078) {
                                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                    }
                                } else /*if (mat < 13208)*/ {
                                    // block.13204 = trumpet_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/trumpetPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            } else /*if (mat < 13216)*/ {
                                if (mat < 13212) {
                                    // block.13208 = trumpet_log
                                    if (color.r > 0.23) { // Trumpet Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/trumpetPlanks.glsl"
                                    } else { // Trumpet Log:Wood Part, Trumpet Wood
                                        smoothnessG = pow2(color.r) * 0.35;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                } else /*if (mat < 13216)*/ {
                                    // block.13212 = trumpet_wood
                                    #include "/lib/materials/specificMaterials/planks/trumpetPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 13248)*/ {
                        if (mat < 13232) {
                            if (mat < 13224) {
                                if (mat < 13220) {
                                    // block.13216 = brazier [rodspawn]
                                    float factor = smoothstep1(min1(color.r * 1.5));
                                    factor = factor > 0.12 ? factor : factor * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;
                                    
                                    if (mat % 4 == 0) {
                                        emission = color.g > 0.35 ? 2.5 * pow1_5(color.g) : 0.0;
                                    } else {
                                        emission = color.b > 0.35 ? 2.5 * pow1_5(color.b) : 0.0;
                                    }
                                } else /*if (mat < 13224)*/ {
                                    // block.13220 = gilded_nether_bricks
                                    if (color.r > 1.6 * color.g) {
                                        float factor = smoothstep1(min1(color.r * 1.5));
                                        factor = factor > 0.12 ? factor : factor * 0.5;
                                        smoothnessG = factor;
                                        smoothnessD = factor;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    }
                                }
                            } else /*if (mat < 13232)*/ {
                                if (mat < 13228) {
                                    // block.13224 = nether_spawner
                                    float factor = smoothstep1(min1(color.r * 1.5));
                                    factor = factor > 0.12 ? factor : factor * 0.5;
                                    smoothnessG = factor;
                                    smoothnessD = factor;
                                    
                                    if (mat % 4 == 0) {  // not ominous
                                        if (color.r > color.b * 10 || color.r > 0.75) {
                                            emission = dot(color.rgb, color.rgb) * 2.5;
                                            color.rgb *= color.rgb;
                                        }
                                    } else if (mat % 4 == 2) {  // ominous
                                        if (color.b > 0.4) {
                                            emission = pow1_5(color.b) * 1.7 + 0.35 * pow1_5(1 - color.b);
                                            color.rgb *= GetLuminance(sqrt1(color.rgb));
                                        }
                                    }
                                } else /*if (mat < 13232)*/ {
                                    // block.13228 = blast_proof_plates
                                    #include "/lib/materials/specificMaterials/terrain/blastProofPlates.glsl"
                                }
                            }
                        } else /*if (mat < 13248)*/ {
                            if (mat < 13240) {
                                if (mat < 13236) {
                                    // block.13232 = gloomy_tiles
                                    smoothnessG = pow2(pow2(color.g)) * 1.8;
                                    smoothnessG = min1(smoothnessG);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    if (mat % 4 == 2) {
                                        lmCoordM.x *= 0.88;
                                        if (color.b > color.r + 0.18) {
                                            emission = 1.5;
                                            color.rgb *= color.rgb;
                                        }
                                    }
                                } else /*if (mat < 13240)*/ {
                                    // block.13236 = ashen_basalt
                                    smoothnessG = 0.3 * pow3(color.r);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #include "/lib/materials/specificMaterials/terrain/iridescentAsh.glsl"
                                }
                            } else /*if (mat < 13248)*/ {
                                if (mat < 13244) {
                                    // block.13240 = ashen_quartz
                                    #include "/lib/materials/specificMaterials/terrain/iridescentAsh.glsl"
                                    
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    highlightMult = 3.5 * pow2(color.g);
                                    smoothnessG = 0.8 * iridescence + 0.4 * pow2(color.r);
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.5;
                                    #endif
                                } else /*if (mat < 13248)*/ {
                                    // block.13244 = ashen_snow
                                    #include "/lib/materials/specificMaterials/terrain/snow.glsl"
                                    #include "/lib/materials/specificMaterials/terrain/iridescentAsh.glsl"
                                    
                                    overlayNoiseIntensity = 0.0;
                                }
                            }
                        }
                    }
                } else /*if (mat < 13312)*/ {
                    if (mat < 13280) {
                        if (mat < 13264) {
                            if (mat < 13256) {
                                if (mat < 13252) {
                                    // block.13248 = fright_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/frightPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13256)*/ {
                                    // block.13252 = fright_fungus
                                    noSmoothLighting = true;
                                    
                                    if (color.b / color.r > 1.6) {
                                        emission = 2.0 * (0.7 + 1.2 * signMidCoordPos.y);
                                        maRecolor = vec3(0.1);
                                    }
                                    
                                    sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                    isFoliage = false;
                                }
                            } else /*if (mat < 13264)*/ {
                                if (mat < 13260) {
                                    // block.13256 = fright_stem
                                    if (abs(color.b - color.g) < 0.07 && color.b > 0.35) { // Flat Part
                                        #include "/lib/materials/specificMaterials/planks/frightPlanks.glsl"
                                    
                                        #ifdef GLOWING_NETHER_TREES
                                    } else { // Emissive Part
                                        emission = pow2(color.b) * 5.0 + 0.15;
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.3;
                                        #ifdef ANIMATED_FRIGHT_STEM
                                            #if defined GBUFFERS_TERRAIN
                                                vec3 wind = vec3(0, 0.0075, 0) * frameTimeCounter;
                                                float noise = Noise3D(0.01 * (playerPos.xyz + cameraPosition.xyz) + wind);
                                                emission *= 0.1 + 0.9 * pow2(noise);
                                                emission *= 4.0;
                                            #endif
                                        #endif
                                        #endif
                                    }
                                } else /*if (mat < 13264)*/ {
                                    // block.13260 = fright_wart_block
                                    smoothnessG = color.b;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_WART
                                    if (color.b > 0.24) {
                                        overlayNoiseIntensity = 0.7, overlayNoiseEmission = 0.8;
                                        emission = 2.4;
                                        #ifdef GBUFFERS_TERRAIN
                                            vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                                      + floor(playerPos.y + cameraPosition.y + 0.5);
                                            bpos = bpos * 0.01 + 0.005 * frameTimeCounter;
                                            emission *= pow2(texture2D(noisetex, bpos).r * pow1_5(texture2D(noisetex, bpos * 0.5).r));
                                            emission *= 4.0;
                                        #endif
                                    
                                        color.gb *= 1.5;
                                    }
                                    #endif
                                }
                            }
                        } else /*if (mat < 13280)*/ {
                            if (mat < 13272) {
                                if (mat < 13268) {
                                    // block.13264 = fright_wood
                                    #include "/lib/materials/specificMaterials/planks/frightPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13272)*/ {
                                    // block.13268 = packed_volcanic_ice
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = pow2(color.g);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.7 * factor;
                                    highlightMult = factor2 * 3.0;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                            } else /*if (mat < 13280)*/ {
                                if (mat < 13276) {
                                    // block.13272 = vines
                                    subsurfaceMode = 1;
                                    
                                    sandNoiseIntensity = 0.0, mossNoiseIntensity = 0.0, isFoliage = true;
                                } else /*if (mat < 13280)*/ {
                                    // block.13276 = allurite_crystal_display
                                    if (color.b > 0.7 && color.g > 0.7) {
                                        emission = 1.5 * sqrt(color.b) + 0.3;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 13312)*/ {
                        if (mat < 13296) {
                            if (mat < 13288) {
                                if (mat < 13284) {
                                    // block.13280 = blackstone_lamp
                                    if (color.r > 0.7) {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                                        color.r *= 1.2;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    } else {
                                        lmCoordM.x *= 0.85;
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }
                                } else /*if (mat < 13288)*/ {
                                    // block.13284 = blaze_rod
                                    smoothnessG = 1.0;
                                    smoothnessD = smoothnessG;
                                    
                                    // TODO try some noise thing similar to lava noise
                                    emission = 2.0;
                                }
                            } else /*if (mat < 13296)*/ {
                                if (mat < 13292) {
                                    // block.13288 = clock_block
                                    if (color.b < 0.4 && color.r > 0.8 && color.g > 0.8) {  // Gold Part
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    } else if (color.r > 0.7 && color.b > 0.7 && color.g > 0.7) {  // White Clockface
                                        #include "/lib/materials/specificMaterials/terrain/quartzBlock.glsl"
                                    } else if (color.r > 0.2) {  // Wooden Part
                                        #include "/lib/materials/specificMaterials/planks/darkOakPlanks.glsl"
                                    }
                                } else /*if (mat < 13296)*/ {
                                    // block.13292 = copper_lantern
                                    if (color.r > 0.95) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.77;
                                    
                                        emission = 4.3 * (color.g + color.b) * 0.5;
                                        emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                        color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                                    }
                                }
                            }
                        } else /*if (mat < 13312)*/ {
                            if (mat < 13304) {
                                if (mat < 13300) {
                                    // block.13296 = crimson_lantern
                                    if (color.r / color.g > 3.0) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.77;
                                    
                                        emission = 2.3 * color.r;
                                        emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                        color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    }
                                } else /*if (mat < 13304)*/ {
                                    // block.13300 = crystal_display
                                    if (color.r > 0.7 && color.b > 0.7) {
                                        emission = 1.5 * sqrt(color.r);
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else /*if (mat < 13312)*/ {
                                if (mat < 13308) {
                                    // block.13304 = deepslate_lamp
                                    if (color.r > 0.7) {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                                        color.r *= 1.1;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    } else {
                                        lmCoordM.x *= 0.85;
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                } else /*if (mat < 13312)*/ {
                                    // block.13308 = endstone_lamp
                                    if (color.g < 0.5) {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb) / 3;
                                        color.rgb /= dotColor;
                                        emission = sqrt(color.b + 8.0);
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    } else {
                                        lmCoordM.x *= 0.85;
                                        #include "/lib/materials/specificMaterials/terrain/endStone.glsl"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
} else /*if (mat < 14336)*/ {
    if (mat < 13824) {
        if (mat < 13568) {
            if (mat < 13440) {
                if (mat < 13376) {
                    if (mat < 13344) {
                        if (mat < 13328) {
                            if (mat < 13320) {
                                if (mat < 13316) {
                                    // block.13312 = fire_pit
                                    if (mat % 2 == 0) {
                                        #ifdef GBUFFERS_TERRAIN
                                            vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                            lmCoordM.x = pow2(pow2(smoothstep1(1.0 - 0.4 * dot(fractPos.xz, fractPos.xz))));
                                    
                                            float campfireBrightnessFactor = mix(1.0, 0.9, clamp01(UPPER_LIGHTMAP_CURVE - 1.0));
                                            lmCoordM.x *= campfireBrightnessFactor;
                                        #endif
                                    }
                                    
                                    if (color.r > 0.8) {
                                        #include "/lib/materials/specificMaterials/terrain/lumiseneFire.glsl"
                                    } else {
                                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                                    }
                                } else /*if (mat < 13320)*/ {
                                    // block.13316 = lumiere_crystal_display
                                    if (color.r > 0.7 && color.g > 0.7) {
                                        emission = 1.0 * sqrt(color.r);
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/deepslate.glsl"
                                    }
                                }
                            } else /*if (mat < 13328)*/ {
                                if (mat < 13324) {
                                    // block.13320 = crimson_lantern
                                    if (color.r / color.g > 3.0) {
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.77;
                                    
                                        emission = 2.3 * color.r;
                                        emission += min(pow2(pow2(0.75 * dot(color.rgb, color.rgb))), 5.0);
                                        color.gb *= pow(vec2(0.8, 0.7), vec2(sqrt(emission) * 0.5));
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                        #endif
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                                    }
                                } else /*if (mat < 13328)*/ {
                                    // block.13324 = redstone_illuminator
                                    color.r *= color.r * 1.05;
                                    color.gb *= pow1_5(color.gb);
                                    
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    smoothnessG = color.r * 0.5 + 0.2;
                                    float factor = pow2(smoothnessG);
                                    highlightMult = factor * 2.0 + 1.0;
                                    smoothnessD = min1(factor * 2.0);
                                    
                                    overlayNoiseIntensity = 0.3;
                                    
                                    if (color.r > 0.27) {
                                        emission = 3.0 * pow1_5(color.r);
                                    }
                                }
                            }
                        } else /*if (mat < 13344)*/ {
                            if (mat < 13336) {
                                if (mat < 13332) {
                                    // block.13328 = sack
                                    #include "/lib/materials/specificMaterials/terrain/sack.glsl"
                                } else /*if (mat < 13336)*/ {
                                    // block.13332 = soap_block
                                    smoothnessG = pow2(color.r) * 0.4;
                                    smoothnessD = smoothnessG;
                                    highlightMult = 1.5;
                                }
                            } else /*if (mat < 13344)*/ {
                                if (mat < 13340) {
                                    // block.13336 = stone_lamp
                                    if (color.r > 0.7) {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    
                                        overlayNoiseIntensity = 0.3;
                                    } else {
                                        lmCoordM.x *= 0.85;
                                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                                    }
                                } else /*if (mat < 13344)*/ {
                                    // block.13340 = sugar_cube
                                    smoothnessG = pow(color.g, 16.0) * 2.0;
                                    smoothnessD = smoothnessG * 0.7;
                                    highlightMult = 2.0;
                                }
                            }
                        }
                    } else /*if (mat < 13376)*/ {
                        if (mat < 13360) {
                            if (mat < 13352) {
                                if (mat < 13348) {
                                    // block.13344 = bloodstone
                                    smoothnessG = pow2(pow2(color.b + color.r));
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 13352)*/ {
                                    // block.13348 = crimson_shroomlight
                                    if (color.b / color.r > 1.8) {
                                        #include "/lib/materials/specificMaterials/planks/crimsonPlanks.glsl"
                                        lmCoordM.x *= 0.88;
                                    } else {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    
                                        overlayNoiseIntensity = 0.3;
                                    }
                                }
                            } else /*if (mat < 13360)*/ {
                                if (mat < 13356) {
                                    // block.13352 = overgrown_blackstone
                                    if (color.r - color.b > 0.2 || color.b - color.r > 0.2) {
                                        #if defined COATED_TEXTURES && defined GBUFFERS_TERRAIN
                                            doTileRandomisation = false;
                                        #endif
                                    
                                        if (color.r > 0.91) {
                                            emission = 3.0 * color.g;
                                            color.r *= 1.2;
                                            maRecolor = vec3(0.1);
                                        }
                                    
                                        isFoliage = false;
                                    } else {
                                        #include "/lib/materials/specificMaterials/terrain/blackstone.glsl"
                                    }

                                } else /*if (mat < 13360)*/ {
                                    // block.13356 = paper_lantern
                                    if (color.r / color.b > 1.9) {
                                        #include "/lib/materials/specificMaterials/planks/oakPlanks.glsl"
                                        lmCoordM.x *= 0.88;
                                    } else {
                                        vec2 bpos = floor(playerPos.xz + cameraPosition.xz + 0.5)
                                        + floor(playerPos.y + cameraPosition.y + 0.5);
                                        vec2 flickerNoise = texture2D(noisetex, vec2(frameTimeCounter * 0.015 + bpos.r * 0.1)).rb;
                                    
                                        noSmoothLighting = true;
                                        lmCoordM.x = 0.77;
                                    
                                        emission = 0.4 * (color.r + color.b + color.g);
                                    
                                        // motion of candle within lantern
                                        vec3 fractPos = fract(playerPos.xyz + cameraPosition.xyz) - 0.5;
                                        if (abs(NdotU) < 0.1 && max(abs(fractPos.x), abs(fractPos.z)) > 0.1)
                                            emission /= (1 + length(signMidCoordPos - 0.05 * sin(flickerNoise.gr * 5.0)));
                                    
                                        // appearance of flickering
                                        emission *= mix(1.0, min1(max(flickerNoise.r, flickerNoise.g) * 1.7), pow2(7 * 0.1));
                                    
                                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                            color.r *= mix(max(emission, 1) + 1, 1, inSoulValley);
                                            color.b *= mix(1, pow3(max(emission, 1)) + 1, inSoulValley);
                                            color.g *= max(emission, 1) + 1;
                                        #else
                                            color.r *= pow1_5(max(emission, 1)) + 1;
                                            color.g *= max(emission, 1) + 1;
                                        #endif
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(color, vec4(1.0, 0.6, 0.2, 1.0), emission, 5.0, lViewPos);
                                        #endif
                                    }
                                }
                            }
                        } else /*if (mat < 13376)*/ {
                            if (mat < 13368) {
                                if (mat < 13364) {
                                    // block.13360 = polished_bloodstone
                                    smoothnessG = 1.5 * pow2(pow2(color.b + color.r)) + 0.1;
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 13368)*/ {
                                    // block.13364 = polished_rhyolite
                                    smoothnessG = 4.1 * pow3(color.r);
                                    smoothnessD = smoothnessG;
                                }
                            } else /*if (mat < 13376)*/ {
                                if (mat < 13372) {
                                    // block.13368 = polished_schist
                                    smoothnessG = 0.7 * pow2(color.g) + 0.08;
                                    smoothnessD = smoothnessG;
                                } else /*if (mat < 13376)*/ {
                                    // block.13372 = rhyolite
                                    smoothnessG = 6.2 * pow2(pow2(color.r)) + 0.2 * color.r + 0.05;
                                    smoothnessD = smoothnessG;
                                }
                            }
                        }
                    }
                } else /*if (mat < 13440)*/ {
                    if (mat < 13408) {
                        if (mat < 13392) {
                            if (mat < 13384) {
                                if (mat < 13380) {
                                    // block.13376 = schist
                                    smoothnessG = 1.2 * pow2(pow2(color.g));
                                    smoothnessD = smoothnessG;
                                    overlayNoiseIntensity = 0.7;
                                } else /*if (mat < 13384)*/ {
                                    // block.13380 = warped_shroomlight
                                    if (color.b / color.r > 1.8) {
                                        #include "/lib/materials/specificMaterials/planks/warpedPlanks.glsl"
                                        lmCoordM.x *= 0.88;
                                    } else {
                                        lmCoordM = vec2(1.0, 0.0);
                                    
                                        float dotColor = dot(color.rgb, color.rgb);
                                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.5, lViewPos);
                                        #endif
                                    
                                        overlayNoiseIntensity = 0.3;
                                    }
                                }
                            } else /*if (mat < 13392)*/ {
                                if (mat < 13388) {
                                    // block.13384 = coralstone
                                    smoothnessG = pow3(color.g) * 2.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.77;
                                    #endif
                                    
                                    #ifdef GLOWING_CORALSTONE
                                        #include "/lib/materials/specificMaterials/terrain/coral.glsl"
                                        float maxDiff = max(
                                            abs(color.r - color.b),
                                            max(abs(color.b - color.g), abs(color.r - color.g))
                                        );
                                        if (maxDiff > 0.07) {
                                            float dotColor = dot(color.rgb, color.rgb);
                                            emission = dotColor;
                                        }
                                    #endif
                                } else /*if (mat < 13392)*/ {
                                    // block.13388 = elder_prismarine_coral
                                    smoothnessG = pow2(color.g) * 0.8;
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                    
                                    if (mat % 4 < 2) {
                                        noSmoothLighting = true;
                                    
                                        #if defined GBUFFERS_TERRAIN
                                            vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                            vec3 blockPos;
                                            if (mat % 4 == 0) {
                                                blockPos = abs(fract(worldPos) - vec3(0.5));
                                            } else {
                                                blockPos = abs(fract(worldPos) - vec3(0.5, 0.2, 0.5));
                                            }
                                    
                                            float r = length(blockPos);
                                            emission = smoothnessG - 0.5 * pow3(color.g);
                                            emission *= pow2(max0(1.0 - r * 1.3) * color.r) * 20.0;
                                            color.r *= 1.0 - emission * 0.05;
                                    
                                            overlayNoiseIntensity = 0.5;
                                        #endif
                                    }
                                }
                            }
                        } else /*if (mat < 13408)*/ {
                            if (mat < 13400) {
                                if (mat < 13396) {
                                    // block.13392 = luminous_prismarine
                                    emission = 1.2 * pow2(color.b);
                                    
                                    smoothnessG = pow2(color.g) * 0.8;
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                } else /*if (mat < 13400)*/ {
                                    // block.13396 = prismarine_coral
                                    smoothnessG = pow2(color.g) * 0.8;
                                    highlightMult = 1.5;
                                    smoothnessD = smoothnessG;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.66;
                                    #endif
                                    
                                    if (mat % 4 < 2) {
                                        noSmoothLighting = true;
                                    
                                        #if defined GBUFFERS_TERRAIN
                                            vec3 worldPos = playerPos.xyz + cameraPosition.xyz;
                                            vec3 blockPos;
                                            if (mat % 4 == 0) {
                                                blockPos = abs(fract(worldPos) - vec3(0.5));
                                            } else {
                                                blockPos = abs(fract(worldPos) - vec3(0.5, 0.2, 0.5));
                                            }
                                    
                                            float r = length(blockPos);
                                            emission = smoothnessG - 0.5 * pow3(color.g);
                                            emission *= pow2(max0(1.0 - r * 1.3) * color.r) * 35.0;
                                            color.r *= 1.0 - emission * 0.05;
                                    
                                            overlayNoiseIntensity = 0.5;
                                        #endif
                                    }
                                }
                            } else /*if (mat < 13408)*/ {
                                if (mat < 13404) {
                                    // block.13400 = tooth_lantern
                                    if (color.b > color.r + 0.1) {
                                        noSmoothLighting = true;
                                        emission = pow2(color.b) * 4.0;
                                        color.rgb *= color.rgb;
                                    
                                        #ifdef DISTANT_LIGHT_BOKEH
                                            DoDistantLightBokehMaterial(emission, 2.0, lViewPos);
                                        #endif
                                    } else {
                                        lmCoordM.x *= 0.88;
                                    
                                        smoothnessG = color.r * 0.2;
                                        smoothnessD = smoothnessG;
                                    
                                        #ifdef GBUFFERS_TERRAIN
                                            DoBrightBlockTweaks(color.rgb, 0.5, shadowMult, highlightMult);
                                        #endif
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.33;
                                        #endif
                                    }
                                } else /*if (mat < 13408)*/ {
                                    // block.13404 = enchanted_basin
                                    if (color.g < 0.5 && color.r + color.b > 1.3) {  // Amethyst Part
                                        #include "/lib/materials/specificMaterials/terrain/amethystBlock.glsl"
                                    } else if ((color.g + color.r) / color.b > 2.4 && NdotU > 0.9) {  // Experience Part
                                        highlightMult = 0.0;
                                        smoothnessD = 0.0;
                                        emission = pow1_5(color.g) * 6.0;
                                        maRecolor = vec3(0.0);
                                    
                                        color.rgb *= color.rgb;
                                        overlayNoiseIntensity = 0.0;
                                    } else if (color.r + color.b + color.g > 2.0) {  // Calcite Part
                                        highlightMult = pow2(color.g) + 1.0;
                                        smoothnessG = 1.0 - color.g * 0.5;
                                        smoothnessD = smoothnessG;
                                    }
                                }
                            }
                        }
                    } else /*if (mat < 13440)*/ {
                        if (mat < 13424) {
                            if (mat < 13416) {
                                if (mat < 13412) {
                                    // block.13408 = ancient_brazier [limestone]
                                    vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                    float maxColor = max(color.r, max(color.g, color.b));
                                    float minColor = min(color.r, min(color.g, color.b));
                                    if (color.b < 0.5 && color.r < 0.3 && color.g < 0.8) {
                                        smoothnessG = color.b + 0.2;
                                        smoothnessD = smoothnessG;
                                    
                                        overlayNoiseIntensity = 0.6;
                                    } else if ((fractPos.y > 0.24 && fractPos.y < 0.45) || maxColor - minColor > 0.1) {
                                        noDirectionalShading = true;
                                        emission = 2.9;
                                        color.rgb *= pow1_5(color.rgb);
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        smoothnessG = pow2(color.g) * 0.4;
                                        smoothnessD = smoothnessG;
                                        overlayNoiseIntensity = 0.7;
                                    }
                                } else /*if (mat < 13416)*/ {
                                    // block.13412 = aria_mushroom
                                    if (mat % 4 == 0) {
                                        emission = 2.5 * pow2(color.r) + 0.2 * pow2(color.b);
                                        overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                    } else {
                                        noSmoothLighting = true;
                                    
                                        vec3 worldPos = playerPos + cameraPosition;
                                        float fractPos = fract(worldPos.y);
                                        if (fractPos > 0.375) {
                                            emission = 2.5 * pow2(color.r) + 0.2 * pow2(color.b);
                                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                                        }
                                    
                                        sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                    }
                                }
                            } else /*if (mat < 13424)*/ {
                                if (mat < 13420) {
                                    // block.13416 = bald_cypress_door
                                    noSmoothLighting = true;
                                    #include "/lib/materials/specificMaterials/planks/baldCypressPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13424)*/ {
                                    // block.13420 = bald_cypress_log
                                    if (color.b > 0.3) { // Bald Cypress Log:Clean Part
                                        #include "/lib/materials/specificMaterials/planks/baldCypressPlanks.glsl"
                                    } else { // Bald Cypress Log:Wood Part, Bald Cypress Wood
                                        smoothnessG = 0.4 * pow2(color.b);
                                        smoothnessD = smoothnessG;
                                    
                                        mossNoiseIntensity = 0.60;
                                    
                                        #ifdef COATED_TEXTURES
                                            noiseFactor = 0.77;
                                        #endif
                                    }
                                }
                            }
                        } else /*if (mat < 13440)*/ {
                            if (mat < 13432) {
                                if (mat < 13428) {
                                    // block.13424 = bald_cypress_wood
                                    #include "/lib/materials/specificMaterials/planks/baldCypressPlanks.glsl"
                                    
                                    if (mat % 4 == 3) {  // Powered Redstone Components
                                        redstoneIPBR(color.rgb, emission);
                                    }
                                } else /*if (mat < 13432)*/ {
                                    // block.13428 = bloodcap_mushroom
                                    if (mat % 4 == 0) {
                                        if (color.g < 0.25) {
                                            #if GLOWING_BLOODCAP_MUSHROOM == 1
                                                emission = color.r;
                                                overlayNoiseEmission = 0.4;
                                            #elif GLOWING_BLOODCAP_MUSHROOM == 2
                                                emission = 1.5 * color.r;
                                                overlayNoiseEmission = 0.4;
                                            #elif GLOWING_BLOODCAP_MUSHROOM == 3
                                                emission = 2.0 * color.r;
                                                overlayNoiseEmission = 0.4;
                                            #endif
                                        }
                                    
                                        overlayNoiseIntensity = 0.6;
                                    } else {
                                        noSmoothLighting = true;
                                    
                                        vec3 worldPos = playerPos + cameraPosition;
                                        float fractPos = fract(worldPos.y);
                                        if (fractPos > 0.375) {
                                            if (color.g < 0.25) {
                                                #if GLOWING_BLOODCAP_MUSHROOM == 1
                                                    emission = color.r;
                                                    overlayNoiseEmission = 0.4;
                                                #elif GLOWING_BLOODCAP_MUSHROOM == 2
                                                    emission = 1.5 * color.r;
                                                    overlayNoiseEmission = 0.4;
                                                #elif GLOWING_BLOODCAP_MUSHROOM == 3
                                                    emission = 2.0 * color.r;
                                                    overlayNoiseEmission = 0.4;
                                                #endif
                                            }
                                    
                                            overlayNoiseIntensity = 0.6;
                                        }
                                    
                                        sandNoiseIntensity = 0.3, mossNoiseIntensity = 0.0;
                                    }
                                }
                            } else /*if (mat < 13440)*/ {
                                if (mat < 13436) {
                                    // block.13432 = brazier [limestone]
                                    vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                    #ifdef GBUFFERS_TERRAIN
                                        lmCoordM.x *= 0.88;
                                        if (NdotU > 0.9 && length(fractPos) < 0.8) {
                                            lmCoordM.x += 0.8 * pow2(0.8 - length(fractPos));
                                        }
                                    #endif
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if ((fractPos.y > -0.24 && fractPos.y < 0.45) || color.r - color.b > 0.1) {
                                        noDirectionalShading = true;
                                        emission = 3.5;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    
                                        #if defined SOUL_SAND_VALLEY_OVERHAUL_INTERNAL || defined PURPLE_END_FIRE_INTERNAL
                                            float uniformValue = 1.0;
                                            vec3 colorFire = vec3(0.0);
                                            float gradient = 0.0;
                                    
                                            #if defined NETHER
                                                uniformValue = inSoulValley;
                                                colorFire = colorSoul;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.5 * blockUV.y));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, handUV + 0.4);
                                                #endif
                                            #endif
                                    
                                            #ifdef END
                                                colorFire = colorEndBreath;
                                                #ifdef GBUFFERS_TERRAIN
                                                    gradient = mix(1.0, 0.0, clamp01(blockUV.y + 0.07 - 1.1 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * blockUV.y)));
                                                #elif defined GBUFFERS_HAND
                                                    float handUV = gl_FragCoord.y / viewHeight;
                                                    gradient = mix(1.0, 0.0, clamp01(handUV + 0.3 - 1.3 * clamp01(sin(texture2D(noisetex, vec2(frameTimeCounter * 0.01)).r) * handUV)));
                                                #endif
                                            #endif
                                    
                                            color.rgb = mix(color.rgb, mix(color.rgb, vec3(GetLuminance(color.rgb)), 0.88), uniformValue * gradient);
                                            color.rgb *= mix(vec3(1.0), colorFire * 2.0, uniformValue * gradient);
                                        #endif
                                    } else {
                                        smoothnessG = pow2(color.g) * 0.4;
                                        smoothnessD = smoothnessG;
                                        overlayNoiseIntensity = 0.7;
                                    }
                                } else /*if (mat < 13440)*/ {
                                    // block.13436 = cupric_brazier [limestone]
                                    vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                    #ifdef GBUFFERS_TERRAIN
                                        lmCoordM.x *= 0.88;
                                        if (NdotU > 0.9 && length(fractPos) < 0.8) {
                                            lmCoordM.x += 0.8 * pow2(0.8 - length(fractPos));
                                        }
                                    #endif
                                    
                                    if ((fractPos.y > -0.24 && fractPos.y < 0.45) || (color.r > 0.6 && color.g > color.r)) {
                                        noDirectionalShading = true;
                                        emission = 2.50;
                                        color.rgb *= sqrt1(GetLuminance(color.rgb));
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        smoothnessG = pow2(color.g) * 0.4;
                                        smoothnessD = smoothnessG;
                                        overlayNoiseIntensity = 0.7;
                                    }
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 13568)*/ {
                if (mat < 13504) {
                    if (mat < 13472) {
                        if (mat < 13456) {
                            if (mat < 13448) {
                                if (mat < 13444) {
                                    // block.13440 = ender_brazier [limestone]
                                    vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                    #ifdef GBUFFERS_TERRAIN
                                        lmCoordM.x *= 0.88;
                                        if (NdotU > 0.9 && length(fractPos) < 0.8) {
                                            lmCoordM.x += 0.8 * pow2(0.8 - length(fractPos));
                                        }
                                    #endif
                                    
                                    float dotColor = dot(color.rgb, color.rgb);
                                    if ((fractPos.y > -0.24 && fractPos.y < 0.45) || (color.r - color.g > 0.1 && color.b - color.g > 0.1)) {
                                        noDirectionalShading = true;
                                        emission = 3.50;
                                        color.rgb *= color.rgb;
                                    } else {
                                        smoothnessG = pow2(color.g) * 0.4;
                                        smoothnessD = smoothnessG;
                                        overlayNoiseIntensity = 0.7;
                                    }
                                } else /*if (mat < 13448)*/ {
                                    // block.13444 = limestone [wetland_whimsy]
                                    smoothnessG = pow2(color.g) * (mat % 4 == 0 ? 0.2 : 0.4);
                                    smoothnessD = smoothnessG;
                                    overlayNoiseIntensity = 0.7;
                                }
                            } else /*if (mat < 13456)*/ {
                                if (mat < 13452) {
                                    // block.13448 = soul_brazier [limestone]
                                    vec3 fractPos = fract(playerPos + cameraPosition) - 0.5;
                                    if ((fractPos.y > -0.24 && fractPos.y < 0.45) || color.b - color.r > 0.05) {
                                        noDirectionalShading = true;
                                        emission = 2.5;
                                        color.rgb *= pow1_5(color.rgb);
                                    
                                        overlayNoiseIntensity = 0.0;
                                    } else {
                                        smoothnessG = pow2(color.g) * 0.4;
                                        smoothnessD = smoothnessG;
                                        overlayNoiseIntensity = 0.7;
                                    }
                                } else /*if (mat < 13456)*/ {
                                    // block.13452 = enchanted_ice
                                    // TODO make shader actually work
                                    
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    float factor = pow2(color.g);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = factor;
                                    
                                    emission = color.r > 0.6 ? 1.6 * pow2(color.r) : 0.0;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                    
                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                }
                            }
                        } else /*if (mat < 13472)*/ {
                            if (mat < 13464) {
                                if (mat < 13460) {
                                    // block.13456 = frost_lily
                                    materialMask = OSIEBCA; // Intense Fresnel
                                    
                                    float factor = pow2(color.g);
                                    float factor2 = pow2(factor);
                                    smoothnessG = 1.0 - 0.5 * factor;
                                    highlightMult = factor2 * 3.5;
                                    smoothnessD = factor;
                                    
                                    #ifdef COATED_TEXTURES
                                        noiseFactor = 0.33;
                                    #endif
                                    
                                    #ifdef SSS_SNOW_ICE
                                        subsurfaceMode = 3, noSmoothLighting = true, noDirectionalShading = true;
                                    #endif
                                    
                                    noSmoothLighting = true;
                                    lmCoordM.x *= 0.85;
                                    
                                    emission = 1.3 * pow2(color.r);
                                    overlayNoiseIntensity = 0.5;

                                } else /*if (mat < 13464)*/ {
                                    // block.13460 = prickly_vines
                                    subsurfaceMode = 1;
                                    isFoliage = true;
                                    
                                    sandNoiseIntensity = 0.2, mossNoiseIntensity = 0.0;
                                }
                            } else /*if (mat < 13472)*/ {
                                if (mat < 13468) {
                                    // block.13464
                                } else /*if (mat < 13472)*/ {
                                    // block.13468
                                }
                            }
                        }
                    } else /*if (mat < 13504)*/ {
                        if (mat < 13488) {
                            if (mat < 13480) {
                                if (mat < 13476) {
                                    // block.13472
                                } else /*if (mat < 13480)*/ {
                                    // block.13476
                                }
                            } else /*if (mat < 13488)*/ {
                                if (mat < 13484) {
                                    // block.13480
                                } else /*if (mat < 13488)*/ {
                                    // block.13484
                                }
                            }
                        } else /*if (mat < 13504)*/ {
                            if (mat < 13496) {
                                if (mat < 13492) {
                                    // block.13488
                                } else /*if (mat < 13496)*/ {
                                    // block.13492
                                }
                            } else /*if (mat < 13504)*/ {
                                if (mat < 13500) {
                                    // block.13496
                                } else /*if (mat < 13504)*/ {
                                    // block.13500
                                }
                            }
                        }
                    }
                } else /*if (mat < 13568)*/ {
                    if (mat < 13536) {
                        if (mat < 13520) {
                            if (mat < 13512) {
                                if (mat < 13508) {
                                    // block.13504
                                } else /*if (mat < 13512)*/ {
                                    // block.13508
                                }
                            } else /*if (mat < 13520)*/ {
                                if (mat < 13516) {
                                    // block.13512
                                } else /*if (mat < 13520)*/ {
                                    // block.13516
                                }
                            }
                        } else /*if (mat < 13536)*/ {
                            if (mat < 13528) {
                                if (mat < 13524) {
                                    // block.13520
                                } else /*if (mat < 13528)*/ {
                                    // block.13524
                                }
                            } else /*if (mat < 13536)*/ {
                                if (mat < 13532) {
                                    // block.13528
                                } else /*if (mat < 13536)*/ {
                                    // block.13532
                                }
                            }
                        }
                    } else /*if (mat < 13568)*/ {
                        if (mat < 13552) {
                            if (mat < 13544) {
                                if (mat < 13540) {
                                    // block.13536
                                } else /*if (mat < 13544)*/ {
                                    // block.13540
                                }
                            } else /*if (mat < 13552)*/ {
                                if (mat < 13548) {
                                    // block.13544
                                } else /*if (mat < 13552)*/ {
                                    // block.13548
                                }
                            }
                        } else /*if (mat < 13568)*/ {
                            if (mat < 13560) {
                                if (mat < 13556) {
                                    // block.13552
                                } else /*if (mat < 13560)*/ {
                                    // block.13556
                                }
                            } else /*if (mat < 13568)*/ {
                                if (mat < 13564) {
                                    // block.13560
                                } else /*if (mat < 13568)*/ {
                                    // block.13564
                                }
                            }
                        }
                    }
                }
            }
        } else /*if (mat < 13824)*/ {
            if (mat < 13696) {
                if (mat < 13632) {
                    if (mat < 13600) {
                        if (mat < 13584) {
                            if (mat < 13576) {
                                if (mat < 13572) {
                                    // block.13568
                                } else /*if (mat < 13576)*/ {
                                    // block.13572
                                }
                            } else /*if (mat < 13584)*/ {
                                if (mat < 13580) {
                                    // block.13576
                                } else /*if (mat < 13584)*/ {
                                    // block.13580
                                }
                            }
                        } else /*if (mat < 13600)*/ {
                            if (mat < 13592) {
                                if (mat < 13588) {
                                    // block.13584
                                } else /*if (mat < 13592)*/ {
                                    // block.13588
                                }
                            } else /*if (mat < 13600)*/ {
                                if (mat < 13596) {
                                    // block.13592
                                } else /*if (mat < 13600)*/ {
                                    // block.13596
                                }
                            }
                        }
                    } else /*if (mat < 13632)*/ {
                        if (mat < 13616) {
                            if (mat < 13608) {
                                if (mat < 13604) {
                                    // block.13600
                                } else /*if (mat < 13608)*/ {
                                    // block.13604
                                }
                            } else /*if (mat < 13616)*/ {
                                if (mat < 13612) {
                                    // block.13608
                                } else /*if (mat < 13616)*/ {
                                    // block.13612
                                }
                            }
                        } else /*if (mat < 13632)*/ {
                            if (mat < 13624) {
                                if (mat < 13620) {
                                    // block.13616
                                } else /*if (mat < 13624)*/ {
                                    // block.13620
                                }
                            } else /*if (mat < 13632)*/ {
                                if (mat < 13628) {
                                    // block.13624
                                } else /*if (mat < 13632)*/ {
                                    // block.13628
                                }
                            }
                        }
                    }
                } else /*if (mat < 13696)*/ {
                    if (mat < 13664) {
                        if (mat < 13648) {
                            if (mat < 13640) {
                                if (mat < 13636) {
                                    // block.13632
                                } else /*if (mat < 13640)*/ {
                                    // block.13636
                                }
                            } else /*if (mat < 13648)*/ {
                                if (mat < 13644) {
                                    // block.13640
                                } else /*if (mat < 13648)*/ {
                                    // block.13644
                                }
                            }
                        } else /*if (mat < 13664)*/ {
                            if (mat < 13656) {
                                if (mat < 13652) {
                                    // block.13648
                                } else /*if (mat < 13656)*/ {
                                    // block.13652
                                }
                            } else /*if (mat < 13664)*/ {
                                if (mat < 13660) {
                                    // block.13656
                                } else /*if (mat < 13664)*/ {
                                    // block.13660
                                }
                            }
                        }
                    } else /*if (mat < 13696)*/ {
                        if (mat < 13680) {
                            if (mat < 13672) {
                                if (mat < 13668) {
                                    // block.13664
                                } else /*if (mat < 13672)*/ {
                                    // block.13668
                                }
                            } else /*if (mat < 13680)*/ {
                                if (mat < 13676) {
                                    // block.13672
                                } else /*if (mat < 13680)*/ {
                                    // block.13676
                                }
                            }
                        } else /*if (mat < 13696)*/ {
                            if (mat < 13688) {
                                if (mat < 13684) {
                                    // block.13680
                                } else /*if (mat < 13688)*/ {
                                    // block.13684
                                }
                            } else /*if (mat < 13696)*/ {
                                if (mat < 13692) {
                                    // block.13688
                                } else /*if (mat < 13696)*/ {
                                    // block.13692
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 13824)*/ {
                if (mat < 13760) {
                    if (mat < 13728) {
                        if (mat < 13712) {
                            if (mat < 13704) {
                                if (mat < 13700) {
                                    // block.13696
                                } else /*if (mat < 13704)*/ {
                                    // block.13700
                                }
                            } else /*if (mat < 13712)*/ {
                                if (mat < 13708) {
                                    // block.13704
                                } else /*if (mat < 13712)*/ {
                                    // block.13708
                                }
                            }
                        } else /*if (mat < 13728)*/ {
                            if (mat < 13720) {
                                if (mat < 13716) {
                                    // block.13712
                                } else /*if (mat < 13720)*/ {
                                    // block.13716
                                }
                            } else /*if (mat < 13728)*/ {
                                if (mat < 13724) {
                                    // block.13720
                                } else /*if (mat < 13728)*/ {
                                    // block.13724
                                }
                            }
                        }
                    } else /*if (mat < 13760)*/ {
                        if (mat < 13744) {
                            if (mat < 13736) {
                                if (mat < 13732) {
                                    // block.13728
                                } else /*if (mat < 13736)*/ {
                                    // block.13732
                                }
                            } else /*if (mat < 13744)*/ {
                                if (mat < 13740) {
                                    // block.13736
                                } else /*if (mat < 13744)*/ {
                                    // block.13740
                                }
                            }
                        } else /*if (mat < 13760)*/ {
                            if (mat < 13752) {
                                if (mat < 13748) {
                                    // block.13744
                                } else /*if (mat < 13752)*/ {
                                    // block.13748
                                }
                            } else /*if (mat < 13760)*/ {
                                if (mat < 13756) {
                                    // block.13752
                                } else /*if (mat < 13760)*/ {
                                    // block.13756
                                }
                            }
                        }
                    }
                } else /*if (mat < 13824)*/ {
                    if (mat < 13792) {
                        if (mat < 13776) {
                            if (mat < 13768) {
                                if (mat < 13764) {
                                    // block.13760
                                } else /*if (mat < 13768)*/ {
                                    // block.13764
                                }
                            } else /*if (mat < 13776)*/ {
                                if (mat < 13772) {
                                    // block.13768
                                } else /*if (mat < 13776)*/ {
                                    // block.13772
                                }
                            }
                        } else /*if (mat < 13792)*/ {
                            if (mat < 13784) {
                                if (mat < 13780) {
                                    // block.13776
                                } else /*if (mat < 13784)*/ {
                                    // block.13780
                                }
                            } else /*if (mat < 13792)*/ {
                                if (mat < 13788) {
                                    // block.13784
                                } else /*if (mat < 13792)*/ {
                                    // block.13788
                                }
                            }
                        }
                    } else /*if (mat < 13824)*/ {
                        if (mat < 13808) {
                            if (mat < 13800) {
                                if (mat < 13796) {
                                    // block.13792
                                } else /*if (mat < 13800)*/ {
                                    // block.13796
                                }
                            } else /*if (mat < 13808)*/ {
                                if (mat < 13804) {
                                    // block.13800
                                } else /*if (mat < 13808)*/ {
                                    // block.13804
                                }
                            }
                        } else /*if (mat < 13824)*/ {
                            if (mat < 13816) {
                                if (mat < 13812) {
                                    // block.13808
                                } else /*if (mat < 13816)*/ {
                                    // block.13812
                                }
                            } else /*if (mat < 13824)*/ {
                                if (mat < 13820) {
                                    // block.13816
                                } else /*if (mat < 13824)*/ {
                                    // block.13820
                                }
                            }
                        }
                    }
                }
            }
        }
    } else /*if (mat < 14336)*/ {
        if (mat < 14080) {
            if (mat < 13952) {
                if (mat < 13888) {
                    if (mat < 13856) {
                        if (mat < 13840) {
                            if (mat < 13832) {
                                if (mat < 13828) {
                                    // block.13824
                                } else /*if (mat < 13832)*/ {
                                    // block.13828
                                }
                            } else /*if (mat < 13840)*/ {
                                if (mat < 13836) {
                                    // block.13832
                                } else /*if (mat < 13840)*/ {
                                    // block.13836
                                }
                            }
                        } else /*if (mat < 13856)*/ {
                            if (mat < 13848) {
                                if (mat < 13844) {
                                    // block.13840
                                } else /*if (mat < 13848)*/ {
                                    // block.13844
                                }
                            } else /*if (mat < 13856)*/ {
                                if (mat < 13852) {
                                    // block.13848
                                } else /*if (mat < 13856)*/ {
                                    // block.13852
                                }
                            }
                        }
                    } else /*if (mat < 13888)*/ {
                        if (mat < 13872) {
                            if (mat < 13864) {
                                if (mat < 13860) {
                                    // block.13856
                                } else /*if (mat < 13864)*/ {
                                    // block.13860
                                }
                            } else /*if (mat < 13872)*/ {
                                if (mat < 13868) {
                                    // block.13864
                                } else /*if (mat < 13872)*/ {
                                    // block.13868
                                }
                            }
                        } else /*if (mat < 13888)*/ {
                            if (mat < 13880) {
                                if (mat < 13876) {
                                    // block.13872
                                } else /*if (mat < 13880)*/ {
                                    // block.13876
                                }
                            } else /*if (mat < 13888)*/ {
                                if (mat < 13884) {
                                    // block.13880
                                } else /*if (mat < 13888)*/ {
                                    // block.13884
                                }
                            }
                        }
                    }
                } else /*if (mat < 13952)*/ {
                    if (mat < 13920) {
                        if (mat < 13904) {
                            if (mat < 13896) {
                                if (mat < 13892) {
                                    // block.13888
                                } else /*if (mat < 13896)*/ {
                                    // block.13892
                                }
                            } else /*if (mat < 13904)*/ {
                                if (mat < 13900) {
                                    // block.13896
                                } else /*if (mat < 13904)*/ {
                                    // block.13900
                                }
                            }
                        } else /*if (mat < 13920)*/ {
                            if (mat < 13912) {
                                if (mat < 13908) {
                                    // block.13904
                                } else /*if (mat < 13912)*/ {
                                    // block.13908
                                }
                            } else /*if (mat < 13920)*/ {
                                if (mat < 13916) {
                                    // block.13912
                                } else /*if (mat < 13920)*/ {
                                    // block.13916
                                }
                            }
                        }
                    } else /*if (mat < 13952)*/ {
                        if (mat < 13936) {
                            if (mat < 13928) {
                                if (mat < 13924) {
                                    // block.13920
                                } else /*if (mat < 13928)*/ {
                                    // block.13924
                                }
                            } else /*if (mat < 13936)*/ {
                                if (mat < 13932) {
                                    // block.13928
                                } else /*if (mat < 13936)*/ {
                                    // block.13932
                                }
                            }
                        } else /*if (mat < 13952)*/ {
                            if (mat < 13944) {
                                if (mat < 13940) {
                                    // block.13936
                                } else /*if (mat < 13944)*/ {
                                    // block.13940
                                }
                            } else /*if (mat < 13952)*/ {
                                if (mat < 13948) {
                                    // block.13944
                                } else /*if (mat < 13952)*/ {
                                    // block.13948
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 14080)*/ {
                if (mat < 14016) {
                    if (mat < 13984) {
                        if (mat < 13968) {
                            if (mat < 13960) {
                                if (mat < 13956) {
                                    // block.13952
                                } else /*if (mat < 13960)*/ {
                                    // block.13956
                                }
                            } else /*if (mat < 13968)*/ {
                                if (mat < 13964) {
                                    // block.13960
                                } else /*if (mat < 13968)*/ {
                                    // block.13964
                                }
                            }
                        } else /*if (mat < 13984)*/ {
                            if (mat < 13976) {
                                if (mat < 13972) {
                                    // block.13968
                                } else /*if (mat < 13976)*/ {
                                    // block.13972
                                }
                            } else /*if (mat < 13984)*/ {
                                if (mat < 13980) {
                                    // block.13976
                                } else /*if (mat < 13984)*/ {
                                    // block.13980
                                }
                            }
                        }
                    } else /*if (mat < 14016)*/ {
                        if (mat < 14000) {
                            if (mat < 13992) {
                                if (mat < 13988) {
                                    // block.13984
                                } else /*if (mat < 13992)*/ {
                                    // block.13988
                                }
                            } else /*if (mat < 14000)*/ {
                                if (mat < 13996) {
                                    // block.13992
                                } else /*if (mat < 14000)*/ {
                                    // block.13996
                                }
                            }
                        } else /*if (mat < 14016)*/ {
                            if (mat < 14008) {
                                if (mat < 14004) {
                                    // block.14000
                                } else /*if (mat < 14008)*/ {
                                    // block.14004
                                }
                            } else /*if (mat < 14016)*/ {
                                if (mat < 14012) {
                                    // block.14008
                                } else /*if (mat < 14016)*/ {
                                    // block.14012
                                }
                            }
                        }
                    }
                } else /*if (mat < 14080)*/ {
                    if (mat < 14048) {
                        if (mat < 14032) {
                            if (mat < 14024) {
                                if (mat < 14020) {
                                    // block.14016
                                } else /*if (mat < 14024)*/ {
                                    // block.14020
                                }
                            } else /*if (mat < 14032)*/ {
                                if (mat < 14028) {
                                    // block.14024
                                } else /*if (mat < 14032)*/ {
                                    // block.14028
                                }
                            }
                        } else /*if (mat < 14048)*/ {
                            if (mat < 14040) {
                                if (mat < 14036) {
                                    // block.14032
                                } else /*if (mat < 14040)*/ {
                                    // block.14036
                                }
                            } else /*if (mat < 14048)*/ {
                                if (mat < 14044) {
                                    // block.14040
                                } else /*if (mat < 14048)*/ {
                                    // block.14044
                                }
                            }
                        }
                    } else /*if (mat < 14080)*/ {
                        if (mat < 14064) {
                            if (mat < 14056) {
                                if (mat < 14052) {
                                    // block.14048
                                } else /*if (mat < 14056)*/ {
                                    // block.14052
                                }
                            } else /*if (mat < 14064)*/ {
                                if (mat < 14060) {
                                    // block.14056
                                } else /*if (mat < 14064)*/ {
                                    // block.14060
                                }
                            }
                        } else /*if (mat < 14080)*/ {
                            if (mat < 14072) {
                                if (mat < 14068) {
                                    // block.14064
                                } else /*if (mat < 14072)*/ {
                                    // block.14068
                                }
                            } else /*if (mat < 14080)*/ {
                                if (mat < 14076) {
                                    // block.14072
                                } else /*if (mat < 14080)*/ {
                                    // block.14076
                                }
                            }
                        }
                    }
                }
            }
        } else /*if (mat < 14336)*/ {
            if (mat < 14208) {
                if (mat < 14144) {
                    if (mat < 14112) {
                        if (mat < 14096) {
                            if (mat < 14088) {
                                if (mat < 14084) {
                                    // block.14080
                                } else /*if (mat < 14088)*/ {
                                    // block.14084
                                }
                            } else /*if (mat < 14096)*/ {
                                if (mat < 14092) {
                                    // block.14088
                                } else /*if (mat < 14096)*/ {
                                    // block.14092
                                }
                            }
                        } else /*if (mat < 14112)*/ {
                            if (mat < 14104) {
                                if (mat < 14100) {
                                    // block.14096
                                } else /*if (mat < 14104)*/ {
                                    // block.14100
                                }
                            } else /*if (mat < 14112)*/ {
                                if (mat < 14108) {
                                    // block.14104
                                } else /*if (mat < 14112)*/ {
                                    // block.14108
                                }
                            }
                        }
                    } else /*if (mat < 14144)*/ {
                        if (mat < 14128) {
                            if (mat < 14120) {
                                if (mat < 14116) {
                                    // block.14112
                                } else /*if (mat < 14120)*/ {
                                    // block.14116
                                }
                            } else /*if (mat < 14128)*/ {
                                if (mat < 14124) {
                                    // block.14120
                                } else /*if (mat < 14128)*/ {
                                    // block.14124
                                }
                            }
                        } else /*if (mat < 14144)*/ {
                            if (mat < 14136) {
                                if (mat < 14132) {
                                    // block.14128
                                } else /*if (mat < 14136)*/ {
                                    // block.14132
                                }
                            } else /*if (mat < 14144)*/ {
                                if (mat < 14140) {
                                    // block.14136
                                } else /*if (mat < 14144)*/ {
                                    // block.14140
                                }
                            }
                        }
                    }
                } else /*if (mat < 14208)*/ {
                    if (mat < 14176) {
                        if (mat < 14160) {
                            if (mat < 14152) {
                                if (mat < 14148) {
                                    // block.14144
                                } else /*if (mat < 14152)*/ {
                                    // block.14148
                                }
                            } else /*if (mat < 14160)*/ {
                                if (mat < 14156) {
                                    // block.14152
                                } else /*if (mat < 14160)*/ {
                                    // block.14156
                                }
                            }
                        } else /*if (mat < 14176)*/ {
                            if (mat < 14168) {
                                if (mat < 14164) {
                                    // block.14160
                                } else /*if (mat < 14168)*/ {
                                    // block.14164
                                }
                            } else /*if (mat < 14176)*/ {
                                if (mat < 14172) {
                                    // block.14168
                                } else /*if (mat < 14176)*/ {
                                    // block.14172
                                }
                            }
                        }
                    } else /*if (mat < 14208)*/ {
                        if (mat < 14192) {
                            if (mat < 14184) {
                                if (mat < 14180) {
                                    // block.14176
                                } else /*if (mat < 14184)*/ {
                                    // block.14180
                                }
                            } else /*if (mat < 14192)*/ {
                                if (mat < 14188) {
                                    // block.14184
                                } else /*if (mat < 14192)*/ {
                                    // block.14188
                                }
                            }
                        } else /*if (mat < 14208)*/ {
                            if (mat < 14200) {
                                if (mat < 14196) {
                                    // block.14192
                                } else /*if (mat < 14200)*/ {
                                    // block.14196
                                }
                            } else /*if (mat < 14208)*/ {
                                if (mat < 14204) {
                                    // block.14200
                                } else /*if (mat < 14208)*/ {
                                    // block.14204
                                }
                            }
                        }
                    }
                }
            } else /*if (mat < 14336)*/ {
                if (mat < 14272) {
                    if (mat < 14240) {
                        if (mat < 14224) {
                            if (mat < 14216) {
                                if (mat < 14212) {
                                    // block.14208
                                } else /*if (mat < 14216)*/ {
                                    // block.14212
                                }
                            } else /*if (mat < 14224)*/ {
                                if (mat < 14220) {
                                    // block.14216
                                } else /*if (mat < 14224)*/ {
                                    // block.14220
                                }
                            }
                        } else /*if (mat < 14240)*/ {
                            if (mat < 14232) {
                                if (mat < 14228) {
                                    // block.14224
                                } else /*if (mat < 14232)*/ {
                                    // block.14228
                                }
                            } else /*if (mat < 14240)*/ {
                                if (mat < 14236) {
                                    // block.14232
                                } else /*if (mat < 14240)*/ {
                                    // block.14236
                                }
                            }
                        }
                    } else /*if (mat < 14272)*/ {
                        if (mat < 14256) {
                            if (mat < 14248) {
                                if (mat < 14244) {
                                    // block.14240
                                } else /*if (mat < 14248)*/ {
                                    // block.14244
                                }
                            } else /*if (mat < 14256)*/ {
                                if (mat < 14252) {
                                    // block.14248
                                } else /*if (mat < 14256)*/ {
                                    // block.14252
                                }
                            }
                        } else /*if (mat < 14272)*/ {
                            if (mat < 14264) {
                                if (mat < 14260) {
                                    // block.14256
                                } else /*if (mat < 14264)*/ {
                                    // block.14260
                                }
                            } else /*if (mat < 14272)*/ {
                                if (mat < 14268) {
                                    // block.14264
                                } else /*if (mat < 14272)*/ {
                                    // block.14268
                                }
                            }
                        }
                    }
                } else /*if (mat < 14336)*/ {
                    if (mat < 14304) {
                        if (mat < 14288) {
                            if (mat < 14280) {
                                if (mat < 14276) {
                                    // block.14272
                                } else /*if (mat < 14280)*/ {
                                    // block.14276
                                }
                            } else /*if (mat < 14288)*/ {
                                if (mat < 14284) {
                                    // block.14280
                                } else /*if (mat < 14288)*/ {
                                    // block.14284
                                }
                            }
                        } else /*if (mat < 14304)*/ {
                            if (mat < 14296) {
                                if (mat < 14292) {
                                    // block.14288
                                } else /*if (mat < 14296)*/ {
                                    // block.14292
                                }
                            } else /*if (mat < 14304)*/ {
                                if (mat < 14300) {
                                    // block.14296
                                } else /*if (mat < 14304)*/ {
                                    // block.14300
                                }
                            }
                        }
                    } else /*if (mat < 14336)*/ {
                        if (mat < 14320) {
                            if (mat < 14312) {
                                if (mat < 14308) {
                                    // block.14304
                                } else /*if (mat < 14312)*/ {
                                    // block.14308
                                }
                            } else /*if (mat < 14320)*/ {
                                if (mat < 14316) {
                                    // block.14312
                                } else /*if (mat < 14320)*/ {
                                    // block.14316
                                }
                            }
                        } else /*if (mat < 14336)*/ {
                            if (mat < 14328) {
                                if (mat < 14324) {
                                    // block.14320
                                } else /*if (mat < 14328)*/ {
                                    // block.14324
                                }
                            } else /*if (mat < 14336)*/ {
                                if (mat < 14332) {
                                    // block.14328
                                } else /*if (mat < 14336)*/ {
                                    // block.14332
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
}

#ifdef GBUFFERS_TERRAIN
    else { // mat < 10000
        // Support for the Enhanced Block Entities mod. The mod makes block entities render in gbuffers_terrain
        int blockEntityId = mat;
        #include "/lib/materials/materialHandling/blockEntityMaterials.glsl"
    }
#endif