#include "/lib/shaderSettings/water.glsl"
if (mat < 32008) {
    if (mat < 30016) {
        if (mat < 30008) {
            if (mat == 30000) { //

            } else if (mat == 30004) { //

            }
        } else {
            if (mat == 30008) { // Tinted Glass
                #ifdef CONNECTED_GLASS_EFFECT
                    uint voxelID = uint(60054);
                    bool isPane = false;
                    DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelID, isPane);
                #endif
                color.a = pow(color.a, 1.0 - fresnel * 0.65);
                reflectMult = 0.75;
                overlayNoiseAlpha = 0.95;
                sandNoiseIntensity = 0.5;
                mossNoiseIntensity = 0.5;
            } else /*if (mat == 30012)*/ { // Slime Block
                translucentMultCalculated = true;
                reflectMult = 0.7;
                translucentMult.rgb = pow2(color.rgb) * 0.2;

                smoothnessG = color.g * 0.7;
                highlightMult = 2.5;
                overlayNoiseAlpha = 0.6;
                sandNoiseIntensity = 0.5;
                mossNoiseIntensity = 0.5;
            }
        }
    } else {
        if (mat < 32000) {
            if (mat < 31000) {
                if (mat == 30016) { // Honey Block
                    translucentMultCalculated = true;
                    reflectMult = 1.0;
                    translucentMult.rgb = pow2(color.rgb) * 0.2;

                    smoothnessG = color.r * 0.7;
                    highlightMult = 2.5;
                    overlayNoiseAlpha = 0.4;
                    sandNoiseIntensity = 0.5;
                    mossNoiseIntensity = 0.5;
                } else /*if (mat == 30020)*/ { // Nether Portal
                    #ifdef SPECIAL_PORTAL_EFFECTS
                        #include "/lib/materials/specificMaterials/translucents/netherPortal.glsl"
                    #endif
                    overlayNoiseIntensity = 0.0;
                }
            } else { // (31XXX)
                if (mat % 2 == 0) { // Stained Glass
                    #ifdef CONNECTED_GLASS_EFFECT
                        uint voxelID = uint(60000 + (mat - 31000) / 2);
                        bool isPane = false;
                        DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelID, isPane);
                    #endif
                    #include "/lib/materials/specificMaterials/translucents/stainedGlass.glsl"
                    overlayNoiseAlpha = 1.05;
                    mossNoiseIntensity = 0.8;
                } else /*if (mat % 2 == 1)*/ { // Stained Glass Pane
                    #ifdef CONNECTED_GLASS_EFFECT
                        uint voxelID = uint(60000 + (mat - 31000) / 2);
                        bool isPane = true;
                        DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelID, isPane);
                    #endif
                    #include "/lib/materials/specificMaterials/translucents/stainedGlass.glsl"
                    noSmoothLighting = true;
                    overlayNoiseAlpha = 1.05;
                    sandNoiseIntensity = 0.8;
                    mossNoiseIntensity = 0.8;
                }
            }
        } else {
            if (mat == 32000) { // Water
                #ifdef SHADER_WATER
                    #include "/lib/materials/specificMaterials/translucents/water.glsl"
                #endif
                overlayNoiseIntensity = 0.0;
                overlayNoiseFresnelMult = 0.0;
                IPBRMult = 0.0;
                overlayNoiseAlpha = 0.0;
            } else /*if (mat == 32004)*/ { // Ice
                smoothnessG = pow2(color.g) * color.g;
                highlightMult = pow2(min1(pow2(color.g) * 1.5)) * 3.5;

                reflectMult = 0.7;
                overlayNoiseAlpha = 0.6;
                sandNoiseIntensity = 0.7;
                mossNoiseIntensity = 0.7;
            }
        }
    }
} else if (mat < 32064) {
    if (mat < 32024) {
        if (mat < 32016) {
            if (mat < 32012) { // Glass
                if (mat == 32008){
                    #ifdef CONNECTED_GLASS_EFFECT
                        uint voxelID = uint(60017);
                        bool isPane = false;
                        DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelID, isPane);
                    #endif
                }
                #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                overlayNoiseAlpha = 0.8;
                sandNoiseIntensity = 0.8;
                mossNoiseIntensity = 0.8;
            } else /*if (mat == 32012)*/ { // Glass Pane
                if (mat == 32012) {
                    #ifdef CONNECTED_GLASS_EFFECT
                        uint voxelID = uint(60018);
                        bool isPane = true;
                        DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelID, isPane);
                    #endif
                }
                if (color.a < 0.001 && abs(NdotU) > 0.95) discard; // Fixing artifacts on CTM/Opti connected glass panes
                #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                noSmoothLighting = true;
                overlayNoiseAlpha = 0.8;
                sandNoiseIntensity = 0.8;
                mossNoiseIntensity = 0.8;
            }
        } else {
            if (mat == 32016) { // Beacon
                lmCoordM.x = 0.88;

                translucentMultCalculated = true;
                translucentMult = vec4(0.0, 0.0, 0.0, 1.0);

                if (color.b > 0.5) {
                    if (color.g - color.b < 0.01 && color.g < 0.99) {
                        #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                    } else { // Beacon:Center
                        lmCoordM = vec2(0.0);
                        noDirectionalShading = true;

                        float lColor = length(color.rgb);
                        vec3 baseColor = vec3(0.1, 1.0, 0.92);
                        if (lColor > 1.5)       color.rgb = baseColor + 0.22;
                        else if (lColor > 1.3)  color.rgb = baseColor + 0.15;
                        else if (lColor > 1.15) color.rgb = baseColor + 0.09;
                        else                    color.rgb = baseColor + 0.05;
                        emission = 4.0;
                    }
                } else { // Beacon:Obsidian
                    float factor = color.r * 1.5;

                    smoothnessG = factor;
                    highlightMult = 2.0 + min1(smoothnessG * 2.0) * 1.5;
                    smoothnessG = min1(smoothnessG);
                }
                overlayNoiseAlpha = 0.8;
                sandNoiseIntensity = 0.5;
                mossNoiseIntensity = 0.5;
            } else /*if (mat == 32020)*/ { //

            }
        }
    } else {
        if (mat < 32032) {
            if (mat == 32024) { //

            } else /*if (mat == 32028)*/ { //

            }
        } else {
            if (mat == 32032) { //

            } else /*if (mat == 32036)*/ { //

            }
        }
    }
} else if (mat < 32256) {
    if (mat < 32192) {
        if (mat < 32160) {
            // block.32128 = stained_glass_dye_depot
            const uint voxelNumbers[32] = uint[](60020u, 60020u, 60021u, 60021u, 60022u, 60022u, 60023u, 60023u, 60024u, 60024u, 60025u, 60025u, 60026u, 60026u, 60027u, 60027u, 60028u, 60028u, 60029u, 60029u, 60030u, 60030u, 60031u, 60031u, 60032u, 60032u, 60033u, 60033u, 60034u, 60034u, 60035u, 60035u);
            uint voxelNumber = voxelNumbers[mat % 4];
            #ifdef CONNECTED_GLASS_EFFECT
                bool isPane = mat % 2 == 1;
                DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelNumber, isPane);
            #endif
            
            #include "/lib/materials/specificMaterials/translucents/stainedGlass.glsl"
            overlayNoiseAlpha = 1.05;
            sandNoiseIntensity = 0.8;
            mossNoiseIntensity = 0.8;
        } else /*if (mat < 32192)*/ {
            // block.32160 = crystal_glass
            smoothnessG = 1.0;
            highlightMult = 3.5;
            reflectMult = 0.5;
            
            translucentMultCalculated = true;
            translucentMult.rgb = smoothstep1(color.rgb);
            
            color.rgb *= 0.7 + 0.3 * GetLuminance(color.rgb);
            color.a = CRYSTAL_GLASS_OPACITY;
        }
    } else /*if (mat < 32256)*/ {
        if (mat < 32224) {
            // block.32192 = stained_framed_glass
            if (color.a > 0.8) {
                smoothnessG = color.r;
                reflectMult = 1.0;
                highlightMult = 1.0;
            } else {
                #include "/lib/materials/specificMaterials/translucents/stainedGlass.glsl"
                overlayNoiseAlpha = 1.05;
                sandNoiseIntensity = 0.8;
                mossNoiseIntensity = 0.8;
            }
        } else /*if (mat < 32256)*/ {
            if (mat < 32240) {
                // block.32224 = crystal_lamps
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
                
                bool lit = mat % 2 == 0;
                #include "/lib/materials/specificMaterials/terrain/corundumCrystalLamps.glsl"
            } else /*if (mat < 32256)*/ {
                if (mat < 32248) {
                    // block.32240 = corundum_block
                    float factor;
                    if (mat % 8 < 4) {
                        factor = color.b;
                    } else if (mat % 4 < 2) {
                        factor = 0.8 * color.g + 0.2 * color.r;
                    } else if (mat % 4 == 2) {
                        factor = color.g;
                    } else {
                        factor = (color.r + color.b + color.g) / 3;
                    }
                    
                    #include "/lib/materials/specificMaterials/terrain/corundumBlock.glsl"
                } else /*if (mat < 32256)*/ {
                    if (mat < 32252) {
                        // block.32248 = blood
                        smoothnessG = color.r;
                        
                        translucentMultCalculated = true;
                        reflectMult = 0.6 * color.r;
                        translucentMult.rgb = pow2(color.rgb);
                    } else /*if (mat < 32256)*/ {
                        // block.32252 = honey_lamp
                        if (color.a < 0.05) {
                            if (color.r > 0.78) {
                                #ifdef GBUFFERS_TERRAIN
                                    float colorG2 = pow2(color.g);
                                #else
                                    float colorG2 = color.g;
                                #endif
                        
                                float colorG4 = pow2(colorG2);
                                float factor = max(color.g, 0.8);
                        
                                smoothnessG = min1(factor - colorG4 * 0.5);
                                highlightMult = 3.5 * max(colorG4, 0.2);
                        
                                color.rgb *= 0.5 + 0.4 * GetLuminance(color.rgb);
                            } else {
                                emission = 5.0;
                            }
                        } else {
                            translucentMultCalculated = true;
                            reflectMult = 1.0;
                            translucentMult.rgb = pow2(color.rgb) * 0.2;
                        
                            smoothnessG = color.r * 0.7;
                            highlightMult = 2.5;
                            overlayNoiseAlpha = 0.4;
                            sandNoiseIntensity = 0.5;
                            mossNoiseIntensity = 0.5;
                        }
                    }
                }
            }
        }
    }
} else /*if (mat < 32384)*/ {
    if (mat < 32320) {
        if (mat < 32288) {
            if (mat < 32272) {
                if (mat < 32264) {
                    if (mat < 32260) {
                        // block.32256 = poise_cluster
                        smoothnessG = 0.3 * color.r;
                        
                        translucentMultCalculated = true;
                        reflectMult = pow2(color.r - color.g);
                        translucentMult.rgb = pow2(color.rgb);
                        
                        highlightMult = 2.5;
                        overlayNoiseAlpha = 0.4;
                        sandNoiseIntensity = 0.2;
                        mossNoiseIntensity = 0.2;
                    } else /*if (mat < 32264)*/ {
                        // block.32260 = drift_jelly_block
                        smoothnessG = 0.6 * pow2(color.g);
                        
                        translucentMultCalculated = true;
                        reflectMult = smoothnessG;
                        translucentMult.rgb = pow1_5(color.rgb) * 0.6;
                        
                        highlightMult = 2.5;
                        overlayNoiseAlpha = 0.4;
                        sandNoiseIntensity = 0.2;
                        mossNoiseIntensity = 0.2;
                    }
                } else /*if (mat < 32272)*/ {
                    if (mat < 32268) {
                        // block.32264 = ice_pane
                        const uint voxelNumbers[4] = uint[](60023u, 60023u, 60023u, 60023u);
                        uint voxelNumber = voxelNumbers[mat % 4];
                        #ifdef CONNECTED_GLASS_EFFECT
                            DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelNumber, true);
                        #endif
                        
                        noSmoothLighting = true;
                        
                        smoothnessG = pow2(color.g) * color.g;
                        highlightMult = pow2(min1(pow2(color.g) * 1.5)) * 3.5;
                        reflectMult = 0.7;
                        overlayNoiseAlpha = 0.6;
                        sandNoiseIntensity = 0.7;
                        mossNoiseIntensity = 0.7;
                    } else /*if (mat < 32272)*/ {
                        // block.32268 = stranded_membrane_block
                        translucentMultCalculated = true;
                        reflectMult = 2.5 - pow2(color.r);
                        translucentMult.rgb = pow2(color.rgb) * 0.2;
                        
                        smoothnessG = min(0, 1.5 * color.b - color.r) * 0.8;
                        highlightMult = 2.5;
                        overlayNoiseAlpha = 0.4;
                        sandNoiseIntensity = 0.5;
                        mossNoiseIntensity = 0.5;
                    }
                }
            } else /*if (mat < 32288)*/ {
                if (mat < 32280) {
                    if (mat < 32276) {
                        // block.32272 = gelatin
                        translucentMultCalculated = true;
                        reflectMult = 0.7;
                        translucentMult.rgb = pow2(color.rgb) * 0.25;
                        
                        smoothnessG = pow2(color.b) * 0.8;
                        highlightMult = 2.5;
                        overlayNoiseAlpha = 0.6;
                        sandNoiseIntensity = 0.5;
                        mossNoiseIntensity = 0.5;
                    } else /*if (mat < 32280)*/ {
                        // block.32276 = discernment_glass
                        if (color.b > color.r) {
                            #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                            color.a = pow(color.a, 1.0 - fresnel * 0.8);
                        
                            overlayNoiseAlpha = 0.8;
                            sandNoiseIntensity = 0.8;
                            mossNoiseIntensity = 0.8;
                        } else {
                            float factor = pow2(color.g) * 0.6;
                        
                            smoothnessG = factor;
                            highlightMult = 1.0 + 2.5 * factor;
                        }
                    }
                } else /*if (mat < 32288)*/ {
                    if (mat < 32284) {
                        // block.32280 = soul_glass
                        if (color.b > color.r) {
                            #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                            color.a = pow(color.a, 1.0 - fresnel * 0.8);
                        
                            overlayNoiseAlpha = 0.8;
                            sandNoiseIntensity = 0.8;
                            mossNoiseIntensity = 0.8;
                        
                            if (mat % 4 == 2) {
                                emission = pow1_5(color.b);
                            }
                        } else {
                            smoothnessG = 1.2 * smoothstep1(min1(1.3 * max0(color.r - 0.18)));
                        }
                    } else /*if (mat < 32288)*/ {
                        // block.32284 = thin_black_ice
                        smoothnessG = pow3(5.0 * color.g);
                        highlightMult = pow2(min1(pow2(color.g) * 1.5)) * 3.5;
                        
                        reflectMult = 0.7;
                        overlayNoiseAlpha = 0.6;
                        sandNoiseIntensity = 0.7;
                        mossNoiseIntensity = 0.7;
                    }
                }
            }
        } else /*if (mat < 32320)*/ {
            if (mat < 32304) {
                if (mat < 32296) {
                    if (mat < 32292) {
                        // block.32288 = white_corundum
                        bool lit = mat % 2 == 0;
                        float factor = (color.r + color.b + color.g) / 2.3;
                        
                        if (mat % 4 == 2) {
                            #include "/lib/materials/specificMaterials/terrain/corundumBlock.glsl"
                        } else {
                            #include "/lib/materials/specificMaterials/terrain/corundumCrystalLamps.glsl"
                        }
                    } else /*if (mat < 32296)*/ {
                        // block.32292 = dirty_glass
                        const uint voxelNumbers[4] = uint[](60071u, 60071u, 60071u, 60071u);
                        uint voxelNumber = voxelNumbers[mat % 4];
                        bool isPane = mat % 4 == 2;
                        #ifdef CONNECTED_GLASS_EFFECT
                            DoConnectedGlass(colorP, color, noGeneratedNormals, playerPos, worldGeoNormal, voxelNumber, isPane);
                        #endif
                        
                        smoothnessG = 0.3 * pow2(color.r);
                        highlightMult = smoothnessG + 0.1;
                        reflectMult = 0.1;
                        
                        overlayNoiseAlpha = 1.25;
                        sandNoiseIntensity = 0.8;
                        mossNoiseIntensity = 0.8;
                        
                        noSmoothLighting = isPane;

                    }
                } else /*if (mat < 32304)*/ {
                    if (mat < 32300) {
                        // block.32296 = framed_glass
                        if (
                            CheckForColor(color.rgb, vec3(57, 54, 52)) ||
                            CheckForColor(color.rgb, vec3(65, 68, 69)) ||
                            CheckForColor(color.rgb, vec3(71, 79, 82)) ||
                            CheckForColor(color.rgb, vec3(44, 40, 37)) ||
                            CheckForColor(color.rgb, vec3(64, 67, 68)) ||
                            CheckForColor(color.rgb, vec3(43, 40, 37)) ||
                            CheckForColor(color.rgb, vec3(33, 35, 31)) ||
                            CheckForColor(color.rgb, vec3(55, 55, 55))
                        ) {
                            smoothnessG = color.r;
                        } else {
                            #include "/lib/materials/specificMaterials/translucents/glass.glsl"
                        
                            overlayNoiseAlpha = 0.8;
                            sandNoiseIntensity = 0.8;
                            mossNoiseIntensity = 0.8;
                        }
                    } else /*if (mat < 32304)*/ {
                        // block.32300 = myalite_crystal
                        smoothnessG = 2.5 * color.b;
                        highlightMult = 3.0 * pow2(pow2(color.r)) * smoothnessG;
                        
                        translucentMultCalculated = true;
                        reflectMult = 0.8;
                        translucentMult.rgb = pow2(color.rgb);
                        
                        overlayNoiseAlpha = 0.4;
                    }
                }
            } else /*if (mat < 32320)*/ {
                if (mat < 32312) {
                    if (mat < 32308) {
                        // block.32304 = volcanic_ice
                        smoothnessG = pow2(color.g) * pow2(color.g);
                        highlightMult = min1(pow2(color.g) * 1.5) * 2.0;
                        
                        reflectMult = 0.7;
                        overlayNoiseAlpha = 0.6;
                        sandNoiseIntensity = 0.8;
                        mossNoiseIntensity = 0.8;
                    } else /*if (mat < 32312)*/ {
                        // block.32308 = lumisene
                        #include "/lib/materials/specificMaterials/terrain/lumisene.glsl"
                    }
                } else /*if (mat < 32320)*/ {
                    if (mat < 32316) {
                        // block.32312 = aria_mushroom
                        emission = 2.0 * pow2(color.r) + 0.2 * pow2(color.b);
                        smoothnessG = 0.3 * color.r;
                        
                        translucentMultCalculated = true;
                        reflectMult = max0(1.2 - emission);
                        translucentMult.rgb = pow2(color.rgb) * 0.4;
                        
                        highlightMult = 2.5;
                        overlayNoiseAlpha = 0.4;
                        sandNoiseIntensity = 0.5;
                        mossNoiseIntensity = 0.5;
                    } else /*if (mat < 32320)*/ {
                        // block.32316
                    }
                }
            }
        }
    } else /*if (mat < 32384)*/ {
        if (mat < 32352) {
            if (mat < 32336) {
                if (mat < 32328) {
                    if (mat < 32324) {
                        // block.32320
                    } else /*if (mat < 32328)*/ {
                        // block.32324
                    }
                } else /*if (mat < 32336)*/ {
                    if (mat < 32332) {
                        // block.32328
                    } else /*if (mat < 32336)*/ {
                        // block.32332
                    }
                }
            } else /*if (mat < 32352)*/ {
                if (mat < 32344) {
                    if (mat < 32340) {
                        // block.32336
                    } else /*if (mat < 32344)*/ {
                        // block.32340
                    }
                } else /*if (mat < 32352)*/ {
                    if (mat < 32348) {
                        // block.32344
                    } else /*if (mat < 32352)*/ {
                        // block.32348
                    }
                }
            }
        } else /*if (mat < 32384)*/ {
            if (mat < 32368) {
                if (mat < 32360) {
                    if (mat < 32356) {
                        // block.32352
                    } else /*if (mat < 32360)*/ {
                        // block.32356
                    }
                } else /*if (mat < 32368)*/ {
                    if (mat < 32364) {
                        // block.32360
                    } else /*if (mat < 32368)*/ {
                        // block.32364
                    }
                }
            } else /*if (mat < 32384)*/ {
                if (mat < 32376) {
                    if (mat < 32372) {
                        // block.32368
                    } else /*if (mat < 32376)*/ {
                        // block.32372
                    }
                } else /*if (mat < 32384)*/ {
                    if (mat < 32380) {
                        // block.32376
                    } else /*if (mat < 32384)*/ {
                        // block.32380
                    }
                }
            }
        }
    }
}
