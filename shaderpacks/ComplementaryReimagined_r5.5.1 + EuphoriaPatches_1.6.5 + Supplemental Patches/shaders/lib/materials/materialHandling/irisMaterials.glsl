#include "/lib/shaderSettings/entityMaterials.glsl"
int mat = currentRenderedItemId;

#ifdef GBUFFERS_HAND
    float lViewPos = 0.0;
#endif

#if defined GBUFFERS_ENTITIES || defined GBUFFERS_HAND
    int subsurfaceMode;
#endif

#if defined GBUFFERS_BLOCK
    float skyLightCheck = 0.0;
    float overlayNoiseEmission;
    vec3 maRecolor;
    bool noGeneratedNormals;
    bool noVanillaAO;
#endif

bool centerShadowBias;
float noPuddles;

if (currentRenderedItemId < 45000) {
    #ifdef DISTANT_LIGHT_BOKEH
        #undef DISTANT_LIGHT_BOKEH
        #include "/lib/materials/materialHandling/terrainMaterials.glsl"
        #define DISTANT_LIGHT_BOKEH
    #else
        #include "/lib/materials/materialHandling/terrainMaterials.glsl"
    #endif
} else

if (currentRenderedItemId < 45064) {
    if (currentRenderedItemId < 45032) {
        if (currentRenderedItemId < 45016) {
            if (currentRenderedItemId < 45008) {
                if (currentRenderedItemId == 45000) { // Armor Trims
                    smoothnessG = 0.5;
                    highlightMult = 2.0;
                    smoothnessD = 0.5;

                    #ifdef GLOWING_ARMOR_TRIM
                        emission = 1.0;
                    #endif
                    #ifdef SITUATIONAL_GLOWING_TRIMS
                        emission *= skyLightCheck;
                    #endif
                } else if (currentRenderedItemId == 45004) { // Wooden Tools, Bow, Fishing Rod
                    #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                    smoothnessG = min(smoothnessG, 0.4);
                    smoothnessD = smoothnessG;
                }
            } else {
                if (currentRenderedItemId == 45008) { // Stone Tools
                    if (CheckForStick(color.rgb)) {
                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                    } else {
                        #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                    }
                } else /*if (currentRenderedItemId == 45012)*/ { // Iron Tools, Iron Armor, Iron Ingot, Iron Nugget, Iron Horse Armor, Flint and Steel, Flint, Spyglass, Shears, Chainmail Armor
                    if (CheckForStick(color.rgb)) {
                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                    } else {
                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                    }
                }
            }
        } else {
            if (currentRenderedItemId < 45024) {
                if (currentRenderedItemId == 45016) { // Golden Tools, Golden Armor, Gold Ingot, Gold Nugget, Golden Apple, Enchanted Golden Apple, Golden Carrot, Golden Horse Armor, Copper Ingot
                    if (CheckForStick(color.rgb)) {
                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                    } else {
                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                    }
                } else /*if (currentRenderedItemId == 45020)*/ { // Diamond Tools, Diamond Armor, Diamond, Diamond Horse Armor, Emerald
                    if (CheckForStick(color.rgb)) {
                        #include "/lib/materials/specificMaterials/planks/sprucePlanks.glsl"
                    } else {
                        #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                    }
                }
            } else {
                if (currentRenderedItemId == 45024) { // Netherite Tools, Netherite Armor, Netherite Ingot
                    materialMask = OSIEBCA; // Intense Fresnel
                    smoothnessG = color.r * 1.5;
                    smoothnessG = min1(smoothnessG);
                    highlightMult = smoothnessG * 2.0;
                    smoothnessD = smoothnessG * smoothnessG * 0.5;

                    #ifdef COATED_TEXTURES
                        noiseFactor = 0.33;
                    #endif
                } else /*if (currentRenderedItemId == 45028)*/ { // Trident Item
                    #include "/lib/materials/specificMaterials/others/trident.glsl"
                }
            }
        }
    } else {
        if (currentRenderedItemId < 45048) {
            if (currentRenderedItemId < 45040) {
                if (currentRenderedItemId == 45032) { // Lava Bucket
                    if (color.r + color.g > color.b * 2.0) {
                        emission = color.r + color.g - color.b * 1.5;
                        emission *= 1.8;
                        color.rg += color.b * vec2(0.4, 0.15);
                        color.b *= 0.8;
                        if (LAVA_TEMPERATURE != 0.0) maRecolor += LAVA_TEMPERATURE * 0.1;
                        emission *= LAVA_EMISSION;
                        #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                        #endif
                        #ifdef PURPLE_END_FIRE_INTERNAL
                            color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                        #endif
                } else {
                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                    }
                } else /*if (currentRenderedItemId == 45036)*/ { // Bucket++
                    if (GetMaxColorDif(color.rgb) < 0.01) {
                        #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                    } else {
                        float factor = color.b;
                        smoothnessG = factor;
                        highlightMult = factor * 2.0;
                        smoothnessD = factor;
                    }
                }
            } else {
                if (currentRenderedItemId == 45040) { // Blaze Rod, Blaze Powder
                    noSmoothLighting = false;
                    lmCoordM.x = 0.85;
                    emission = color.g;
                    color.rgb = sqrt1(color.rgb);
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                    #endif
            } else /*if (currentRenderedItemId == 45044)*/ { // Bottle o' Enchanting, Glow Inc Sac
                    emission = color.b * 2.0;
                }
            }
        } else {
            if (currentRenderedItemId < 45056) {
                if (currentRenderedItemId == 45048) { // Fire Charge
                    emission = max0(color.r + color.g - color.b * 0.5);
                    #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 5.0, colorSoul, inSoulValley);
                    #endif
                    #ifdef PURPLE_END_FIRE_INTERNAL
                        color.rgb = changeColorFunction(color.rgb, 5.0, colorEndBreath, 1.0);
                    #endif
            } else /*if (currentRenderedItemId == 45052)*/ { // Chorus Fruit
                    emission = max0(color.b * 2.0 - color.r) * 1.5;
                }
            } else {
                if (currentRenderedItemId == 45056) { // Amethyst Shard
                    materialMask = OSIEBCA; // Intense Fresnel
                    float factor = pow2(color.r);
                    smoothnessG = 0.8 - factor * 0.3;
                    highlightMult = factor * 3.0;
                    smoothnessD = factor;
                } else /*if (currentRenderedItemId == 45060)*/ { // Shield
                    float factor = min(color.r * color.g * color.b * 4.0, 0.7) * 0.7;
                    smoothnessG = factor;
                    highlightMult = factor * 3.0;
                    smoothnessD = factor;
                }
            }
        }
    }
} else if (currentRenderedItemId < 45128) {
    if (currentRenderedItemId < 45096) {
        if (currentRenderedItemId < 45080) {
            if (currentRenderedItemId < 45072) {
                if (currentRenderedItemId == 45064) { // Turtle Shell
                    float factor = color.g * 0.7;
                    smoothnessG = factor;
                    highlightMult = factor * 3.0;
                    smoothnessD = factor;
                } else /*if (currentRenderedItemId == 45068)*/ { // Ender Pearl
                    smoothnessG = 1.0;
                    highlightMult = 2.0;
                    smoothnessD = 1.0;
                }
            } else {
                if (currentRenderedItemId == 45072) { // Eye of Ender
                    smoothnessG = 1.0;
                    highlightMult = 2.0;
                    smoothnessD = 1.0;
                    emission = max0(color.g - color.b * 0.25);
                    color.rgb = pow(color.rgb, vec3(1.0 - 0.75 * emission));
                } else /*if (currentRenderedItemId == 45076)*/ { // Clock
                    if (
                        CheckForColor(color.rgb, vec3(255, 255, 0)) ||
                        CheckForColor(color.rgb, vec3(204, 204, 0)) ||
                        CheckForColor(color.rgb, vec3(73, 104, 216)) ||
                        CheckForColor(color.rgb, vec3(58, 83, 172)) ||
                        CheckForColor(color.rgb, vec3(108, 108, 137)) ||
                        CheckForColor(color.rgb, vec3(86, 86, 109))
                    ) {
                        emission = 1.0;
                        color.rgb += vec3(0.1);
                    }

                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                }
            }
        } else {
            if (currentRenderedItemId < 45088) {
                if (currentRenderedItemId == 45080) { // Compass
                    if (color.r - 0.1 > color.b + color.g) {
                        emission = color.r * 1.5;
                    }

                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                } else /*if (currentRenderedItemId == 45084)*/ { // Echo Shard, Recovery Compass, Music Disc 5
                    emission = max0(color.b + color.g - color.r * 2.0);

                    #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                }
            } else {
                if (currentRenderedItemId == 45088) { // Nether Star
                    emission = pow2(color.r + color.g) * 0.5;
                } else /*if (currentRenderedItemId == 45092)*/ { // End Crystal
                    if (color.g < color.r) {
                        emission = 3.0;
                        color.r *= 1.1;
                    }
                    emission *= END_CRYSTAL_EMISSION;
                }
            }
        }
    } else {
        if (currentRenderedItemId < 45112) {
            if (currentRenderedItemId < 45104) {
                if (currentRenderedItemId == 45096) { // Glow Berries
                    // iris needs to add support
                } else /*if (currentRenderedItemId == 45100)*/ { // Glowstone Dust
                    emission = dot(color.rgb, color.rgb) * 0.5 + 1.0;
                }
            } else {
                if (currentRenderedItemId == 45104) { // Prismarine Crystals
                    emission = pow1_5(color.r) * 2.5 + 0.2;
                } else /*if (currentRenderedItemId == 45108)*/ { // Totem of Undying
                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                }
            }
        } else {
            if (currentRenderedItemId < 45120) {
                if (currentRenderedItemId == 45112) { // Trial Key, Ominous Trial Key
                    emission = abs(color.r - color.b) * 3.0;
                    color.rgb = pow(color.rgb, vec3(1.0 + 0.5 * sqrt(emission)));
                } else /*if (currentRenderedItemId == 45116)*/ { //

                }
            } else {
                if (currentRenderedItemId == 45120) { //

                } else /*if (currentRenderedItemId == 45124)*/ { //

                }
            }
        }
    }
} else if (currentRenderedItemId < 46208) {
    if (currentRenderedItemId < 46144) {
        if (currentRenderedItemId < 46112) {
            if (currentRenderedItemId < 46096) {
                if (currentRenderedItemId < 46088) {
                    if (currentRenderedItemId < 46084) {
                        // item.46080 = golden_bucket
                        if (color.r - color.b > 0.3 || CheckForColor(color.rgb, vec3(255))) {
                            #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                        } else {
                            float factor = color.b;
                            smoothnessG = factor;
                            highlightMult = factor * 2.0;
                            smoothnessD = factor;
                        }
                    } else /*if (currentRenderedItemId < 46088)*/ {
                        // item.46084 = golden_lava_bucket
                        if (
                            CheckForColor(color.rgb, vec3(117, 40, 2)) ||
                            CheckForColor(color.rgb, vec3(204, 134, 3)) ||
                            CheckForColor(color.rgb, vec3(168, 91, 23)) ||
                            CheckForColor(color.rgb, vec3(250, 214, 74)) ||
                            CheckForColor(color.rgb, vec3(255, 220, 80)) ||
                            CheckForColor(color.rgb, vec3(225, 169, 13)) ||
                            CheckForColor(color.rgb, vec3(255, 250, 152)) ||
                            CheckForColor(color.rgb, vec3(255, 255, 255))
                        ) {
                            #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                        } else {
                            emission = color.r + color.g - color.b * 1.5;
                            emission *= 1.8;
                            color.rg += color.b * vec2(0.4, 0.15);
                            color.b *= 0.8;
                            if (LAVA_TEMPERATURE != 0.0) maRecolor += LAVA_TEMPERATURE * 0.1;
                            emission *= LAVA_EMISSION;
                            #ifdef SOUL_SAND_VALLEY_OVERHAUL_INTERNAL
                                color.rgb = changeColorFunction(color.rgb, 2.0, colorSoul, inSoulValley);
                            #endif
                            #ifdef PURPLE_END_FIRE_INTERNAL
                                color.rgb = changeColorFunction(color.rgb, 2.0, colorEndBreath, 1.0);
                            #endif
                        }
                    }
                } else /*if (currentRenderedItemId < 46096)*/ {
                    if (currentRenderedItemId < 46092) {
                        // item.46088 = necronium
                        #include "/lib/materials/specificMaterials/terrain/necroniumBlock.glsl"
                    } else /*if (currentRenderedItemId < 46096)*/ {
                        // item.46092 = sanguine
                        #include "/lib/materials/specificMaterials/terrain/sanguineBlock.glsl"
                    }
                }
            } else /*if (currentRenderedItemId < 46112)*/ {
                if (currentRenderedItemId < 46104) {
                    if (currentRenderedItemId < 46100) {
                        // item.46096 = spinel
                        #include "/lib/materials/specificMaterials/terrain/spinelBlock.glsl"
                    } else /*if (currentRenderedItemId < 46104)*/ {
                        // item.46100 = ancient_pearl
                        smoothnessG = 1.0;
                        highlightMult = 2.0;
                        smoothnessD = 1.0;
                        
                        emission = pow2(color.b);
                    }
                } else /*if (currentRenderedItemId < 46112)*/ {
                    if (currentRenderedItemId < 46108) {
                        // item.46104 = bubble_pearl
                        smoothnessG = 1.2;
                        highlightMult = 2.0;
                        smoothnessD = 1.0;
                        
                        vec2 tSize = textureSize(tex, 0);
                        ivec2 texCoordScaled = ivec2(texCoord * tSize);
                        
                        if (texCoordScaled.x > 5 && texCoordScaled.y > 5 && texCoordScaled.x < 11 && texCoordScaled.y < 11) {
                            emission = 2.0;
                            color.rgb = pow1_5(color.rgb);
                        }
                        
                        emission = texCoordScaled.x * 0.02;
                    } else /*if (currentRenderedItemId < 46112)*/ {
                        // item.46108 = corrupted_pearl
                        emission = pow2(color.b - color.g) * 10.0 + 3.0 * (color.b - color.g);
                        
                        smoothnessG = 1.0;
                        highlightMult = 2.0;
                        smoothnessD = 1.0;
                    }
                }
            }
        } else /*if (currentRenderedItemId < 46144)*/ {
            if (currentRenderedItemId < 46128) {
                if (currentRenderedItemId < 46120) {
                    if (currentRenderedItemId < 46116) {
                        // item.46112 = crimson_pearl
                        if (color.r > 0.9) {
                            emission = 3.0 * color.g;
                            color.r *= 1.2;
                        
                            overlayNoiseIntensity = 0.5;
                        }
                        
                        smoothnessG = color.r * 0.5;
                        smoothnessD = smoothnessG;
                        highlightMult = 2.0;
                    } else /*if (currentRenderedItemId < 46120)*/ {
                        // item.46116 = icy_pearl
                        smoothnessG = pow2(color.g) * color.g;
                        smoothnessD = smoothnessG;
                        highlightMult = 2.0;
                        
                        color.a = 0.9;
                    }
                } else /*if (currentRenderedItemId < 46128)*/ {
                    if (currentRenderedItemId < 46124) {
                        // item.46120 = soul_pearl
                        smoothnessG = 1.0;
                        highlightMult = 2.0;
                        smoothnessD = 1.0;
                        
                        if (color.b > 0.6) {
                            emission = 1.5;
                            color.rgb = pow1_5(color.rgb);
                        }
                    } else /*if (currentRenderedItemId < 46128)*/ {
                        // item.46124 = summoner_pearl
                        emission = 4.0 * pow2(color.b) - 1.5 * color.g;
                        
                        smoothnessG = 1.0;
                        highlightMult = 2.0;
                        smoothnessD = 1.0;
                    }
                }
            } else /*if (currentRenderedItemId < 46144)*/ {
                if (currentRenderedItemId < 46136) {
                    if (currentRenderedItemId < 46132) {
                        // item.46128 = end_city_key
                        emission = 2.0 + 0.5 * color.r;
                        color.rgb = pow(color.rgb, vec3(1.0 + 0.6 * sqrt(emission)));
                    } else /*if (currentRenderedItemId < 46136)*/ {
                        // item.46132 = glow_berry_custard
                        lmCoordM.x *= 0.875;
                        if (color.g > 0.5 && color.r < 0.4) {
                            emission = 0.5;
                        } else {
                            emission = color.r < 0.75 ? 1.0 : 3.0;
                            color.rgb = color.rgb * vec3(1.0, 0.8, 0.6);
                        }
                    }
                } else /*if (currentRenderedItemId < 46144)*/ {
                    if (currentRenderedItemId < 46140) {
                        // item.46136 = wildfire
                        float dotColor = dot(color.rgb, color.rgb);
                        if (CheckForColor(color.rgb, vec3(221, 54, 72)) || CheckForColor(color.rgb, vec3(137, 29, 52))) {
                            emission = 4.0;
                        } else if (CheckForColor(color.rgb, vec3(255))) {
                            emission = 5.0;
                        } else {
                            float factor = smoothstep1(min1(color.r * 1.5));
                            factor = factor > 0.12 ? factor : factor * 0.5;
                            smoothnessG = factor;
                            smoothnessD = factor;
                        }
                    } else /*if (currentRenderedItemId < 46144)*/ {
                        // item.46140 = castle_key
                        emission = abs(color.r - color.b) * 3.0 + 0.1;
                        if (GetMaxColorDif(color.rgb) < 0.03) {
                            emission = color.g > 0.2 ? 3.0 * color.g : 0.0;
                        }
                        
                        color.rgb = pow(color.rgb, vec3(1.0 + 0.5 * sqrt(emission)));

                    }
                }
            }
        }
    } else /*if (currentRenderedItemId < 46208)*/ {
        if (currentRenderedItemId < 46176) {
            if (currentRenderedItemId < 46160) {
                if (currentRenderedItemId < 46152) {
                    if (currentRenderedItemId < 46148) {
                        // item.46144 = glow_flare
                        smoothnessG = 1.0;
                        smoothnessD = smoothnessG;
                        if (color.b / color.r > 1.7)
                            emission = pow2(color.b) * 1.6 + 0.2;
                    } else /*if (currentRenderedItemId < 46152)*/ {
                        // item.46148 = silver_items
                        if (color.b > 0.5 && color.g > 0.5 && color.r > 0.5) {
                            #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                        }
                    }
                } else /*if (currentRenderedItemId < 46160)*/ {
                    if (currentRenderedItemId < 46156) {
                        // item.46152 = spectre_flare
                        smoothnessG = 1.0;
                        smoothnessD = smoothnessG;
                        if (
                            CheckForColor(color.rgb, vec3(255, 243, 221)) ||
                            CheckForColor(color.rgb, vec3(237, 214, 164)) ||
                            CheckForColor(color.rgb, vec3(255, 255, 255)) ||
                            CheckForColor(color.rgb, vec3(223, 194, 115)) ||
                            CheckForColor(color.rgb, vec3(156, 205, 182)) ||
                            CheckForColor(color.rgb, vec3(146, 189, 171)) ||
                            CheckForColor(color.rgb, vec3(173, 191, 182)) ||
                            CheckForColor(color.rgb, vec3(164, 218, 190))
                        ) {
                            vec2 flickerNoise = texture2D(noisetex, vec2(frameTimeCounter * 0.02)).rb;
                            emission = emission = 1.2 + 4.0 * pow2(max0(color.b - color.r));
                        
                            // appearance of flickering
                            emission *= mix(1.0, min1(max(flickerNoise.r, flickerNoise.g) * 1.7), pow2(8 * 0.1));
                        } else {
                            emission = 0.6;
                        }
                    } else /*if (currentRenderedItemId < 46160)*/ {
                        // item.46156 = bullet_pepper
                        smoothnessG = max0(1.2 * pow2(color.b) - GetMaxColorDif(color.rgb));
                        smoothnessD = smoothnessG;
                        
                        emission = 1.5 * pow2(2.5 * max0(color.r - 0.6));
                        color.rgb = pow1_5(color.rgb);
                    }
                }
            } else /*if (currentRenderedItemId < 46176)*/ {
                if (currentRenderedItemId < 46168) {
                    if (currentRenderedItemId < 46164) {
                        // item.46160 = magma_cake
                        lmCoordM = vec2(0.75, 0.0);
                        
                        if (color.g > 0.22) { // Emissive Part
                            emission = pow2(pow2(color.r)) * 4.0;
                            color.gb *= max(2.0 - 11.0 * pow2(color.g), 0.5);
                            maRecolor = vec3(emission * 0.075);
                        
                            overlayNoiseIntensity = 0.0;
                        }
                    } else /*if (currentRenderedItemId < 46168)*/ {
                        // item.46164 = near
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
                    }
                } else /*if (currentRenderedItemId < 46176)*/ {
                    if (currentRenderedItemId < 46172) {
                        // item.46168 = soul_berry
                        if (color.b - color.r > 0.1) {
                            emission = 3.5 * (color.b + 0.4);
                            color.rgb *= color.rgb;
                        }
                        
                        if (color.r > 0.64 && color.r > color.b && color.r > color.g && mat % 4 == 1) {
                            emission = color.r < 0.75 ? 2.5 : 6.0;
                        }

                    } else /*if (currentRenderedItemId < 46176)*/ {
                        // item.46172 = banshee_powder
                        if (color.b - color.r > 0.1 || CheckForColor(color.rgb, vec3(255))) {
                            emission = 2.0 * sqrt1(color.b) + 1.5 * pow2(pow2(5 * max0(color.b - 0.9)));
                            color.rgb *= pow(color.rgb, vec3(pow2(emission / 3.5)));
                        }
                    }
                }
            }
        } else /*if (currentRenderedItemId < 46208)*/ {
            if (currentRenderedItemId < 46192) {
                if (currentRenderedItemId < 46184) {
                    if (currentRenderedItemId < 46180) {
                        // item.46176 = ectoplasm_bucket
                        if (GetMaxColorDif(color.rgb) < 0.01) {
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                        } else {
                            lmCoordM = vec2(0.0);
                        
                            emission = smoothstep1(sqrt1(color.b)) + 0.2;
                            emission *= 2.0;
                        
                            color.rgb *= pow(color.rgb, vec3(0.5 + 0.3 * emission));
                        }
                    } else /*if (currentRenderedItemId < 46184)*/ {
                        // item.46180 = glowcheese
                        if (color.r > 0.77 && color.r < color.g * 2.0) {
                            emission = pow2(color.r) + pow2(color.g);
                        }
                    }
                } else /*if (currentRenderedItemId < 46192)*/ {
                    if (currentRenderedItemId < 46188) {
                        // item.46184 = sanctum_compass
                        if (color.b - color.r > 0.1) {
                            emission = 2.5 * color.b;
                        }
                    } else /*if (currentRenderedItemId < 46192)*/ {
                        // item.46188 = spores
                        float dotColor = dot(color.rgb, color.rgb);
                        emission = min(pow2(pow2(pow2(dotColor * 0.6))), 6.0) * 0.8 + 0.5;
                    }
                }
            } else /*if (currentRenderedItemId < 46208)*/ {
                if (currentRenderedItemId < 46200) {
                    if (currentRenderedItemId < 46196) {
                        // item.46192 = treacherous_flame
                        emission = 4.00 * pow2(pow2(color.r)) + 1.50;
                        color.rgb *= color.rgb;
                        
                        overlayNoiseIntensity = 0.0;
                    } else /*if (currentRenderedItemId < 46200)*/ {
                        // item.46196 = lead_items
                        #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                    }
                } else /*if (currentRenderedItemId < 46208)*/ {
                    if (currentRenderedItemId < 46204) {
                        // item.46200 = lead_items
                        #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                    } else /*if (currentRenderedItemId < 46208)*/ {
                        // item.46204 = molten_lead_bucket
                        if (GetMaxColorDif(color.rgb) < 0.01) {
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                        } else {
                            float emissiveness = 5.0;
                            #include "/lib/materials/specificMaterials/terrain/moltenLead.glsl"
                        }
                    }
                }
            }
        }
    }
} else /*if (currentRenderedItemId < 46336)*/ {
    if (currentRenderedItemId < 46272) {
        if (currentRenderedItemId < 46240) {
            if (currentRenderedItemId < 46224) {
                if (currentRenderedItemId < 46216) {
                    if (currentRenderedItemId < 46212) {
                        // item.46208 = silver_mirror
                        if (color.r - color.b > 0.25) {
                            #include "/lib/materials/specificMaterials/terrain/leadBlock.glsl"
                        } else {
                            #include "/lib/materials/specificMaterials/terrain/silverBlock.glsl"
                        }
                    } else /*if (currentRenderedItemId < 46216)*/ {
                        // item.46212 = heart_of_diamond
                        if (color.g > 0.6 || color.b > 0.6) {
                            #include "/lib/materials/specificMaterials/terrain/diamondBlock.glsl"
                            emission = pow2(max(color.b, color.g)) + 1.5;
                        }
                    }
                } else /*if (currentRenderedItemId < 46224)*/ {
                    if (currentRenderedItemId < 46220) {
                        // item.46216 = nether_dust
                        if (GetMaxColorDif(color.rgb) < 0.05) {
                            emission = dot(color.rgb, color.rgb) * 0.6;
                        } else {
                            emission = pow2(color.r) * 3.0;
                        }
                        
                        color.rgb *= pow(color.rgb, vec3(0.3 * emission));
                    } else /*if (currentRenderedItemId < 46224)*/ {
                        // item.46220 = blast_proof_plating
                        #include "/lib/materials/specificMaterials/terrain/blastProofPlates.glsl"
                    }
                }
            } else /*if (currentRenderedItemId < 46240)*/ {
                if (currentRenderedItemId < 46232) {
                    if (currentRenderedItemId < 46228) {
                        // item.46224 = lumisene_bottle
                        smoothnessG = 1.0;
                        smoothnessD = smoothnessG;
                        color.rgb *= pow2(color.rgb);
                        emission = 1.0 / (0.7 + pow3(color.r - 1.0) + pow3(color.b) + pow3(color.g)) +
                                   1.0 / (0.7 + pow3(color.g - 1.0) + pow3(color.b) + pow3(color.r)) +
                                   1.0 / (0.7 + pow3(color.b - 1.0) + pow3(color.r) + pow3(color.g));
                    } else /*if (currentRenderedItemId < 46232)*/ {
                        // item.46228 = lumisene_bucket
                        if (GetMaxColorDif(color.rgb) < 0.01) {
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                        } else {
                            color.rgb *= pow2(color.rgb);
                            emission = 1.0 / (0.9 + pow3(color.r - 1.0) + pow3(color.b) + pow3(color.g)) +
                                    1.0 / (0.9 + pow3(color.g - 1.0) + pow3(color.b) + pow3(color.r)) +
                                    1.0 / (0.9 + pow3(color.b - 1.0) + pow3(color.r) + pow3(color.g));
                        }
                    }
                } else /*if (currentRenderedItemId < 46240)*/ {
                    if (currentRenderedItemId < 46236) {
                        // item.46232 = glow_squid_bucket
                        if (GetMaxColorDif(color.rgb) < 0.01) {
                            #include "/lib/materials/specificMaterials/terrain/ironBlock.glsl"
                        } else {
                            emission = color.g > 0.98 ? 2.5 * pow2(color.b) : 0.0;
                        }
                    } else /*if (currentRenderedItemId < 46240)*/ {
                        // item.46236 = ancient_metal
                        #include "/lib/materials/specificMaterials/terrain/copperBlock.glsl"
                        
                        smoothnessG *= 1.3;
                        smoothnessD *= 1.3;
                    }
                }
            }
        } else /*if (currentRenderedItemId < 46272)*/ {
            if (currentRenderedItemId < 46256) {
                if (currentRenderedItemId < 46248) {
                    if (currentRenderedItemId < 46244) {
                        // item.46240
                    } else /*if (currentRenderedItemId < 46248)*/ {
                        // item.46244
                    }
                } else /*if (currentRenderedItemId < 46256)*/ {
                    if (currentRenderedItemId < 46252) {
                        // item.46248
                    } else /*if (currentRenderedItemId < 46256)*/ {
                        // item.46252
                    }
                }
            } else /*if (currentRenderedItemId < 46272)*/ {
                if (currentRenderedItemId < 46264) {
                    if (currentRenderedItemId < 46260) {
                        // item.46256
                    } else /*if (currentRenderedItemId < 46264)*/ {
                        // item.46260
                    }
                } else /*if (currentRenderedItemId < 46272)*/ {
                    if (currentRenderedItemId < 46268) {
                        // item.46264
                    } else /*if (currentRenderedItemId < 46272)*/ {
                        // item.46268
                    }
                }
            }
        }
    } else /*if (currentRenderedItemId < 46336)*/ {
        if (currentRenderedItemId < 46304) {
            if (currentRenderedItemId < 46288) {
                if (currentRenderedItemId < 46280) {
                    if (currentRenderedItemId < 46276) {
                        // item.46272
                    } else /*if (currentRenderedItemId < 46280)*/ {
                        // item.46276
                    }
                } else /*if (currentRenderedItemId < 46288)*/ {
                    if (currentRenderedItemId < 46284) {
                        // item.46280
                    } else /*if (currentRenderedItemId < 46288)*/ {
                        // item.46284
                    }
                }
            } else /*if (currentRenderedItemId < 46304)*/ {
                if (currentRenderedItemId < 46296) {
                    if (currentRenderedItemId < 46292) {
                        // item.46288
                    } else /*if (currentRenderedItemId < 46296)*/ {
                        // item.46292
                    }
                } else /*if (currentRenderedItemId < 46304)*/ {
                    if (currentRenderedItemId < 46300) {
                        // item.46296
                    } else /*if (currentRenderedItemId < 46304)*/ {
                        // item.46300
                    }
                }
            }
        } else /*if (currentRenderedItemId < 46336)*/ {
            if (currentRenderedItemId < 46320) {
                if (currentRenderedItemId < 46312) {
                    if (currentRenderedItemId < 46308) {
                        // item.46304
                    } else /*if (currentRenderedItemId < 46312)*/ {
                        // item.46308
                    }
                } else /*if (currentRenderedItemId < 46320)*/ {
                    if (currentRenderedItemId < 46316) {
                        // item.46312
                    } else /*if (currentRenderedItemId < 46320)*/ {
                        // item.46316
                    }
                }
            } else /*if (currentRenderedItemId < 46336)*/ {
                if (currentRenderedItemId < 46328) {
                    if (currentRenderedItemId < 46324) {
                        // item.46320
                    } else /*if (currentRenderedItemId < 46328)*/ {
                        // item.46324
                    }
                } else /*if (currentRenderedItemId < 46336)*/ {
                    if (currentRenderedItemId < 46332) {
                        // item.46328
                    } else /*if (currentRenderedItemId < 46336)*/ {
                        // item.46332
                    }
                }
            }
        }
    }
}
