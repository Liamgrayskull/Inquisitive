#include "/lib/shaderSettings/entityMaterials.glsl"
if (entityId < 50064) {
    if (entityId < 50032) {
        if (entityId < 50016) {
            if (entityId < 50008) {
                if (entityId == 50000) { // End Crystal
                    lmCoordM.x *= 0.7;

                    if (color.g * 1.2 < color.r) {
                        emission = 12.0 * color.g;
                        color.r *= 1.1;
                    }
                    emission *= END_CRYSTAL_EMISSION;
                } else if (entityId == 50004) { // Lightning Bolt
                    #include "/lib/materials/specificMaterials/entities/lightningBolt.glsl"
                }
            } else {
                if (entityId == 50008) { // Item Frame, Glow Item Frame
                    noSmoothLighting = true;
                } else /*if (entityId == 50012)*/ { // Iron Golem
                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"

                    smoothnessD *= 0.4;
                }
            }
        } else {
            if (entityId < 50024) {
                if (entityId == 50016 || entityId == 50017) { // Player
                    if (entityColor.a < 0.001) {
                        #ifdef COATED_TEXTURES
                            noiseFactor = 0.5;
                        #endif

                        if (CheckForColor(texelFetch(tex, ivec2(0, 0), 0).rgb, vec3(23, 46, 92))) {
                            for (int i = 63; i >= 56; i--) {
                                vec3 dif = color.rgb - texelFetch(tex, ivec2(i, 0), 0).rgb;
                                if (dif == clamp(dif, vec3(-0.001), vec3(0.001))) {
                                    emission = 2.0 * texelFetch(tex, ivec2(i, 1), 0).r;
                                }
                            }
                        }
                        bool selfCheck = false;
                        #if IRIS_VERSION >= 10800
                            if (entityId == 50017) {
                                selfCheck = true;
                                entitySSBLMask = 0.0;
                            }
                        #else
                            if (length(playerPos) < 4.0) {
                                selfCheck = true;
                                entitySSBLMask = 0.0;
                            }
                        #endif
                    #ifdef SPACEAGLE17
                        if (CheckForColor(color.rgb, vec3(255)) && texCoord.y < 0.22 && texCoord.y > 0.18 && selfCheck) emission = 3.0;
                    #endif

                    }
                } else /*if (entityId == 50020)*/ { // Blaze
                    lmCoordM = vec2(0.9, 0.0);
                    emission = min(color.r, 0.7) * 1.4;

                    float dotColor = dot(color.rgb, color.rgb);
                    if (abs(dotColor - 1.5) > 1.4) {
                        emission = 5.0;
                    } else {
                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                        #endif
                        #ifdef PURPLE_END_FIRE_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                        #endif
                    }
                }
            } else {
                if (entityId == 50024) { // Creeper
                    emission = max0(color.b - color.g - color.r) * 10.0;
                } else /*if (entityId == 50028)*/ { // Drowned
                    if (atlasSize.x < 900) {
                        if (CheckForColor(color.rgb, vec3(143, 241, 215)) ||
                            CheckForColor(color.rgb, vec3( 49, 173, 183)) ||
                            CheckForColor(color.rgb, vec3(101, 224, 221))) emission = 2.5;
                    }
                }
            }
        }
    } else {
        if (entityId < 50048) {
            if (entityId < 50040) {
                if (entityId == 50032) { // Guardian
                    vec3 absDif = abs(vec3(color.r - color.g, color.g - color.b, color.r - color.b));
                    float maxDif = max(absDif.r, max(absDif.g, absDif.b));
                    if (maxDif < 0.1 && color.b > 0.5 && color.b < 0.88) {
                        emission = pow2(pow1_5(color.b)) * 5.0;
                        color.rgb *= color.rgb;
                    }
                } else /*if (entityId == 50036)*/ { // Elder Guardian
                    if (CheckForColor(color.rgb, vec3(203, 177, 165)) ||
                        CheckForColor(color.rgb, vec3(214, 155, 126))) {
                        emission = pow2(pow1_5(color.b)) * 10.0;
                        color.r *= 1.2;
                    }
                }
            } else {
                if (entityId == 50040) { // Endermite
                    if (CheckForColor(color.rgb, vec3(87, 23, 50))) {
                        emission = 8.0;
                        color.rgb *= color.rgb;
                    }
                } else /*if (entityId == 50044)*/ { // Ghast
                    if (entityColor.a < 0.001)
                        emission = max0(color.r - color.g - color.b) * 6.0;
                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                            if (color.r > color.b * 2.0) color.rgb = changeColorFunction(color.rgb, 7.0, colorSoul, inSoulValley);
                        #endif
                        #ifdef PURPLE_END_FIRE_INTERNAL
                            if (color.r > color.b * 2.0) color.rgb = changeColorFunction(color.rgb, 7.0, colorEndBreath, 1.0);
                        #endif
                }
            }
        } else {
            if (entityId < 50056) {
                if (entityId == 50048) { // Glow Squid
                    lmCoordM.x = 0.0;
                    float dotColor = dot(color.rgb, color.rgb);
                    emission = pow2(pow2(min(dotColor * 0.65, 1.5))) + 0.45;
                } else /*if (entityId == 50052)*/ { // Magma Cube
                    emission = color.g * 6.0;
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                       color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                    #endif
                }
            } else {
                if (entityId == 50056) { // Stray
                    if (CheckForColor(color.rgb, vec3(230, 242, 246)) && texCoord.y > 0.35)
                        emission = 2.5;
                } else /*if (entityId == 50060)*/ { // Vex
                    lmCoordM = vec2(0.0);
                    emission = pow2(pow2(color.r)) * 3.5 + 0.5;
                    color.a *= color.a;
                }
            }
        }
    }
} else if (entityId < 50128) {
    if (entityId < 50096) {
        if (entityId < 50080) {
            if (entityId < 50072) {
                if (entityId == 50064) { // Witch
                    emission = 2.0 * color.g * float(color.g * 1.5 > color.b + color.r);
                } else /*if (entityId == 50068)*/ { // Wither, Wither Skull
                    lmCoordM.x = 0.9;
                    emission = 3.0 * float(dot(color.rgb, color.rgb) > 1.0);
                }
            } else {
                if (entityId == 50072) { // Experience Orb
                    emission = 7.5;

                    color.rgb *= color.rgb;
                } else /*if (entityId == 50076)*/ { // Boats
                    playerPos.y += 0.38; // consistentBOAT2176: to avoid water shadow and the black inner shadow bug
                }
            }
        } else {
            if (entityId < 50088) {
                if (entityId == 50080) { // Allay
                    if (atlasSize.x < 900) {
                        lmCoordM = vec2(0.0);
                        emission = float(color.r > 0.9 && color.b > 0.9) * 5.0 + color.g;
                    } else {
                        lmCoordM.x = 0.8;
                    }
                } else /*if (entityId == 50084)*/ { // Slime, Chicken
                    //only code is in Vertex Shader for now
                }
            } else {
                if (entityId == 50088) { // Entity Flame (Iris Feature)
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 3.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 3.0, colorEndBreath, 1.0);
                    #endif
                    emission = 1.3;
                } else if (entityId == 50089) { // fireball, small fireball, dragon fireball
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 4.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 4.0, colorEndBreath, 1.0);
                    #endif
                } else /*if (entityId == 50092)*/ { // Trident Entity
                    #ifdef IS_IRIS
                        // Only on Iris, because otherwise it would be inconsistent with the Trident item
                        #include "/lib/materials/specificMaterials/others/trident.glsl"
                    #endif
                }
            }
        }
    } else {
        if (entityId < 50112) {
            if (entityId < 50104) {
                if (entityId == 50096) { // Minecart++
                    if (atlasSize.x < 900 && color.r * color.g * color.b + color.b > 0.3) {
                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"

                        smoothnessD *= 0.6;
                    }
                } else /*if (entityId == 50100)*/ { // Bogged
                    if (CheckForColor(color.rgb, vec3(239, 254, 194)))
                        emission = 2.5;
                }
            } else {
                if (entityId == 50104) { // Piglin++, Hoglin+
                    if (atlasSize.x < 900) {
                        if (CheckForColor(color.rgb, vec3(255)) || CheckForColor(color.rgb, vec3(255, 242, 246))) {
                            vec2 tSize = textureSize(tex, 0);
                            vec4 checkRightmostColor = texelFetch(tex, ivec2(texCoord * tSize) + ivec2(1, 0), 0);
                            if (
                                CheckForColor(checkRightmostColor.rgb, vec3(201, 130, 101)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(241, 158, 152)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(223, 127, 119)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(241, 158, 152)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(165, 99, 80)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(213, 149, 122)) ||
                                CheckForColor(checkRightmostColor.rgb, vec3(255))
                            ) {
                                emission = 1.0;
                            }
                        }
                    }
                } else /*if (entityId == 50108)*/ { // Creaking
                    if (color.r > 0.7 && color.r > color.g * 1.2 && color.g > color.b * 2.0) { // Eyes
                        lmCoordM.x = 0.5;
                        emission = 5.0 * color.g;
                        color.rgb *= color.rgb;
                        purkinjeOverwrite = 1.0;
                    }
                }
            }
        } else {
            if (entityId < 50120) {
                if (entityId == 50112) { // Name Tag
                    noDirectionalShading = true;
                    color.rgb *= 1.5;
                    if (color.a < 0.5) {
                        color.a = 0.12;
                        color.rgb *= 5.0;
                    }
                } else /*if (entityId == 50116)*/ { //

                }
            } else {
                if (entityId == 50120) { //

                } else /*if (entityId == 50124)*/ { //

                }
            }
        }
    }
} else if (entityId < 51328) {
    if (entityId < 51264) {
        if (entityId < 51232) {
            if (entityId < 51216) {
                if (entityId < 51208) {
                    if (entityId < 51204) {
                        // entity.51200 = holler
                        emission = 4.0 * HOLLER_GLOWING_INTENSITY;
                        color.rgb *= color.rgb;
                    } else /*if (entityId < 51208)*/ {
                        // entity.51204 = bolloom
                        vec2 tSize = textureSize(tex, 0);
                        ivec2 texCoordScaled = ivec2(texCoord * tSize);
                        
                        if (texCoordScaled.y > 15) {
                            lmCoordM.x = max(lmCoordM.x, 0.8);
                        }
                        
                        if (entityId % 4 == 2 && color.g * 1.4 > color.r) {
                            float dotColor = dot(color.rgb, color.rgb);
                            emission = pow2(pow2(dotColor * 0.2)) + 0.5 * dotColor;
                        }
                    }
                } else /*if (entityId < 51216)*/ {
                    if (entityId < 51212) {
                        // entity.51208 = booflo
                        vec2 tSize = textureSize(tex, 0);
                        ivec2 texCoordScaled = ivec2(texCoord * tSize);
                        
                        if (color.g * 1.3 > color.r) {
                            if (
                                (entityId % 4 == 0 && abs(texCoordScaled.x - 26.5) < 10 && abs(texCoordScaled.y - 52) < 3) ||
                                (entityId % 4 == 1 && texCoordScaled.y < 15) ||
                                (entityId % 4 == 2 && texCoordScaled.y > 14)
                            ) {
                                emission = 2.5 * color.g;
                                color.rgb *= pow(color.rgb, vec3(0.3));
                            }
                        } else if (
                            (color.r > color.b && color.r > color.g * 2) ||
                            CheckForColor(color.rgb, vec3(113, 41, 127)) ||
                            CheckForColor(color.rgb, vec3(139, 47, 147))
                        ) {
                            emission = 3.0 * color.b;
                            color.rgb *= 0.8;
                        }
                    } else /*if (entityId < 51216)*/ {
                        // entity.51212 = eetle
                        vec3 hsv = rgb2hsv(color.rgb);
                        if (CheckForColor(color.rgb, vec3(178, 148, 254))) {
                            emission = 0.4;
                        } else if ((color.r > 0.3 && abs(hsv.r * 36 - 27) < 2) || CheckForColor(color.rgb, vec3(48, 48, 115))) {
                            emission = clamp(3.5 * pow1_5(color.b) + 1.5, 0.0, 7.0);
                            color.rgb *= color.rgb;
                        } else {
                            smoothnessG = 0.2 + 0.5 * color.b;
                            smoothnessD = smoothnessG;
                            highlightMult = 1.5;
                        }
                    }
                }
            } else /*if (entityId < 51232)*/ {
                if (entityId < 51224) {
                    if (entityId < 51220) {
                        // entity.51216 = crimson_forest_enderman
                        if (color.r > 0.91) {
                            emission = 3.0 * color.g;
                            color.r *= 1.2;
                        
                            overlayNoiseIntensity = 0.5;
                        }
                        
                        smoothnessG = color.r * 0.5;
                        smoothnessD = smoothnessG;
                        
                        #ifdef COATED_TEXTURES
                            noiseFactor = 0.77;
                        #endif
                    } else /*if (entityId < 51224)*/ {
                        // entity.51220 = crimson_forest_enderman
                        if (color.r > 0.91) {
                            emission = 3.0 * color.g;
                            color.r *= 1.2;
                        
                            overlayNoiseIntensity = 0.5;
                        }
                        
                        smoothnessG = color.r * 0.5;
                        smoothnessD = smoothnessG;
                        
                        #ifdef COATED_TEXTURES
                            noiseFactor = 0.77;
                        #endif
                    }
                } else /*if (entityId < 51232)*/ {
                    if (entityId < 51228) {
                        // entity.51224 = ice_spikes_enderman
                        smoothnessG = pow2(color.g) * color.g;
                        smoothnessD = smoothnessG;
                    } else /*if (entityId < 51232)*/ {
                        // entity.51228 = spirit
                        if (color.b > 1.3 * color.r || color.b > 0.9) {
                            emission = 1.5;
                            color.rgb = pow1_5(color.rgb);
                        
                            overlayNoiseIntensity = 0.0;
                            color.a = pow1_5(color.b) - 0.05;
                        }
                    }
                }
            }
        } else /*if (entityId < 51264)*/ {
            if (entityId < 51248) {
                if (entityId < 51240) {
                    if (entityId < 51236) {
                        // entity.51232 = stone_enderman
                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                    } else /*if (entityId < 51240)*/ {
                        // entity.51236 = warped_forest_enderman
                        #ifdef MOD_NETHEREXP
                            if (color.r > 0.73) {
                                emission = 1.5 * color.b;
                        
                                overlayNoiseIntensity = 0.5;
                            }
                        #else
                            if (color.r > 0.91) {
                                emission = 3.0 * color.g;
                                color.r *= 1.2;
                        
                                overlayNoiseIntensity = 0.5;
                            }
                        #endif
                        
                        smoothnessG = color.g * 0.5;
                        smoothnessD = smoothnessG;
                        
                        #ifdef COATED_TEXTURES
                            noiseFactor = 0.77;
                        #endif
                    }
                } else /*if (entityId < 51248)*/ {
                    if (entityId < 51244) {
                        // entity.51240 = copper_golem
                        #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                    } else /*if (entityId < 51248)*/ {
                        // entity.51244 = ice_chunk
                        if (color.r > 0.8) {
                            materialMask = OSIEBCA; // Intense Fresnel
                            float factor = min1(pow2(color.g) * 1.38);
                            float factor2 = pow2(factor);
                            smoothnessG = 1.0 - 0.5 * factor;
                            highlightMult = factor2 * 3.5;
                            smoothnessD = pow1_5(color.g);
                        
                            #ifdef COATED_TEXTURES
                                noiseFactor = 0.33;
                            #endif
                        } else {
                            smoothnessG = (1.0 - pow(color.g, 64.0) * 0.3) * 0.4;
                            highlightMult = 2.0;
                        
                            smoothnessD = smoothnessG;
                        }

                    }
                }
            } else /*if (entityId < 51264)*/ {
                if (entityId < 51256) {
                    if (entityId < 51252) {
                        // entity.51248 = wildfire [friends and foes]
                        lmCoordM = vec2(0.9, 0.0);
                        emission = min(color.r, 0.7) * 1.4;
                        
                        float dotColor = dot(color.rgb, color.rgb);
                        if (CheckForColor(color.rgb, vec3(221, 54, 72)) || CheckForColor(color.rgb, vec3(137, 29, 52))) {
                           emission = 4.0;
                        } else if (abs(dotColor - 1.5) > 1.4) {
                            emission = 5.0;
                        } else {
                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                            #endif
                            #ifdef PURPLE_END_FIRE_INTERNAL
                                color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                            #endif
                        }
                    } else /*if (entityId < 51256)*/ {
                        // entity.51252 = pink_salt_pillar
                        #include "/lib/materials/specificMaterials/terrain/pinkSalt.glsl"
                        
                        #if GLOWING_PINK_SALT >= 2
                            emission = pow2(color.g) * color.g * 3.0;
                            color.g *= 1.0 - emission * 0.07;
                            emission *= 1.3;
                        #endif
                        
                        overlayNoiseIntensity = 0.5;
                    }
                } else /*if (entityId < 51264)*/ {
                    if (entityId < 51260) {
                        // entity.51256 = preserved
                        if (color.r > 0.8) {
                            #include "/lib/materials/specificMaterials/terrain/pinkSalt.glsl"
                        
                            if (entityId % 4 == 0) {
                                #if GLOWING_PINK_SALT >= 3
                                    emission = pow2(color.g) * color.g * 3.0;
                                    color.g *= 1.0 - emission * 0.07;
                                    emission *= 1.3;
                                #endif
                            } else {
                                #if GLOWING_PINK_SALT >= 2
                                    emission = pow2(color.g) * color.g * 3.0;
                                    color.g *= 1.0 - emission * 0.07;
                                    emission *= 1.3;
                                #endif
                            }
                        
                            overlayNoiseIntensity = 0.5;
                        }
                    } else /*if (entityId < 51264)*/ {
                        // entity.51260 = sparkle
                        if (color.b / color.r > 1.2 && color.b > 0.4) {
                            materialMask = OSIEBCA; // Intense Fresnel
                            float factor = pow2(0.6 * color.b + 0.4 * color.g);
                            smoothnessG = 0.8 - factor * 0.3;
                            highlightMult = factor * 3.0;
                            smoothnessD = factor;
                        
                            overlayNoiseIntensity = 0.5;
                        } else if (color.r / color.b > 1.2 && color.r > 0.4) {
                            materialMask = OSIEBCA; // Intense Fresnel
                            float factor = pow2(0.8 * color.g + 0.2 * color.r);
                            smoothnessG = 0.8 - factor * 0.3;
                            highlightMult = factor * 3.0;
                            smoothnessD = factor;
                        
                            overlayNoiseIntensity = 0.5;
                        }
                    }
                }
            }
        }
    } else /*if (entityId < 51328)*/ {
        if (entityId < 51296) {
            if (entityId < 51280) {
                if (entityId < 51272) {
                    if (entityId < 51268) {
                        // entity.51264 = spectre
                        emission = 1.2 + 4.0 * pow2(max0(color.b - color.r));
                    } else /*if (entityId < 51272)*/ {
                        // entity.51268 = spectrepillar
                        emission = 0.3 + 0.2 * pow2(color.r);
                    }
                } else /*if (entityId < 51280)*/ {
                    if (entityId < 51276) {
                        // entity.51272 = apparition
                        if (color.b - color.r > 0.1) {
                            emission = 0.3 * pow2(color.b);
                        
                            if (CheckForColor(color.rgb, vec3(1.0)))
                                emission += 2.0;
                        }
                    } else /*if (entityId < 51280)*/ {
                        // entity.51276 = banshee
                        emission = 2.5 * sqrt1(color.b);
                    }
                }
            } else /*if (entityId < 51296)*/ {
                if (entityId < 51288) {
                    if (entityId < 51284) {
                        // entity.51280 = ecto_slab
                        if (color.b > 0.65) {
                            emission = 3.0;
                            color.rgb *= sqrt1(GetLuminance(color.rgb));
                        }
                    } else /*if (entityId < 51288)*/ {
                        // entity.51284 = vessel
                        if (color.b - color.r > 0.1) {
                            emission = 3.0;
                            color.rgb *= sqrt1(GetLuminance(color.rgb));
                        }
                    }
                } else /*if (entityId < 51296)*/ {
                    if (entityId < 51292) {
                        // entity.51288 = foxhound
                        if (color.r > 0.8 || color.b > 0.8) {
                            emission = 2.0;
                            color.rgb *= sqrt1(GetLuminance(color.rgb));
                        
                            overlayNoiseIntensity = 0.0;
                        }
                    } else /*if (entityId < 51296)*/ {
                        // entity.51292 = oretortoise
                        vec4 shellColour = texelFetch(tex, ivec2(26, 0), 0);
                        if (!CheckForColor(shellColour.rgb, vec3(56, 50, 55)) || shellColour.a < 0.1) {
                            if (CheckForColor(shellColour.rgb, vec3(55, 103, 146))) {  // Lapis Lazuli
                                #include "/lib/materials/specificMaterials/terrain/lapisBlock.glsl"
                                #ifdef GLOWING_ORETORTOISE
                                emission = dot(color.rgb, color.rgb) * 1.2;
                                #endif
                            } else {
                                vec4 oreColour = texelFetch(tex, ivec2(9, 44), 0);
                                if (shellColour.r > 10 * shellColour.b) {  // Redstone
                                    #include "/lib/materials/specificMaterials/terrain/redstoneBlock.glsl"
                                    #ifdef GLOWING_ORETORTOISE
                                    emission = 0.75 + 3.0 * pow2(pow2(color.r));
                                    color.gb *= 0.65;
                                    #endif
                                } else if (shellColour.r > 2 * shellColour.b || shellColour.a < 0.1) {  // Copper
                                    #include "/lib/materials/specificMaterials/terrain/rawCopperBlock.glsl"
                                    #ifdef GLOWING_ORETORTOISE
                                    emission = pow2(color.r) * 1.5 + color.g * 1.3 + 0.2;
                                    #endif
                                } else if (shellColour.r > shellColour.b) {
                                    if (shellColour.r > 2.5 * shellColour.g) {  // Spinel
                                        #include "/lib/materials/specificMaterials/terrain/spinelBlock.glsl"
                                        #ifdef GLOWING_ORETORTOISE
                                        emission = 0.45 * (1.6 * sqrt2(color.r) + 2.2 * pow2(color.r));
                                        #endif
                                    } else {  // Iron
                                        #include "/lib/materials/specificMaterials/terrain/rawIronBlock.glsl"
                                        #ifdef GLOWING_ORETORTOISE
                                        emission = pow1_5(color.r) * 0.5;
                                        #endif
                                    }
                                } else {  // Lead
                                    #include "/lib/materials/specificMaterials/terrain/rawLeadBlock.glsl"
                                    #ifdef GLOWING_ORETORTOISE
                                    emission = 6.0 * sqrt2(max(color.r, color.b));
                                    #endif
                                }
                            }
                        }
                        
                        #ifdef GLOWING_ORETORTOISE
                            overlayNoiseIntensity = 0.6, overlayNoiseEmission = 0.5;
                            #ifdef SITUATIONAL_ORETORTOISE
                                emission *= skyLightCheck;
                                color.rgb = mix(color.rgb, color.rgb * pow(color.rgb, vec3(0.5 * min1(GLOWING_ORETORTOISE_MULT))), skyLightCheck);
                            #else
                                color.rgb *= pow(color.rgb, vec3(0.5 * min1(GLOWING_ORETORTOISE_MULT)));
                            #endif
                        
                            emission *= GLOWING_ORETORTOISE_MULT * 1.5;
                        #endif
                    }
                }
            }
        } else /*if (entityId < 51328)*/ {
            if (entityId < 51312) {
                if (entityId < 51304) {
                    if (entityId < 51300) {
                        // entity.51296 = stoneling
                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                        
                        if (
                            CheckForColor(color.rgb, vec3(118, 148, 134)) ||
                            CheckForColor(color.rgb, vec3(106, 121, 120)) ||
                            CheckForColor(color.rgb, vec3(188, 188, 157)) ||
                            CheckForColor(color.rgb, vec3(92, 108, 96)) ||
                            CheckForColor(color.rgb, vec3(178, 178, 136))
                        ) {
                            float dotColor = dot(color.rgb, color.rgb);
                            emission = min(pow2(pow2(dotColor) * dotColor) * 1.4 + dotColor * 0.9, 6.0);
                            emission = mix(emission, dotColor * 1.5, min1(lViewPos / 96.0));
                        }
                    } else /*if (entityId < 51304)*/ {
                        // entity.51300 = totem
                        smoothnessG = 2.0;
                        smoothnessD = smoothnessG;
                    }
                } else /*if (entityId < 51312)*/ {
                    if (entityId < 51308) {
                        // entity.51304 = wraith
                        if (color.b > 0.7) {
                            emission = 0.2 + 1.5 * pow2(color.b - color.r);
                            color.rgb = pow1_5(color.rgb);
                        }
                    } else /*if (entityId < 51312)*/ {
                        // entity.51308 = wildfire [rodspawn]
                        if (
                            CheckForColor(color.rgb, vec3(164, 0, 0)) ||
                            CheckForColor(color.rgb, vec3(244, 12, 12)) ||
                            CheckForColor(color.rgb, vec3(255, 110, 110))
                        ) {
                            emission = 5.0;
                            color.rgb *= color.rgb;
                        } else if (color.r > 0.95 || color.r > 3.0 * color.b) {
                            lmCoordM = vec2(0.9, 0.0);
                            emission = min(color.r, 0.7) * 2.5;
                        }
                    }
                }
            } else /*if (entityId < 51328)*/ {
                if (entityId < 51320) {
                    if (entityId < 51316) {
                        // entity.51312 = pike
                        vec4 pikeColour = texelFetch(tex, ivec2(0, 31), 0);
                        if (CheckForColor(pikeColour.rgb, vec3(16, 12, 28))) {  // obsidian
                            #include "/lib/materials/specificMaterials/terrain/obsidian.glsl"
                        
                            highlightMult *= 0.5;
                        
                            if (color.r > 0.3) {
                                emission = 4.0 * color.r;
                                color.r *= 1.15;
                            }
                        } else if (CheckForColor(pikeColour.rgb, vec3(49, 71, 83))) {  // supercharged
                            if (color.r > 0.35 && color.b > 1.8 * color.r)
                            emission = 3.5 * color.b;
                        }
                    } else /*if (entityId < 51320)*/ {
                        // entity.51316 = sonar
                        noSmoothLighting = true;
                        lmCoordM = vec2(1.0, 0.0);
                        
                        emission = 2.0 * pow2(color.b);
                    }
                } else /*if (entityId < 51328)*/ {
                    if (entityId < 51324) {
                        // entity.51320 = thrasher
                        vec2 tSize = textureSize(tex, 0);
                        ivec2 texCoordScaled = ivec2(texCoord * tSize);
                        if (entityId % 4 == 0) {  // thrasher
                            if ((texCoordScaled.x >= 30 && texCoordScaled.y >= 88) || (texCoordScaled.x >= 50 && texCoordScaled.y >= 63)) {
                                emission = 2.0 * pow2(color.b);
                                color.rgb *= sqrt(color.rgb);
                            }
                        } else {  // great thrasher
                            if (texCoordScaled.x >= 48 && texCoordScaled.y >= 63) {
                                emission = 2.0 * pow2(color.b);
                            }
                        }
                    } else /*if (entityId < 51328)*/ {
                        // entity.51324 = swamp_spider
                        if (color.r > 2 * color.g) {
                            #if GLOWING_BLOODCAP_MUSHROOM == 1
                                emission = color.r;
                            #elif GLOWING_BLOODCAP_MUSHROOM == 2
                                emission = 1.5 * color.r;
                            #elif GLOWING_BLOODCAP_MUSHROOM == 3
                                emission = 2.0 * color.r;
                            #endif
                        }
                    }
                }
            }
        }
    }
} else /*if (entityId < 51456)*/ {
    if (entityId < 51392) {
        if (entityId < 51360) {
            if (entityId < 51344) {
                if (entityId < 51336) {
                    if (entityId < 51332) {
                        // entity.51328
                    } else /*if (entityId < 51336)*/ {
                        // entity.51332
                    }
                } else /*if (entityId < 51344)*/ {
                    if (entityId < 51340) {
                        // entity.51336
                    } else /*if (entityId < 51344)*/ {
                        // entity.51340
                    }
                }
            } else /*if (entityId < 51360)*/ {
                if (entityId < 51352) {
                    if (entityId < 51348) {
                        // entity.51344
                    } else /*if (entityId < 51352)*/ {
                        // entity.51348
                    }
                } else /*if (entityId < 51360)*/ {
                    if (entityId < 51356) {
                        // entity.51352
                    } else /*if (entityId < 51360)*/ {
                        // entity.51356
                    }
                }
            }
        } else /*if (entityId < 51392)*/ {
            if (entityId < 51376) {
                if (entityId < 51368) {
                    if (entityId < 51364) {
                        // entity.51360
                    } else /*if (entityId < 51368)*/ {
                        // entity.51364
                    }
                } else /*if (entityId < 51376)*/ {
                    if (entityId < 51372) {
                        // entity.51368
                    } else /*if (entityId < 51376)*/ {
                        // entity.51372
                    }
                }
            } else /*if (entityId < 51392)*/ {
                if (entityId < 51384) {
                    if (entityId < 51380) {
                        // entity.51376
                    } else /*if (entityId < 51384)*/ {
                        // entity.51380
                    }
                } else /*if (entityId < 51392)*/ {
                    if (entityId < 51388) {
                        // entity.51384
                    } else /*if (entityId < 51392)*/ {
                        // entity.51388
                    }
                }
            }
        }
    } else /*if (entityId < 51456)*/ {
        if (entityId < 51424) {
            if (entityId < 51408) {
                if (entityId < 51400) {
                    if (entityId < 51396) {
                        // entity.51392
                    } else /*if (entityId < 51400)*/ {
                        // entity.51396
                    }
                } else /*if (entityId < 51408)*/ {
                    if (entityId < 51404) {
                        // entity.51400
                    } else /*if (entityId < 51408)*/ {
                        // entity.51404
                    }
                }
            } else /*if (entityId < 51424)*/ {
                if (entityId < 51416) {
                    if (entityId < 51412) {
                        // entity.51408
                    } else /*if (entityId < 51416)*/ {
                        // entity.51412
                    }
                } else /*if (entityId < 51424)*/ {
                    if (entityId < 51420) {
                        // entity.51416
                    } else /*if (entityId < 51424)*/ {
                        // entity.51420
                    }
                }
            }
        } else /*if (entityId < 51456)*/ {
            if (entityId < 51440) {
                if (entityId < 51432) {
                    if (entityId < 51428) {
                        // entity.51424
                    } else /*if (entityId < 51432)*/ {
                        // entity.51428
                    }
                } else /*if (entityId < 51440)*/ {
                    if (entityId < 51436) {
                        // entity.51432
                    } else /*if (entityId < 51440)*/ {
                        // entity.51436
                    }
                }
            } else /*if (entityId < 51456)*/ {
                if (entityId < 51448) {
                    if (entityId < 51444) {
                        // entity.51440
                    } else /*if (entityId < 51448)*/ {
                        // entity.51444
                    }
                } else /*if (entityId < 51456)*/ {
                    if (entityId < 51452) {
                        // entity.51448
                    } else /*if (entityId < 51456)*/ {
                        // entity.51452
                    }
                }
            }
        }
    }
}
