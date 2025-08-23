if (blockEntityId < 5028) {
    if (blockEntityId < 5012) {
        if (blockEntityId < 5004) {
            if (blockEntityId == 5000) { //

            } else { // blockEntityId < 5000

            }
        } else {
            if (blockEntityId == 5004) { // Signs
                noSmoothLighting = true;

                if (glColor.r + glColor.g + glColor.b <= 2.99 || lmCoord.x > 0.999) { // Sign Text
                    #include "/lib/materials/specificMaterials/others/signText.glsl"
                }

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
            } else /*if (blockEntityId == 5008)*/ { // Chest
                noSmoothLighting = true;

                smoothnessG = pow2(color.g);

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
                redstoneIPBR(color.rgb, emission);
            }
        }
    } else {
        if (blockEntityId < 5020) {
            if (blockEntityId == 5012) { // Ender Chest
                noSmoothLighting = true;

                float factor = min(pow2(color.g), 0.25);
                smoothnessG = factor * 2.0;

                if (color.g > color.r || color.b > color.g)
                    emission = pow2(factor) * 20.0;
                emission += 0.35;
                #if SEASONS == 1 || SEASONS == 4 || defined MOSS_NOISE_INTERNAL || defined SAND_NOISE_INTERNAL
                    overlayNoiseIntensity = 0.7;
                    if (dot(normal, upVec) > 0.99) {
                        #if SNOW_CONDITION < 2 && SNOW_CONDITION != 0
                            emission = mix(emission, emission * 0.8, inSnowy);
                        #elif SNOW_CONDITION == 0
                            emission = mix(emission, emission * 0.8, rainFactor * inSnowy);
                        #else
                            emission *= 0.8;
                        #endif
                    }
                #endif

                #ifdef COATED_TEXTURES
                    noiseFactor = 0.66;
                #endif
            } else /*if (blockEntityId == 5016)*/ { // Shulker Box+, Banner+, Head+, Bed+
                noSmoothLighting = true;
                #ifdef COATED_TEXTURES
                    noiseFactor = 0.2;
                #endif
            }
        } else {
            if (blockEntityId == 5020) { // Conduit
                noSmoothLighting = true;
                lmCoordM.x = 0.9;

                if (color.b > color.r) { // Conduit:Wind, Conduit:Blue Pixels of The Eye
                    emission = color.r * 16.0;
                } else if (color.r > color.b * 2.5) { // Conduit:Red Pixels of The Eye
                    emission = 20.0;
                    color.rgb *= vec3(1.0, 0.25, 0.1);
                }
                overlayNoiseIntensity = 0.3;
            } else /*if (blockEntityId == 5024)*/ { // End Portal, End Gateway
                #ifdef SPECIAL_PORTAL_EFFECTS
                    #include "/lib/materials/specificMaterials/others/endPortalEffect.glsl"
                #endif
                overlayNoiseIntensity = 0.0;
            }
        }
    }
} else if (blockEntityId < 60064) {
    if (blockEntityId < 5044) {
        if (blockEntityId < 5036) {
            if (blockEntityId == 5028) { // Bell
                if (color.r + color.g > color.b + 0.5) { // Bell:Golden Part
                    #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                } else {
                    #include "/lib/materials/specificMaterials/terrain/stone.glsl"
                }
            } else /*if (blockEntityId == 5032)*/ { //
            
            }
        } else {
            if (blockEntityId == 5036) { //
            
            } else /*if (blockEntityId == 5040)*/ { //

            }
        }
    } else {
        if (blockEntityId < 5052) {
            if (blockEntityId == 5044) { //

            } else /*if (blockEntityId == 5048)*/ { //

            }
        } else {
            if (blockEntityId == 5052) { //

            } else if (blockEntityId == 10548) { // Enchanting Table:Book
                smoothnessG = pow2(color.g) * 0.35;

                if (color.b < 0.0001 && color.r > color.g) {
                    emission = color.g * 4.0;
                }
                overlayNoiseIntensity = 0.3;
            }
        }
    }
} else if (blockEntityId < 5184) {
    if (blockEntityId < 5120) {
        if (blockEntityId < 5088) {
            if (blockEntityId < 5072) {
                if (blockEntityId < 5064) {
                    if (blockEntityId < 5060) {
                        // block.5056 = aquarium
                        vec3 fractPos = 2 * fract(worldPos) - 1;
                        float dist = max(max(abs(fractPos.x), abs(fractPos.y)), abs(fractPos.z));
                        if (dist > 0.875) {
                            smoothnessG = 1.0;
                            highlightMult = 3.5;
                            smoothnessD = smoothnessG;
                        }
                    } else /*if (blockEntityId < 5064)*/ {
                        // block.5060 = bolloom_bud
                        if (color.g > 0.65 && color.g * 1.2 > color.r) {
                            float dotColor = dot(color.rgb, color.rgb);
                            emission = pow2(pow2(dotColor * 0.5)) + 0.6 * dotColor;
                        }
                    }
                } else /*if (blockEntityId < 5072)*/ {
                    if (blockEntityId < 5068) {
                        // block.5064 = bubble_block
                        materialMask = OSIEBCA; // Intense Fresnel
                        
                        // TODO improve colour change effect on bubble blocks
                        float fresnel = clamp(1.0 + dot(normalM, normalize(viewPos)), 0.0, 1.0);
                        color.r = clamp(color.r * (1.0 - fresnel), 0.0, 1.0);
                        color.g = clamp(color.g * (1.0 + fresnel), 0.0, 1.0);
                        emission = fresnel;
                        
                        smoothnessG = 1.0;
                        smoothnessD = smoothnessG;
                    } else /*if (blockEntityId < 5072)*/ {
                        // block.5068 = coffin
                        if (color.r > 0.5 && blockEntityId % 4 != 1) {
                            emission = 7.0;
                            color.rgb *= color.rgb;
                        } else if (color.b - color.r > 0.05) {
                            smoothnessG = color.b + 0.2;
                            smoothnessD = smoothnessG;
                        } else {
                            #include "/lib/materials/specificMaterials/terrain/cobblestone.glsl"
                        }
                    }
                }
            } else /*if (blockEntityId < 5088)*/ {
                if (blockEntityId < 5080) {
                    if (blockEntityId < 5076) {
                        // block.5072 = gilded_beads
                        const uint voxelNumbers[4] = uint[](364u, 365u, 366u, 367u);
                        uint voxelNumber = voxelNumbers[mat % 4];
                        noSmoothLighting = true;
                        #include "/lib/materials/specificMaterials/terrain/goldBlock.glsl"
                    } else /*if (blockEntityId < 5080)*/ {
                        // block.5076
                    }
                } else /*if (blockEntityId < 5088)*/ {
                    if (blockEntityId < 5084) {
                        // block.5080
                    } else /*if (blockEntityId < 5088)*/ {
                        // block.5084
                    }
                }
            }
        } else /*if (blockEntityId < 5120)*/ {
            if (blockEntityId < 5104) {
                if (blockEntityId < 5096) {
                    if (blockEntityId < 5092) {
                        // block.5088
                    } else /*if (blockEntityId < 5096)*/ {
                        // block.5092
                    }
                } else /*if (blockEntityId < 5104)*/ {
                    if (blockEntityId < 5100) {
                        // block.5096
                    } else /*if (blockEntityId < 5104)*/ {
                        // block.5100
                    }
                }
            } else /*if (blockEntityId < 5120)*/ {
                if (blockEntityId < 5112) {
                    if (blockEntityId < 5108) {
                        // block.5104
                    } else /*if (blockEntityId < 5112)*/ {
                        // block.5108
                    }
                } else /*if (blockEntityId < 5120)*/ {
                    if (blockEntityId < 5116) {
                        // block.5112
                    } else /*if (blockEntityId < 5120)*/ {
                        // block.5116
                    }
                }
            }
        }
    } else /*if (blockEntityId < 5184)*/ {
        if (blockEntityId < 5152) {
            if (blockEntityId < 5136) {
                if (blockEntityId < 5128) {
                    if (blockEntityId < 5124) {
                        // block.5120
                    } else /*if (blockEntityId < 5128)*/ {
                        // block.5124
                    }
                } else /*if (blockEntityId < 5136)*/ {
                    if (blockEntityId < 5132) {
                        // block.5128
                    } else /*if (blockEntityId < 5136)*/ {
                        // block.5132
                    }
                }
            } else /*if (blockEntityId < 5152)*/ {
                if (blockEntityId < 5144) {
                    if (blockEntityId < 5140) {
                        // block.5136
                    } else /*if (blockEntityId < 5144)*/ {
                        // block.5140
                    }
                } else /*if (blockEntityId < 5152)*/ {
                    if (blockEntityId < 5148) {
                        // block.5144
                    } else /*if (blockEntityId < 5152)*/ {
                        // block.5148
                    }
                }
            }
        } else /*if (blockEntityId < 5184)*/ {
            if (blockEntityId < 5168) {
                if (blockEntityId < 5160) {
                    if (blockEntityId < 5156) {
                        // block.5152
                    } else /*if (blockEntityId < 5160)*/ {
                        // block.5156
                    }
                } else /*if (blockEntityId < 5168)*/ {
                    if (blockEntityId < 5164) {
                        // block.5160
                    } else /*if (blockEntityId < 5168)*/ {
                        // block.5164
                    }
                }
            } else /*if (blockEntityId < 5184)*/ {
                if (blockEntityId < 5176) {
                    if (blockEntityId < 5172) {
                        // block.5168
                    } else /*if (blockEntityId < 5176)*/ {
                        // block.5172
                    }
                } else /*if (blockEntityId < 5184)*/ {
                    if (blockEntityId < 5180) {
                        // block.5176
                    } else /*if (blockEntityId < 5184)*/ {
                        // block.5180
                    }
                }
            }
        }
    }
} else /*if (blockEntityId < 5312)*/ {
    if (blockEntityId < 5248) {
        if (blockEntityId < 5216) {
            if (blockEntityId < 5200) {
                if (blockEntityId < 5192) {
                    if (blockEntityId < 5188) {
                        // block.5184
                    } else /*if (blockEntityId < 5192)*/ {
                        // block.5188
                    }
                } else /*if (blockEntityId < 5200)*/ {
                    if (blockEntityId < 5196) {
                        // block.5192
                    } else /*if (blockEntityId < 5200)*/ {
                        // block.5196
                    }
                }
            } else /*if (blockEntityId < 5216)*/ {
                if (blockEntityId < 5208) {
                    if (blockEntityId < 5204) {
                        // block.5200
                    } else /*if (blockEntityId < 5208)*/ {
                        // block.5204
                    }
                } else /*if (blockEntityId < 5216)*/ {
                    if (blockEntityId < 5212) {
                        // block.5208
                    } else /*if (blockEntityId < 5216)*/ {
                        // block.5212
                    }
                }
            }
        } else /*if (blockEntityId < 5248)*/ {
            if (blockEntityId < 5232) {
                if (blockEntityId < 5224) {
                    if (blockEntityId < 5220) {
                        // block.5216
                    } else /*if (blockEntityId < 5224)*/ {
                        // block.5220
                    }
                } else /*if (blockEntityId < 5232)*/ {
                    if (blockEntityId < 5228) {
                        // block.5224
                    } else /*if (blockEntityId < 5232)*/ {
                        // block.5228
                    }
                }
            } else /*if (blockEntityId < 5248)*/ {
                if (blockEntityId < 5240) {
                    if (blockEntityId < 5236) {
                        // block.5232
                    } else /*if (blockEntityId < 5240)*/ {
                        // block.5236
                    }
                } else /*if (blockEntityId < 5248)*/ {
                    if (blockEntityId < 5244) {
                        // block.5240
                    } else /*if (blockEntityId < 5248)*/ {
                        // block.5244
                    }
                }
            }
        }
    } else /*if (blockEntityId < 5312)*/ {
        if (blockEntityId < 5280) {
            if (blockEntityId < 5264) {
                if (blockEntityId < 5256) {
                    if (blockEntityId < 5252) {
                        // block.5248
                    } else /*if (blockEntityId < 5256)*/ {
                        // block.5252
                    }
                } else /*if (blockEntityId < 5264)*/ {
                    if (blockEntityId < 5260) {
                        // block.5256
                    } else /*if (blockEntityId < 5264)*/ {
                        // block.5260
                    }
                }
            } else /*if (blockEntityId < 5280)*/ {
                if (blockEntityId < 5272) {
                    if (blockEntityId < 5268) {
                        // block.5264
                    } else /*if (blockEntityId < 5272)*/ {
                        // block.5268
                    }
                } else /*if (blockEntityId < 5280)*/ {
                    if (blockEntityId < 5276) {
                        // block.5272
                    } else /*if (blockEntityId < 5280)*/ {
                        // block.5276
                    }
                }
            }
        } else /*if (blockEntityId < 5312)*/ {
            if (blockEntityId < 5296) {
                if (blockEntityId < 5288) {
                    if (blockEntityId < 5284) {
                        // block.5280
                    } else /*if (blockEntityId < 5288)*/ {
                        // block.5284
                    }
                } else /*if (blockEntityId < 5296)*/ {
                    if (blockEntityId < 5292) {
                        // block.5288
                    } else /*if (blockEntityId < 5296)*/ {
                        // block.5292
                    }
                }
            } else /*if (blockEntityId < 5312)*/ {
                if (blockEntityId < 5304) {
                    if (blockEntityId < 5300) {
                        // block.5296
                    } else /*if (blockEntityId < 5304)*/ {
                        // block.5300
                    }
                } else /*if (blockEntityId < 5312)*/ {
                    if (blockEntityId < 5308) {
                        // block.5304
                    } else /*if (blockEntityId < 5312)*/ {
                        // block.5308
                    }
                }
            }
        }
    }
}
