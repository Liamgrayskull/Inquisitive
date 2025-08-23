#include "/lib/shaderSettings/materials.glsl"

#ifndef INCLUDE_VOXELIZATION
    #define INCLUDE_VOXELIZATION

    #if COLORED_LIGHTING_INTERNAL <= 512
        const ivec3 voxelVolumeSize = ivec3(COLORED_LIGHTING_INTERNAL, COLORED_LIGHTING_INTERNAL * 0.5, COLORED_LIGHTING_INTERNAL);
    #else
        const ivec3 voxelVolumeSize = ivec3(COLORED_LIGHTING_INTERNAL, 512 * 0.5, COLORED_LIGHTING_INTERNAL);
    #endif

    float effectiveACLdistance = min(float(COLORED_LIGHTING_INTERNAL), shadowDistance * 2.0);

    vec3 transform(mat4 m, vec3 pos) {
        return mat3(m) * pos + m[3].xyz;
    }

    vec3 SceneToVoxel(vec3 scenePos) {
        return scenePos + cameraPositionBestFract + (0.5 * vec3(voxelVolumeSize));
    }

    bool CheckInsideVoxelVolume(vec3 voxelPos) {
        #ifndef SHADOW
            voxelPos -= voxelVolumeSize / 2;
            voxelPos += sign(voxelPos) * 0.95;
            voxelPos += voxelVolumeSize / 2;
        #endif
        voxelPos /= vec3(voxelVolumeSize);
        return clamp01(voxelPos) == voxelPos;
    }

    vec4 GetLightVolume(vec3 pos) {
        vec4 lightVolume;

        #ifdef COMPOSITE
            #undef ACL_CORNER_LEAK_FIX
        #endif

        #ifdef ACL_CORNER_LEAK_FIX
            float minMult = 1.5;
            ivec3 posTX = ivec3(pos * voxelVolumeSize);

            ivec3[6] adjacentOffsets = ivec3[](
                ivec3( 1, 0, 0),
                ivec3(-1, 0, 0),
                ivec3( 0, 1, 0),
                ivec3( 0,-1, 0),
                ivec3( 0, 0, 1),
                ivec3( 0, 0,-1)
            );

            int adjacentCount = 0;
            for (int i = 0; i < 6; i++) {
                int voxel = int(texelFetch(voxel_sampler, posTX + adjacentOffsets[i], 0).r);
                if (voxel == 1 || voxel >= 60000) adjacentCount++;
            }

            if (int(texelFetch(voxel_sampler, posTX, 0).r) >= 60000) adjacentCount = 6;
        #endif

        if ((frameCounter & 1) == 0) {
            lightVolume = texture(floodfill_sampler_copy, pos);
            #ifdef ACL_CORNER_LEAK_FIX
                if (adjacentCount >= 3) {
                    vec4 lightVolumeTX = texelFetch(floodfill_sampler_copy, posTX, 0);
                    if (dot(lightVolumeTX, lightVolumeTX) > 0.01)
                    lightVolume.rgb = min(lightVolume.rgb, lightVolumeTX.rgb * minMult);
                }
            #endif
        } else {
            lightVolume = texture(floodfill_sampler, pos);
            #ifdef ACL_CORNER_LEAK_FIX
                if (adjacentCount >= 3) {
                    vec4 lightVolumeTX = texelFetch(floodfill_sampler, posTX, 0);
                    if (dot(lightVolumeTX, lightVolumeTX) > 0.01)
                    lightVolume.rgb = min(lightVolume.rgb, lightVolumeTX.rgb * minMult);
                }
            #endif
        }

        return lightVolume;
    }

    int GetVoxelIDs(int mat) {
        /* These return IDs must be consistent across the following files:
        "voxelization.glsl", "blocklightColors.glsl", "item.properties"
        The order of if-checks or block IDs don't matter. The returning IDs matter. */

        if (mat < 12968) {
            if (mat < 12607) {
                if (mat < 12465) {
                    if (mat < 12387) {
                        if (mat < 12325) {
                            if (mat < 12301) {
                                if (mat < 12289) {
                                    if (mat < 5074) {
                                        if (mat < 5073) {
                                            if (mat == 5072) return 364;
                                        } else { // mat >= 5073
                                            if (mat == 5073) return 364;
                                        }
                                    } else { // mat >= 5074
                                        if (mat < 5075) {
                                            if (mat == 5074) return 364;
                                        } else { // mat >= 5075
                                            if (mat < 5076) {
                                                if (mat == 5075) return 364;
                                            } else { // mat >= 5076
                                                if (mat == 12288) return 24;
                                            }
                                        }
                                    }
                                } else { // mat >= 12289
                                    if (mat < 12295) {
                                        if (mat < 12291) {
                                            if (mat == 12290) return 166;
                                        } else { // mat >= 12291
                                            if (mat < 12293) {
                                                if (mat == 12292) return 167;
                                            } else { // mat >= 12293
                                                if (mat == 12294) return 77;
                                            }
                                        }
                                    } else { // mat >= 12295
                                        if (mat < 12297) {
                                            if (mat == 12296) return 169;
                                        } else { // mat >= 12297
                                            if (mat < 12299) {
                                                if (mat == 12298) return 75;
                                            } else { // mat >= 12299
                                                if (mat == 12300) return 170;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12301
                                if (mat < 12313) {
                                    if (mat < 12307) {
                                        if (mat < 12303) {
                                            if (mat == 12302) return 171;
                                        } else { // mat >= 12303
                                            if (mat < 12305) {
                                                if (mat == 12304) return 74;
                                            } else { // mat >= 12305
                                                if (mat == 12306) return 172;
                                            }
                                        }
                                    } else { // mat >= 12307
                                        if (mat < 12309) {
                                            if (mat == 12308) return 76;
                                        } else { // mat >= 12309
                                            if (mat < 12311) {
                                                if (mat == 12310) return 73;
                                            } else { // mat >= 12311
                                                if (mat == 12312) return 79;
                                            }
                                        }
                                    }
                                } else { // mat >= 12313
                                    if (mat < 12319) {
                                        if (mat < 12315) {
                                            if (mat == 12314) return 173;
                                        } else { // mat >= 12315
                                            if (mat < 12317) {
                                                if (mat == 12316) return 174;
                                            } else { // mat >= 12317
                                                if (mat == 12318) return 175;
                                            }
                                        }
                                    } else { // mat >= 12319
                                        if (mat < 12321) {
                                            if (mat == 12320) return 176;
                                        } else { // mat >= 12321
                                            if (mat < 12323) {
                                                if (mat == 12322) return 71;
                                            } else { // mat >= 12323
                                                if (mat == 12324) return 80;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12325
                            if (mat < 12357) {
                                if (mat < 12335) {
                                    if (mat < 12329) {
                                        if (mat < 12327) {
                                            if (mat == 12326) return 78;
                                        } else { // mat >= 12327
                                            if (mat == 12328) return 70;
                                        }
                                    } else { // mat >= 12329
                                        if (mat < 12331) {
                                            if (mat == 12330) return 177;
                                        } else { // mat >= 12331
                                            if (mat < 12333) {
                                                if (mat == 12332) return 178;
                                            } else { // mat >= 12333
                                                if (mat == 12334) return 179;
                                            }
                                        }
                                    }
                                } else { // mat >= 12335
                                    if (mat < 12341) {
                                        if (mat < 12337) {
                                            if (mat == 12336) return 180;
                                        } else { // mat >= 12337
                                            if (mat < 12339) {
                                                if (mat == 12338) return 181;
                                            } else { // mat >= 12339
                                                if (mat == 12340) return 72;
                                            }
                                        }
                                    } else { // mat >= 12341
                                        if (mat < 12353) {
                                            if (mat == 12352) return 226;
                                        } else { // mat >= 12353
                                            if (mat < 12355) {
                                                if (mat == 12354) return 225;
                                            } else { // mat >= 12355
                                                if (mat == 12356) return 229;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12357
                                if (mat < 12377) {
                                    if (mat < 12363) {
                                        if (mat < 12359) {
                                            if (mat == 12358) return 223;
                                        } else { // mat >= 12359
                                            if (mat < 12361) {
                                                if (mat == 12360) return 222;
                                            } else { // mat >= 12361
                                                if (mat == 12362) return 224;
                                            }
                                        }
                                    } else { // mat >= 12363
                                        if (mat < 12365) {
                                            if (mat == 12364) return 227;
                                        } else { // mat >= 12365
                                            if (mat < 12367) {
                                                if (mat == 12366) return 221;
                                            } else { // mat >= 12367
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12376) return 153;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12377
                                    if (mat < 12380) {
                                        if (mat < 12378) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12377) return 153;
                                            #endif
                                        } else { // mat >= 12378
                                            if (mat < 12379) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12378) return 153;
                                                #endif
                                            } else { // mat >= 12379
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12379) return 153;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12380
                                        if (mat < 12385) {
                                            if (mat == 12384) return 37;
                                        } else { // mat >= 12385
                                            if (mat < 12386) {
                                                if (mat == 12385) return 37;
                                            } else { // mat >= 12386
                                                if (mat == 12386) return 37;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 12387
                        if (mat < 12413) {
                            if (mat < 12398) {
                                if (mat < 12392) {
                                    if (mat < 12389) {
                                        if (mat < 12388) {
                                            if (mat == 12387) return 37;
                                        } else { // mat >= 12388
                                            if (mat == 12388) return 356;
                                        }
                                    } else { // mat >= 12389
                                        if (mat < 12390) {
                                            if (mat == 12389) return 356;
                                        } else { // mat >= 12390
                                            if (mat < 12391) {
                                                if (mat == 12390) return 356;
                                            } else { // mat >= 12391
                                                if (mat == 12391) return 356;
                                            }
                                        }
                                    }
                                } else { // mat >= 12392
                                    if (mat < 12395) {
                                        if (mat < 12393) {
                                            if (mat == 12392) return 154;
                                        } else { // mat >= 12393
                                            if (mat < 12394) {
                                                if (mat == 12393) return 154;
                                            } else { // mat >= 12394
                                                if (mat == 12394) return 154;
                                            }
                                        }
                                    } else { // mat >= 12395
                                        if (mat < 12396) {
                                            if (mat == 12395) return 154;
                                        } else { // mat >= 12396
                                            if (mat < 12397) {
                                                if (mat == 12396) return 155;
                                            } else { // mat >= 12397
                                                if (mat == 12397) return 155;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12398
                                if (mat < 12407) {
                                    if (mat < 12401) {
                                        if (mat < 12399) {
                                            if (mat == 12398) return 155;
                                        } else { // mat >= 12399
                                            if (mat < 12400) {
                                                if (mat == 12399) return 155;
                                            } else { // mat >= 12400
                                                if (mat == 12400) return 155;
                                            }
                                        }
                                    } else { // mat >= 12401
                                        if (mat < 12405) {
                                            if (mat == 12404) return 37;
                                        } else { // mat >= 12405
                                            if (mat < 12406) {
                                                if (mat == 12405) return 37;
                                            } else { // mat >= 12406
                                                if (mat == 12406) return 37;
                                            }
                                        }
                                    }
                                } else { // mat >= 12407
                                    if (mat < 12410) {
                                        if (mat < 12408) {
                                            if (mat == 12407) return 37;
                                        } else { // mat >= 12408
                                            if (mat < 12409) {
                                                if (mat == 12408) return 154;
                                            } else { // mat >= 12409
                                                if (mat == 12409) return 154;
                                            }
                                        }
                                    } else { // mat >= 12410
                                        if (mat < 12411) {
                                            if (mat == 12410) return 154;
                                        } else { // mat >= 12411
                                            if (mat < 12412) {
                                                if (mat == 12411) return 154;
                                            } else { // mat >= 12412
                                                if (mat == 12412) return 155;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12413
                            if (mat < 12424) {
                                if (mat < 12418) {
                                    if (mat < 12415) {
                                        if (mat < 12414) {
                                            if (mat == 12413) return 155;
                                        } else { // mat >= 12414
                                            if (mat == 12414) return 155;
                                        }
                                    } else { // mat >= 12415
                                        if (mat < 12416) {
                                            if (mat == 12415) return 155;
                                        } else { // mat >= 12416
                                            if (mat < 12417) {
                                                if (mat == 12416) return 156;
                                            } else { // mat >= 12417
                                                if (mat == 12417) return 156;
                                            }
                                        }
                                    }
                                } else { // mat >= 12418
                                    if (mat < 12421) {
                                        if (mat < 12419) {
                                            if (mat == 12418) return 156;
                                        } else { // mat >= 12419
                                            if (mat < 12420) {
                                                if (mat == 12419) return 156;
                                            } else { // mat >= 12420
                                                if (mat == 12420) return 156;
                                            }
                                        }
                                    } else { // mat >= 12421
                                        if (mat < 12422) {
                                            if (mat == 12421) return 156;
                                        } else { // mat >= 12422
                                            if (mat < 12423) {
                                                if (mat == 12422) return 156;
                                            } else { // mat >= 12423
                                                if (mat == 12423) return 156;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12424
                                if (mat < 12433) {
                                    if (mat < 12427) {
                                        if (mat < 12425) {
                                            if (mat == 12424) return 157;
                                        } else { // mat >= 12425
                                            if (mat < 12426) {
                                                if (mat == 12425) return 157;
                                            } else { // mat >= 12426
                                                if (mat == 12426) return 157;
                                            }
                                        }
                                    } else { // mat >= 12427
                                        if (mat < 12428) {
                                            if (mat == 12427) return 157;
                                        } else { // mat >= 12428
                                            if (mat < 12429) {
                                                if (mat == 12428) return 158;
                                            } else { // mat >= 12429
                                                if (mat == 12432) return 159;
                                            }
                                        }
                                    }
                                } else { // mat >= 12433
                                    if (mat < 12458) {
                                        if (mat < 12441) {
                                            if (mat == 12440) return 161;
                                        } else { // mat >= 12441
                                            if (mat < 12457) {
                                                if (mat == 12456) return 15;
                                            } else { // mat >= 12457
                                                if (mat == 12457) return 15;
                                            }
                                        }
                                    } else { // mat >= 12458
                                        if (mat < 12459) {
                                            if (mat == 12458) return 15;
                                        } else { // mat >= 12459
                                            if (mat < 12460) {
                                                if (mat == 12459) return 15;
                                            } else { // mat >= 12460
                                                if (mat == 12464) return 162;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else { // mat >= 12465
                    if (mat < 12531) {
                        if (mat < 12488) {
                            if (mat < 12476) {
                                if (mat < 12470) {
                                    if (mat < 12467) {
                                        if (mat < 12466) {
                                            if (mat == 12465) return 162;
                                        } else { // mat >= 12466
                                            if (mat == 12466) return 162;
                                        }
                                    } else { // mat >= 12467
                                        if (mat < 12468) {
                                            if (mat == 12467) return 162;
                                        } else { // mat >= 12468
                                            if (mat < 12469) {
                                                if (mat == 12468) return 162;
                                            } else { // mat >= 12469
                                                if (mat == 12469) return 162;
                                            }
                                        }
                                    }
                                } else { // mat >= 12470
                                    if (mat < 12473) {
                                        if (mat < 12471) {
                                            if (mat == 12470) return 162;
                                        } else { // mat >= 12471
                                            if (mat < 12472) {
                                                if (mat == 12471) return 162;
                                            } else { // mat >= 12472
                                                if (mat == 12472) return 162;
                                            }
                                        }
                                    } else { // mat >= 12473
                                        if (mat < 12474) {
                                            if (mat == 12473) return 162;
                                        } else { // mat >= 12474
                                            if (mat < 12475) {
                                                if (mat == 12474) return 162;
                                            } else { // mat >= 12475
                                                if (mat == 12475) return 162;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12476
                                if (mat < 12482) {
                                    if (mat < 12479) {
                                        if (mat < 12477) {
                                            if (mat == 12476) return 162;
                                        } else { // mat >= 12477
                                            if (mat < 12478) {
                                                if (mat == 12477) return 162;
                                            } else { // mat >= 12478
                                                if (mat == 12478) return 162;
                                            }
                                        }
                                    } else { // mat >= 12479
                                        if (mat < 12480) {
                                            if (mat == 12479) return 162;
                                        } else { // mat >= 12480
                                            if (mat < 12481) {
                                                if (mat == 12480) return 162;
                                            } else { // mat >= 12481
                                                if (mat == 12481) return 162;
                                            }
                                        }
                                    }
                                } else { // mat >= 12482
                                    if (mat < 12485) {
                                        if (mat < 12483) {
                                            if (mat == 12482) return 162;
                                        } else { // mat >= 12483
                                            if (mat < 12484) {
                                                if (mat == 12483) return 162;
                                            } else { // mat >= 12484
                                                if (mat == 12484) return 163;
                                            }
                                        }
                                    } else { // mat >= 12485
                                        if (mat < 12486) {
                                            if (mat == 12485) return 163;
                                        } else { // mat >= 12486
                                            if (mat < 12487) {
                                                if (mat == 12486) return 163;
                                            } else { // mat >= 12487
                                                if (mat == 12487) return 163;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12488
                            if (mat < 12511) {
                                if (mat < 12493) {
                                    if (mat < 12490) {
                                        if (mat < 12489) {
                                            if (mat == 12488) return 13;
                                        } else { // mat >= 12489
                                            if (mat == 12489) return 13;
                                        }
                                    } else { // mat >= 12490
                                        if (mat < 12491) {
                                            if (mat == 12490) return 13;
                                        } else { // mat >= 12491
                                            if (mat < 12492) {
                                                if (mat == 12491) return 13;
                                            } else { // mat >= 12492
                                                if (mat == 12492) return 13;
                                            }
                                        }
                                    }
                                } else { // mat >= 12493
                                    if (mat < 12496) {
                                        if (mat < 12494) {
                                            if (mat == 12493) return 13;
                                        } else { // mat >= 12494
                                            if (mat < 12495) {
                                                if (mat == 12494) return 13;
                                            } else { // mat >= 12495
                                                if (mat == 12495) return 13;
                                            }
                                        }
                                    } else { // mat >= 12496
                                        if (mat < 12509) {
                                            #if defined GLOWING_ORE_SILVER_C && defined DO_IPBR_LIGHTS
                                            if (mat == 12508) return 217;
                                            #endif
                                        } else { // mat >= 12509
                                            if (mat < 12510) {
                                                #if defined GLOWING_ORE_SILVER_C && defined DO_IPBR_LIGHTS
                                                if (mat == 12509) return 217;
                                                #endif
                                            } else { // mat >= 12510
                                                #if defined GLOWING_ORE_SILVER_C && defined DO_IPBR_LIGHTS
                                                if (mat == 12510) return 217;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12511
                                if (mat < 12517) {
                                    if (mat < 12514) {
                                        if (mat < 12512) {
                                            #if defined GLOWING_ORE_SILVER_C && defined DO_IPBR_LIGHTS
                                            if (mat == 12511) return 217;
                                            #endif
                                        } else { // mat >= 12512
                                            if (mat < 12513) {
                                                if (mat == 12512) return 30;
                                            } else { // mat >= 12513
                                                if (mat == 12513) return 30;
                                            }
                                        }
                                    } else { // mat >= 12514
                                        if (mat < 12515) {
                                            if (mat == 12514) return 30;
                                        } else { // mat >= 12515
                                            if (mat < 12516) {
                                                if (mat == 12515) return 30;
                                            } else { // mat >= 12516
                                                #if defined GLOWING_ORE_SOULSILVER && defined DO_IPBR_LIGHTS
                                                if (mat == 12516) return 217;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12517
                                    if (mat < 12520) {
                                        if (mat < 12518) {
                                            #if defined GLOWING_ORE_SOULSILVER && defined DO_IPBR_LIGHTS
                                            if (mat == 12517) return 217;
                                            #endif
                                        } else { // mat >= 12518
                                            if (mat < 12519) {
                                                #if defined GLOWING_ORE_SOULSILVER && defined DO_IPBR_LIGHTS
                                                if (mat == 12518) return 217;
                                                #endif
                                            } else { // mat >= 12519
                                                #if defined GLOWING_ORE_SOULSILVER && defined DO_IPBR_LIGHTS
                                                if (mat == 12519) return 217;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12520
                                        if (mat < 12529) {
                                            if (mat == 12528) return 164;
                                        } else { // mat >= 12529
                                            if (mat < 12530) {
                                                if (mat == 12529) return 164;
                                            } else { // mat >= 12530
                                                if (mat == 12530) return 164;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 12531
                        if (mat < 12558) {
                            if (mat < 12546) {
                                if (mat < 12536) {
                                    if (mat < 12533) {
                                        if (mat < 12532) {
                                            if (mat == 12531) return 164;
                                        } else { // mat >= 12532
                                            #if defined GLOWING_ORE_SPINEL && defined DO_IPBR_LIGHTS
                                            if (mat == 12532) return 165;
                                            #endif
                                        }
                                    } else { // mat >= 12533
                                        if (mat < 12534) {
                                            #if defined GLOWING_ORE_SPINEL && defined DO_IPBR_LIGHTS
                                            if (mat == 12533) return 165;
                                            #endif
                                        } else { // mat >= 12534
                                            if (mat < 12535) {
                                                #if defined GLOWING_ORE_SPINEL && defined DO_IPBR_LIGHTS
                                                if (mat == 12534) return 165;
                                                #endif
                                            } else { // mat >= 12535
                                                #if defined GLOWING_ORE_SPINEL && defined DO_IPBR_LIGHTS
                                                if (mat == 12535) return 165;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12536
                                    if (mat < 12543) {
                                        if (mat < 12541) {
                                            if (mat == 12540) return 182;
                                        } else { // mat >= 12541
                                            if (mat < 12542) {
                                                if (mat == 12541) return 182;
                                            } else { // mat >= 12542
                                                if (mat == 12542) return 182;
                                            }
                                        }
                                    } else { // mat >= 12543
                                        if (mat < 12544) {
                                            if (mat == 12543) return 182;
                                        } else { // mat >= 12544
                                            if (mat < 12545) {
                                                if (mat == 12544) return 182;
                                            } else { // mat >= 12545
                                                if (mat == 12545) return 182;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12546
                                if (mat < 12552) {
                                    if (mat < 12549) {
                                        if (mat < 12547) {
                                            if (mat == 12546) return 182;
                                        } else { // mat >= 12547
                                            if (mat < 12548) {
                                                if (mat == 12547) return 182;
                                            } else { // mat >= 12548
                                                if (mat == 12548) return 182;
                                            }
                                        }
                                    } else { // mat >= 12549
                                        if (mat < 12550) {
                                            if (mat == 12549) return 182;
                                        } else { // mat >= 12550
                                            if (mat < 12551) {
                                                if (mat == 12550) return 182;
                                            } else { // mat >= 12551
                                                if (mat == 12551) return 182;
                                            }
                                        }
                                    }
                                } else { // mat >= 12552
                                    if (mat < 12555) {
                                        if (mat < 12553) {
                                            if (mat == 12552) return 182;
                                        } else { // mat >= 12553
                                            if (mat < 12554) {
                                                if (mat == 12553) return 182;
                                            } else { // mat >= 12554
                                                if (mat == 12554) return 182;
                                            }
                                        }
                                    } else { // mat >= 12555
                                        if (mat < 12556) {
                                            if (mat == 12555) return 182;
                                        } else { // mat >= 12556
                                            if (mat < 12557) {
                                                if (mat == 12556) return 182;
                                            } else { // mat >= 12557
                                                if (mat == 12557) return 182;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12558
                            if (mat < 12593) {
                                if (mat < 12564) {
                                    if (mat < 12561) {
                                        if (mat < 12559) {
                                            if (mat == 12558) return 182;
                                        } else { // mat >= 12559
                                            if (mat < 12560) {
                                                if (mat == 12559) return 182;
                                            } else { // mat >= 12560
                                                if (mat == 12560) return 182;
                                            }
                                        }
                                    } else { // mat >= 12561
                                        if (mat < 12562) {
                                            if (mat == 12561) return 182;
                                        } else { // mat >= 12562
                                            if (mat < 12563) {
                                                if (mat == 12562) return 182;
                                            } else { // mat >= 12563
                                                if (mat == 12563) return 182;
                                            }
                                        }
                                    }
                                } else { // mat >= 12564
                                    if (mat < 12587) {
                                        if (mat < 12571) {
                                            if (mat == 12570) return 26;
                                        } else { // mat >= 12571
                                            if (mat < 12579) {
                                                if (mat == 12578) return 183;
                                            } else { // mat >= 12579
                                                if (mat == 12586) return 184;
                                            }
                                        }
                                    } else { // mat >= 12587
                                        if (mat < 12589) {
                                            if (mat == 12588) return 185;
                                        } else { // mat >= 12589
                                            if (mat < 12591) {
                                                if (mat == 12590) return 186;
                                            } else { // mat >= 12591
                                                if (mat == 12592) return 185;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12593
                                if (mat < 12601) {
                                    if (mat < 12598) {
                                        if (mat < 12595) {
                                            if (mat == 12594) return 186;
                                        } else { // mat >= 12595
                                            if (mat < 12597) {
                                                if (mat == 12596) return 12;
                                            } else { // mat >= 12597
                                                if (mat == 12597) return 12;
                                            }
                                        }
                                    } else { // mat >= 12598
                                        if (mat < 12599) {
                                            if (mat == 12598) return 12;
                                        } else { // mat >= 12599
                                            if (mat < 12600) {
                                                if (mat == 12599) return 12;
                                            } else { // mat >= 12600
                                                if (mat == 12600) return 12;
                                            }
                                        }
                                    }
                                } else { // mat >= 12601
                                    if (mat < 12604) {
                                        if (mat < 12602) {
                                            if (mat == 12601) return 12;
                                        } else { // mat >= 12602
                                            if (mat < 12603) {
                                                if (mat == 12602) return 12;
                                            } else { // mat >= 12603
                                                if (mat == 12603) return 12;
                                            }
                                        }
                                    } else { // mat >= 12604
                                        if (mat < 12605) {
                                            #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                            if (mat == 12604) return 187;
                                            #endif
                                        } else { // mat >= 12605
                                            if (mat < 12606) {
                                                #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                                if (mat == 12605) return 187;
                                                #endif
                                            } else { // mat >= 12606
                                                #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                                if (mat == 12606) return 187;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else { // mat >= 12607
                if (mat < 12778) {
                    if (mat < 12697) {
                        if (mat < 12648) {
                            if (mat < 12625) {
                                if (mat < 12612) {
                                    if (mat < 12609) {
                                        if (mat < 12608) {
                                            #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                            if (mat == 12607) return 187;
                                            #endif
                                        } else { // mat >= 12608
                                            #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                            if (mat == 12608) return 39;
                                            #endif
                                        }
                                    } else { // mat >= 12609
                                        if (mat < 12610) {
                                            #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                            if (mat == 12609) return 39;
                                            #endif
                                        } else { // mat >= 12610
                                            if (mat < 12611) {
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12610) return 39;
                                                #endif
                                            } else { // mat >= 12611
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12611) return 39;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12612
                                    if (mat < 12615) {
                                        if (mat < 12613) {
                                            #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                            if (mat == 12612) return 188;
                                            #endif
                                        } else { // mat >= 12613
                                            if (mat < 12614) {
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12613) return 188;
                                                #endif
                                            } else { // mat >= 12614
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12614) return 188;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12615
                                        if (mat < 12616) {
                                            #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                            if (mat == 12615) return 188;
                                            #endif
                                        } else { // mat >= 12616
                                            if (mat < 12621) {
                                                if (mat == 12620) return 3;
                                            } else { // mat >= 12621
                                                if (mat == 12624) return 189;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12625
                                if (mat < 12642) {
                                    if (mat < 12639) {
                                        if (mat < 12637) {
                                            #if defined GLOWING_ORE_NEBULITE && defined DO_IPBR_LIGHTS
                                            if (mat == 12636) return 190;
                                            #endif
                                        } else { // mat >= 12637
                                            if (mat < 12638) {
                                                #if defined GLOWING_ORE_NEBULITE && defined DO_IPBR_LIGHTS
                                                if (mat == 12637) return 190;
                                                #endif
                                            } else { // mat >= 12638
                                                #if defined GLOWING_ORE_NEBULITE && defined DO_IPBR_LIGHTS
                                                if (mat == 12638) return 190;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12639
                                        if (mat < 12640) {
                                            #if defined GLOWING_ORE_NEBULITE && defined DO_IPBR_LIGHTS
                                            if (mat == 12639) return 190;
                                            #endif
                                        } else { // mat >= 12640
                                            if (mat < 12641) {
                                                if (mat == 12640) return 185;
                                            } else { // mat >= 12641
                                                if (mat == 12641) return 185;
                                            }
                                        }
                                    }
                                } else { // mat >= 12642
                                    if (mat < 12645) {
                                        if (mat < 12643) {
                                            if (mat == 12642) return 185;
                                        } else { // mat >= 12643
                                            if (mat < 12644) {
                                                if (mat == 12643) return 185;
                                            } else { // mat >= 12644
                                                if (mat == 12644) return 12;
                                            }
                                        }
                                    } else { // mat >= 12645
                                        if (mat < 12646) {
                                            if (mat == 12645) return 12;
                                        } else { // mat >= 12646
                                            if (mat < 12647) {
                                                if (mat == 12646) return 12;
                                            } else { // mat >= 12647
                                                if (mat == 12647) return 12;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12648
                            if (mat < 12678) {
                                if (mat < 12653) {
                                    if (mat < 12650) {
                                        if (mat < 12649) {
                                            #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                            if (mat == 12648) return 187;
                                            #endif
                                        } else { // mat >= 12649
                                            #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                            if (mat == 12649) return 187;
                                            #endif
                                        }
                                    } else { // mat >= 12650
                                        if (mat < 12651) {
                                            #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                            if (mat == 12650) return 187;
                                            #endif
                                        } else { // mat >= 12651
                                            if (mat < 12652) {
                                                #if defined DO_IPBR_LIGHTS && defined GLOWING_CELESTIAL_GROWTHS
                                                if (mat == 12651) return 187;
                                                #endif
                                            } else { // mat >= 12652
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12652) return 39;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12653
                                    if (mat < 12656) {
                                        if (mat < 12654) {
                                            #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                            if (mat == 12653) return 39;
                                            #endif
                                        } else { // mat >= 12654
                                            if (mat < 12655) {
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12654) return 39;
                                                #endif
                                            } else { // mat >= 12655
                                                #if defined DO_IPBR_LIGHTS && (!(defined NOT_GLOWING_CHORUS_FLOWER))
                                                if (mat == 12655) return 39;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12656
                                        if (mat < 12663) {
                                            if (mat == 12662) return 191;
                                        } else { // mat >= 12663
                                            if (mat < 12677) {
                                                if (mat == 12676) return 192;
                                            } else { // mat >= 12677
                                                if (mat == 12677) return 192;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12678
                                if (mat < 12691) {
                                    if (mat < 12681) {
                                        if (mat < 12679) {
                                            if (mat == 12678) return 192;
                                        } else { // mat >= 12679
                                            if (mat < 12680) {
                                                if (mat == 12679) return 192;
                                            } else { // mat >= 12680
                                                if (mat == 12680) return 20;
                                            }
                                        }
                                    } else { // mat >= 12681
                                        if (mat < 12689) {
                                            if (mat == 12688) return 360;
                                        } else { // mat >= 12689
                                            if (mat < 12690) {
                                                if (mat == 12689) return 360;
                                            } else { // mat >= 12690
                                                if (mat == 12690) return 360;
                                            }
                                        }
                                    }
                                } else { // mat >= 12691
                                    if (mat < 12694) {
                                        if (mat < 12692) {
                                            if (mat == 12691) return 360;
                                        } else { // mat >= 12692
                                            if (mat < 12693) {
                                                if (mat == 12692) return 21;
                                            } else { // mat >= 12693
                                                if (mat == 12693) return 21;
                                            }
                                        }
                                    } else { // mat >= 12694
                                        if (mat < 12695) {
                                            if (mat == 12694) return 21;
                                        } else { // mat >= 12695
                                            if (mat < 12696) {
                                                if (mat == 12695) return 21;
                                            } else { // mat >= 12696
                                                if (mat == 12696) return 195;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 12697
                        if (mat < 12734) {
                            if (mat < 12714) {
                                if (mat < 12704) {
                                    if (mat < 12701) {
                                        if (mat < 12699) {
                                            if (mat == 12698) return 194;
                                        } else { // mat >= 12699
                                            if (mat == 12700) return 196;
                                        }
                                    } else { // mat >= 12701
                                        if (mat < 12702) {
                                            if (mat == 12701) return 196;
                                        } else { // mat >= 12702
                                            if (mat < 12703) {
                                                if (mat == 12702) return 196;
                                            } else { // mat >= 12703
                                                if (mat == 12703) return 196;
                                            }
                                        }
                                    }
                                } else { // mat >= 12704
                                    if (mat < 12711) {
                                        if (mat < 12709) {
                                            if (mat == 12708) return 197;
                                        } else { // mat >= 12709
                                            if (mat < 12710) {
                                                if (mat == 12709) return 197;
                                            } else { // mat >= 12710
                                                if (mat == 12710) return 197;
                                            }
                                        }
                                    } else { // mat >= 12711
                                        if (mat < 12712) {
                                            if (mat == 12711) return 197;
                                        } else { // mat >= 12712
                                            if (mat < 12713) {
                                                if (mat == 12712) return 198;
                                            } else { // mat >= 12713
                                                if (mat == 12713) return 198;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12714
                                if (mat < 12720) {
                                    if (mat < 12717) {
                                        if (mat < 12715) {
                                            if (mat == 12714) return 198;
                                        } else { // mat >= 12715
                                            if (mat < 12716) {
                                                if (mat == 12715) return 198;
                                            } else { // mat >= 12716
                                                if (mat == 12716) return 199;
                                            }
                                        }
                                    } else { // mat >= 12717
                                        if (mat < 12718) {
                                            if (mat == 12717) return 199;
                                        } else { // mat >= 12718
                                            if (mat < 12719) {
                                                if (mat == 12718) return 199;
                                            } else { // mat >= 12719
                                                if (mat == 12719) return 199;
                                            }
                                        }
                                    }
                                } else { // mat >= 12720
                                    if (mat < 12723) {
                                        if (mat < 12721) {
                                            if (mat == 12720) return 205;
                                        } else { // mat >= 12721
                                            if (mat < 12722) {
                                                if (mat == 12721) return 205;
                                            } else { // mat >= 12722
                                                if (mat == 12722) return 205;
                                            }
                                        }
                                    } else { // mat >= 12723
                                        if (mat < 12724) {
                                            if (mat == 12723) return 205;
                                        } else { // mat >= 12724
                                            if (mat < 12733) {
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12732) return 204;
                                                #endif
                                            } else { // mat >= 12733
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12733) return 204;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12734
                            if (mat < 12752) {
                                if (mat < 12746) {
                                    if (mat < 12737) {
                                        if (mat < 12735) {
                                            #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                            if (mat == 12734) return 204;
                                            #endif
                                        } else { // mat >= 12735
                                            if (mat < 12736) {
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12735) return 204;
                                                #endif
                                            } else { // mat >= 12736
                                                if (mat == 12736) return 205;
                                            }
                                        }
                                    } else { // mat >= 12737
                                        if (mat < 12743) {
                                            if (mat == 12742) return 34;
                                        } else { // mat >= 12743
                                            if (mat < 12745) {
                                                if (mat == 12744) return 200;
                                            } else { // mat >= 12745
                                                if (mat == 12745) return 200;
                                            }
                                        }
                                    }
                                } else { // mat >= 12746
                                    if (mat < 12749) {
                                        if (mat < 12747) {
                                            if (mat == 12746) return 200;
                                        } else { // mat >= 12747
                                            if (mat < 12748) {
                                                if (mat == 12747) return 200;
                                            } else { // mat >= 12748
                                                if (mat == 12748) return 200;
                                            }
                                        }
                                    } else { // mat >= 12749
                                        if (mat < 12750) {
                                            if (mat == 12749) return 200;
                                        } else { // mat >= 12750
                                            if (mat < 12751) {
                                                if (mat == 12750) return 200;
                                            } else { // mat >= 12751
                                                if (mat == 12751) return 200;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12752
                                if (mat < 12771) {
                                    if (mat < 12759) {
                                        if (mat < 12757) {
                                            if (mat == 12756) return 201;
                                        } else { // mat >= 12757
                                            if (mat < 12758) {
                                                if (mat == 12757) return 201;
                                            } else { // mat >= 12758
                                                if (mat == 12758) return 201;
                                            }
                                        }
                                    } else { // mat >= 12759
                                        if (mat < 12760) {
                                            if (mat == 12759) return 201;
                                        } else { // mat >= 12760
                                            if (mat < 12761) {
                                                if (mat == 12760) return 200;
                                            } else { // mat >= 12761
                                                if (mat == 12770) return 202;
                                            }
                                        }
                                    }
                                } else { // mat >= 12771
                                    if (mat < 12775) {
                                        if (mat < 12773) {
                                            #if defined GLOWING_PINK_SALT
                                            if (mat == 12772) return 202;
                                            #endif
                                        } else { // mat >= 12773
                                            if (mat < 12774) {
                                                #if defined GLOWING_PINK_SALT
                                                if (mat == 12773) return 202;
                                                #endif
                                            } else { // mat >= 12774
                                                #if defined GLOWING_PINK_SALT
                                                if (mat == 12774) return 202;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12775
                                        if (mat < 12776) {
                                            #if defined GLOWING_PINK_SALT
                                            if (mat == 12775) return 202;
                                            #endif
                                        } else { // mat >= 12776
                                            if (mat < 12777) {
                                                if (mat == 12776) return 203;
                                            } else { // mat >= 12777
                                                if (mat == 12777) return 203;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else { // mat >= 12778
                    if (mat < 12875) {
                        if (mat < 12851) {
                            if (mat < 12804) {
                                if (mat < 12787) {
                                    if (mat < 12780) {
                                        if (mat < 12779) {
                                            if (mat == 12778) return 203;
                                        } else { // mat >= 12779
                                            if (mat == 12779) return 203;
                                        }
                                    } else { // mat >= 12780
                                        if (mat < 12785) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 12784) return 204;
                                            #endif
                                        } else { // mat >= 12785
                                            if (mat < 12786) {
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 12785) return 204;
                                                #endif
                                            } else { // mat >= 12786
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 12786) return 204;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12787
                                    if (mat < 12801) {
                                        if (mat < 12788) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 12787) return 204;
                                            #endif
                                        } else { // mat >= 12788
                                            if (mat < 12797) {
                                                if (mat == 12796) return 20;
                                            } else { // mat >= 12797
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12800) return 204;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12801
                                        if (mat < 12802) {
                                            #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                            if (mat == 12801) return 204;
                                            #endif
                                        } else { // mat >= 12802
                                            if (mat < 12803) {
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12802) return 204;
                                                #endif
                                            } else { // mat >= 12803
                                                #if defined GLOWING_ORE_SILVER_G && defined DO_IPBR_LIGHTS
                                                if (mat == 12803) return 204;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12804
                                if (mat < 12831) {
                                    if (mat < 12819) {
                                        if (mat < 12805) {
                                            if (mat == 12804) return 197;
                                        } else { // mat >= 12805
                                            if (mat < 12817) {
                                                if (mat == 12816) return 12;
                                            } else { // mat >= 12817
                                                if (mat == 12818) return 29;
                                            }
                                        }
                                    } else { // mat >= 12819
                                        if (mat < 12825) {
                                            if (mat == 12824) return 21;
                                        } else { // mat >= 12825
                                            if (mat < 12827) {
                                                if (mat == 12826) return 29;
                                            } else { // mat >= 12827
                                                if (mat == 12830) return 37;
                                            }
                                        }
                                    }
                                } else { // mat >= 12831
                                    if (mat < 12835) {
                                        if (mat < 12833) {
                                            if (mat == 12832) return 37;
                                        } else { // mat >= 12833
                                            if (mat < 12834) {
                                                if (mat == 12833) return 37;
                                            } else { // mat >= 12834
                                                if (mat == 12834) return 37;
                                            }
                                        }
                                    } else { // mat >= 12835
                                        if (mat < 12836) {
                                            if (mat == 12835) return 37;
                                        } else { // mat >= 12836
                                            if (mat < 12839) {
                                                if (mat == 12838) return 211;
                                            } else { // mat >= 12839
                                                if (mat == 12850) return 206;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12851
                            if (mat < 12863) {
                                if (mat < 12857) {
                                    if (mat < 12854) {
                                        if (mat < 12853) {
                                            if (mat == 12852) return 208;
                                        } else { // mat >= 12853
                                            if (mat == 12853) return 208;
                                        }
                                    } else { // mat >= 12854
                                        if (mat < 12855) {
                                            if (mat == 12854) return 208;
                                        } else { // mat >= 12855
                                            if (mat < 12856) {
                                                if (mat == 12855) return 208;
                                            } else { // mat >= 12856
                                                if (mat == 12856) return 208;
                                            }
                                        }
                                    }
                                } else { // mat >= 12857
                                    if (mat < 12860) {
                                        if (mat < 12858) {
                                            if (mat == 12857) return 208;
                                        } else { // mat >= 12858
                                            if (mat < 12859) {
                                                if (mat == 12858) return 208;
                                            } else { // mat >= 12859
                                                if (mat == 12859) return 208;
                                            }
                                        }
                                    } else { // mat >= 12860
                                        if (mat < 12861) {
                                            if (mat == 12860) return 207;
                                        } else { // mat >= 12861
                                            if (mat < 12862) {
                                                if (mat == 12861) return 207;
                                            } else { // mat >= 12862
                                                if (mat == 12862) return 207;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12863
                                if (mat < 12869) {
                                    if (mat < 12866) {
                                        if (mat < 12864) {
                                            if (mat == 12863) return 207;
                                        } else { // mat >= 12864
                                            if (mat < 12865) {
                                                if (mat == 12864) return 208;
                                            } else { // mat >= 12865
                                                if (mat == 12865) return 208;
                                            }
                                        }
                                    } else { // mat >= 12866
                                        if (mat < 12867) {
                                            if (mat == 12866) return 208;
                                        } else { // mat >= 12867
                                            if (mat < 12868) {
                                                if (mat == 12867) return 208;
                                            } else { // mat >= 12868
                                                if (mat == 12868) return 208;
                                            }
                                        }
                                    }
                                } else { // mat >= 12869
                                    if (mat < 12872) {
                                        if (mat < 12870) {
                                            if (mat == 12869) return 208;
                                        } else { // mat >= 12870
                                            if (mat < 12871) {
                                                if (mat == 12870) return 208;
                                            } else { // mat >= 12871
                                                if (mat == 12871) return 208;
                                            }
                                        }
                                    } else { // mat >= 12872
                                        if (mat < 12873) {
                                            if (mat == 12872) return 208;
                                        } else { // mat >= 12873
                                            if (mat < 12874) {
                                                if (mat == 12873) return 208;
                                            } else { // mat >= 12874
                                                if (mat == 12874) return 208;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 12875
                        if (mat < 12931) {
                            if (mat < 12893) {
                                if (mat < 12880) {
                                    if (mat < 12877) {
                                        if (mat < 12876) {
                                            if (mat == 12875) return 208;
                                        } else { // mat >= 12876
                                            if (mat == 12876) return 208;
                                        }
                                    } else { // mat >= 12877
                                        if (mat < 12878) {
                                            if (mat == 12877) return 208;
                                        } else { // mat >= 12878
                                            if (mat < 12879) {
                                                if (mat == 12878) return 208;
                                            } else { // mat >= 12879
                                                if (mat == 12879) return 208;
                                            }
                                        }
                                    }
                                } else { // mat >= 12880
                                    if (mat < 12883) {
                                        if (mat < 12881) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12880) return 37;
                                            #endif
                                        } else { // mat >= 12881
                                            if (mat < 12882) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12881) return 37;
                                                #endif
                                            } else { // mat >= 12882
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12882) return 37;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12883
                                        if (mat < 12884) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12883) return 37;
                                            #endif
                                        } else { // mat >= 12884
                                            if (mat < 12889) {
                                                if (mat == 12888) return 208;
                                            } else { // mat >= 12889
                                                if (mat == 12892) return 15;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12893
                                if (mat < 12915) {
                                    if (mat < 12896) {
                                        if (mat < 12894) {
                                            if (mat == 12893) return 15;
                                        } else { // mat >= 12894
                                            if (mat < 12895) {
                                                if (mat == 12894) return 15;
                                            } else { // mat >= 12895
                                                if (mat == 12895) return 15;
                                            }
                                        }
                                    } else { // mat >= 12896
                                        if (mat < 12913) {
                                            if (mat == 12912) return 211;
                                        } else { // mat >= 12913
                                            if (mat < 12914) {
                                                if (mat == 12913) return 211;
                                            } else { // mat >= 12914
                                                if (mat == 12914) return 211;
                                            }
                                        }
                                    }
                                } else { // mat >= 12915
                                    if (mat < 12918) {
                                        if (mat < 12916) {
                                            if (mat == 12915) return 211;
                                        } else { // mat >= 12916
                                            if (mat < 12917) {
                                                if (mat == 12916) return 209;
                                            } else { // mat >= 12917
                                                if (mat == 12917) return 209;
                                            }
                                        }
                                    } else { // mat >= 12918
                                        if (mat < 12919) {
                                            if (mat == 12918) return 209;
                                        } else { // mat >= 12919
                                            if (mat < 12920) {
                                                if (mat == 12919) return 209;
                                            } else { // mat >= 12920
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12930) return 65;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 12931
                            if (mat < 12955) {
                                if (mat < 12947) {
                                    if (mat < 12943) {
                                        if (mat < 12935) {
                                            if (mat == 12934) return 29;
                                        } else { // mat >= 12935
                                            if (mat < 12941) {
                                                if (mat == 12940) return 13;
                                            } else { // mat >= 12941
                                                if (mat == 12942) return 209;
                                            }
                                        }
                                    } else { // mat >= 12943
                                        if (mat < 12945) {
                                            if (mat == 12944) return 210;
                                        } else { // mat >= 12945
                                            if (mat < 12946) {
                                                if (mat == 12945) return 210;
                                            } else { // mat >= 12946
                                                if (mat == 12946) return 210;
                                            }
                                        }
                                    }
                                } else { // mat >= 12947
                                    if (mat < 12950) {
                                        if (mat < 12948) {
                                            if (mat == 12947) return 210;
                                        } else { // mat >= 12948
                                            if (mat < 12949) {
                                                if (mat == 12948) return 15;
                                            } else { // mat >= 12949
                                                if (mat == 12949) return 15;
                                            }
                                        }
                                    } else { // mat >= 12950
                                        if (mat < 12951) {
                                            if (mat == 12950) return 15;
                                        } else { // mat >= 12951
                                            if (mat < 12952) {
                                                if (mat == 12951) return 15;
                                            } else { // mat >= 12952
                                                if (mat == 12954) return 30;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12955
                                if (mat < 12962) {
                                    if (mat < 12959) {
                                        if (mat < 12957) {
                                            if (mat == 12956) return 30;
                                        } else { // mat >= 12957
                                            if (mat < 12958) {
                                                if (mat == 12957) return 30;
                                            } else { // mat >= 12958
                                                if (mat == 12958) return 30;
                                            }
                                        }
                                    } else { // mat >= 12959
                                        if (mat < 12960) {
                                            if (mat == 12959) return 30;
                                        } else { // mat >= 12960
                                            if (mat < 12961) {
                                                if (mat == 12960) return 161;
                                            } else { // mat >= 12961
                                                if (mat == 12961) return 161;
                                            }
                                        }
                                    }
                                } else { // mat >= 12962
                                    if (mat < 12965) {
                                        if (mat < 12963) {
                                            if (mat == 12962) return 161;
                                        } else { // mat >= 12963
                                            if (mat < 12964) {
                                                if (mat == 12963) return 161;
                                            } else { // mat >= 12964
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12964) return 211;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12965
                                        if (mat < 12966) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12965) return 211;
                                            #endif
                                        } else { // mat >= 12966
                                            if (mat < 12967) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12966) return 211;
                                                #endif
                                            } else { // mat >= 12967
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12967) return 211;
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
        } else { // mat >= 12968
            if (mat < 13413) {
                if (mat < 13141) {
                    if (mat < 13043) {
                        if (mat < 13003) {
                            if (mat < 12982) {
                                if (mat < 12975) {
                                    if (mat < 12970) {
                                        if (mat < 12969) {
                                            if (mat == 12968) return 30;
                                        } else { // mat >= 12969
                                            if (mat == 12969) return 30;
                                        }
                                    } else { // mat >= 12970
                                        if (mat < 12971) {
                                            if (mat == 12970) return 30;
                                        } else { // mat >= 12971
                                            if (mat < 12972) {
                                                if (mat == 12971) return 30;
                                            } else { // mat >= 12972
                                                if (mat == 12974) return 211;
                                            }
                                        }
                                    }
                                } else { // mat >= 12975
                                    if (mat < 12979) {
                                        if (mat < 12977) {
                                            if (mat == 12976) return 211;
                                        } else { // mat >= 12977
                                            if (mat < 12978) {
                                                if (mat == 12977) return 211;
                                            } else { // mat >= 12978
                                                if (mat == 12978) return 211;
                                            }
                                        }
                                    } else { // mat >= 12979
                                        if (mat < 12980) {
                                            if (mat == 12979) return 211;
                                        } else { // mat >= 12980
                                            if (mat < 12981) {
                                                if (mat == 12980) return 208;
                                            } else { // mat >= 12981
                                                if (mat == 12981) return 208;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 12982
                                if (mat < 12990) {
                                    if (mat < 12985) {
                                        if (mat < 12983) {
                                            if (mat == 12982) return 208;
                                        } else { // mat >= 12983
                                            if (mat < 12984) {
                                                if (mat == 12983) return 208;
                                            } else { // mat >= 12984
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12984) return 212;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12985
                                        if (mat < 12987) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12986) return 213;
                                            #endif
                                        } else { // mat >= 12987
                                            if (mat < 12989) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12988) return 213;
                                                #endif
                                            } else { // mat >= 12989
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12989) return 213;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 12990
                                    if (mat < 12999) {
                                        if (mat < 12991) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 12990) return 213;
                                            #endif
                                        } else { // mat >= 12991
                                            if (mat < 12992) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12991) return 213;
                                                #endif
                                            } else { // mat >= 12992
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 12998) return 213;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 12999
                                        if (mat < 13001) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 13000) return 65;
                                            #endif
                                        } else { // mat >= 13001
                                            if (mat < 13002) {
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 13001) return 65;
                                                #endif
                                            } else { // mat >= 13002
                                                #if defined DO_IPBR_LIGHTS
                                                if (mat == 13002) return 65;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 13003
                            if (mat < 13029) {
                                if (mat < 13016) {
                                    if (mat < 13013) {
                                        if (mat < 13004) {
                                            #if defined DO_IPBR_LIGHTS
                                            if (mat == 13003) return 65;
                                            #endif
                                        } else { // mat >= 13004
                                            if (mat == 13012) return 216;
                                        }
                                    } else { // mat >= 13013
                                        if (mat < 13014) {
                                            if (mat == 13013) return 216;
                                        } else { // mat >= 13014
                                            if (mat < 13015) {
                                                if (mat == 13014) return 216;
                                            } else { // mat >= 13015
                                                if (mat == 13015) return 216;
                                            }
                                        }
                                    }
                                } else { // mat >= 13016
                                    if (mat < 13026) {
                                        if (mat < 13019) {
                                            if (mat == 13018) return 214;
                                        } else { // mat >= 13019
                                            if (mat < 13025) {
                                                if (mat == 13024) return 216;
                                            } else { // mat >= 13025
                                                if (mat == 13025) return 216;
                                            }
                                        }
                                    } else { // mat >= 13026
                                        if (mat < 13027) {
                                            if (mat == 13026) return 216;
                                        } else { // mat >= 13027
                                            if (mat < 13028) {
                                                if (mat == 13027) return 216;
                                            } else { // mat >= 13028
                                                if (mat == 13028) return 216;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13029
                                if (mat < 13037) {
                                    if (mat < 13034) {
                                        if (mat < 13031) {
                                            if (mat == 13030) return 216;
                                        } else { // mat >= 13031
                                            if (mat < 13033) {
                                                #if defined GLOWING_ORE_LEAD && defined DO_IPBR_LIGHTS
                                                if (mat == 13032) return 215;
                                                #endif
                                            } else { // mat >= 13033
                                                #if defined GLOWING_ORE_LEAD && defined DO_IPBR_LIGHTS
                                                if (mat == 13033) return 215;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 13034
                                        if (mat < 13035) {
                                            #if defined GLOWING_ORE_LEAD && defined DO_IPBR_LIGHTS
                                            if (mat == 13034) return 215;
                                            #endif
                                        } else { // mat >= 13035
                                            if (mat < 13036) {
                                                #if defined GLOWING_ORE_LEAD && defined DO_IPBR_LIGHTS
                                                if (mat == 13035) return 215;
                                                #endif
                                            } else { // mat >= 13036
                                                if (mat == 13036) return 216;
                                            }
                                        }
                                    }
                                } else { // mat >= 13037
                                    if (mat < 13040) {
                                        if (mat < 13038) {
                                            if (mat == 13037) return 216;
                                        } else { // mat >= 13038
                                            if (mat < 13039) {
                                                if (mat == 13038) return 216;
                                            } else { // mat >= 13039
                                                if (mat == 13039) return 216;
                                            }
                                        }
                                    } else { // mat >= 13040
                                        if (mat < 13041) {
                                            if (mat == 13040) return 216;
                                        } else { // mat >= 13041
                                            if (mat < 13042) {
                                                if (mat == 13041) return 216;
                                            } else { // mat >= 13042
                                                if (mat == 13042) return 216;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 13043
                        if (mat < 13074) {
                            if (mat < 13058) {
                                if (mat < 13052) {
                                    if (mat < 13049) {
                                        if (mat < 13044) {
                                            if (mat == 13043) return 216;
                                        } else { // mat >= 13044
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 13048) return 215;
                                            #endif
                                        }
                                    } else { // mat >= 13049
                                        if (mat < 13050) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 13049) return 215;
                                            #endif
                                        } else { // mat >= 13050
                                            if (mat < 13051) {
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13050) return 215;
                                                #endif
                                            } else { // mat >= 13051
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13051) return 215;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 13052
                                    if (mat < 13055) {
                                        if (mat < 13053) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 13052) return 217;
                                            #endif
                                        } else { // mat >= 13053
                                            if (mat < 13054) {
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13053) return 217;
                                                #endif
                                            } else { // mat >= 13054
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13054) return 217;
                                                #endif
                                            }
                                        }
                                    } else { // mat >= 13055
                                        if (mat < 13056) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 13055) return 217;
                                            #endif
                                        } else { // mat >= 13056
                                            if (mat < 13057) {
                                                #if defined GLOWING_ORE_SILVER_O && defined DO_IPBR_LIGHTS
                                                if (mat == 13056) return 217;
                                                #endif
                                            } else { // mat >= 13057
                                                #if defined GLOWING_ORE_SILVER_O && defined DO_IPBR_LIGHTS
                                                if (mat == 13057) return 217;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13058
                                if (mat < 13064) {
                                    if (mat < 13061) {
                                        if (mat < 13059) {
                                            #if defined GLOWING_ORE_SILVER_O && defined DO_IPBR_LIGHTS
                                            if (mat == 13058) return 217;
                                            #endif
                                        } else { // mat >= 13059
                                            if (mat < 13060) {
                                                #if defined GLOWING_ORE_SILVER_O && defined DO_IPBR_LIGHTS
                                                if (mat == 13059) return 217;
                                                #endif
                                            } else { // mat >= 13060
                                                if (mat == 13060) return 218;
                                            }
                                        }
                                    } else { // mat >= 13061
                                        if (mat < 13062) {
                                            if (mat == 13061) return 218;
                                        } else { // mat >= 13062
                                            if (mat < 13063) {
                                                if (mat == 13062) return 218;
                                            } else { // mat >= 13063
                                                if (mat == 13063) return 218;
                                            }
                                        }
                                    }
                                } else { // mat >= 13064
                                    if (mat < 13067) {
                                        if (mat < 13065) {
                                            if (mat == 13064) return 218;
                                        } else { // mat >= 13065
                                            if (mat < 13066) {
                                                if (mat == 13065) return 218;
                                            } else { // mat >= 13066
                                                if (mat == 13066) return 218;
                                            }
                                        }
                                    } else { // mat >= 13067
                                        if (mat < 13068) {
                                            if (mat == 13067) return 218;
                                        } else { // mat >= 13068
                                            if (mat < 13073) {
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13072) return 219;
                                                #endif
                                            } else { // mat >= 13073
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13073) return 219;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 13074
                            if (mat < 13086) {
                                if (mat < 13080) {
                                    if (mat < 13077) {
                                        if (mat < 13075) {
                                            #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                            if (mat == 13074) return 219;
                                            #endif
                                        } else { // mat >= 13075
                                            if (mat < 13076) {
                                                #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                                                if (mat == 13075) return 219;
                                                #endif
                                            } else { // mat >= 13076
                                                if (mat == 13076) return 12;
                                            }
                                        }
                                    } else { // mat >= 13077
                                        if (mat < 13078) {
                                            if (mat == 13077) return 12;
                                        } else { // mat >= 13078
                                            if (mat < 13079) {
                                                if (mat == 13078) return 12;
                                            } else { // mat >= 13079
                                                if (mat == 13079) return 12;
                                            }
                                        }
                                    }
                                } else { // mat >= 13080
                                    if (mat < 13083) {
                                        if (mat < 13081) {
                                            if (mat == 13080) return 29;
                                        } else { // mat >= 13081
                                            if (mat < 13082) {
                                                if (mat == 13081) return 29;
                                            } else { // mat >= 13082
                                                if (mat == 13082) return 29;
                                            }
                                        }
                                    } else { // mat >= 13083
                                        if (mat < 13084) {
                                            if (mat == 13083) return 29;
                                        } else { // mat >= 13084
                                            if (mat < 13085) {
                                                #if defined GLOWING_PORKSLAG && defined DO_IPBR_LIGHTS
                                                if (mat == 13084) return 219;
                                                #endif
                                            } else { // mat >= 13085
                                                #if defined GLOWING_PORKSLAG && defined DO_IPBR_LIGHTS
                                                if (mat == 13085) return 219;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13086
                                if (mat < 13118) {
                                    if (mat < 13113) {
                                        if (mat < 13087) {
                                            #if defined GLOWING_PORKSLAG && defined DO_IPBR_LIGHTS
                                            if (mat == 13086) return 219;
                                            #endif
                                        } else { // mat >= 13087
                                            if (mat < 13088) {
                                                #if defined GLOWING_PORKSLAG && defined DO_IPBR_LIGHTS
                                                if (mat == 13087) return 219;
                                                #endif
                                            } else { // mat >= 13088
                                                if (mat == 13112) return 21;
                                            }
                                        }
                                    } else { // mat >= 13113
                                        if (mat < 13115) {
                                            if (mat == 13114) return 29;
                                        } else { // mat >= 13115
                                            if (mat < 13117) {
                                                if (mat == 13116) return 220;
                                            } else { // mat >= 13117
                                                if (mat == 13117) return 220;
                                            }
                                        }
                                    }
                                } else { // mat >= 13118
                                    if (mat < 13125) {
                                        if (mat < 13119) {
                                            if (mat == 13118) return 220;
                                        } else { // mat >= 13119
                                            if (mat < 13120) {
                                                if (mat == 13119) return 220;
                                            } else { // mat >= 13120
                                                if (mat == 13124) return 228;
                                            }
                                        }
                                    } else { // mat >= 13125
                                        if (mat < 13131) {
                                            if (mat == 13130) return 21;
                                        } else { // mat >= 13131
                                            if (mat < 13135) {
                                                if (mat == 13134) return 239;
                                            } else { // mat >= 13135
                                                if (mat == 13140) return 240;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else { // mat >= 13141
                    if (mat < 13309) {
                        if (mat < 13257) {
                            if (mat < 13190) {
                                if (mat < 13177) {
                                    if (mat < 13146) {
                                        if (mat < 13145) {
                                            if (mat == 13144) return 20;
                                        } else { // mat >= 13145
                                            if (mat == 13145) return 20;
                                        }
                                    } else { // mat >= 13146
                                        if (mat < 13147) {
                                            if (mat == 13146) return 20;
                                        } else { // mat >= 13147
                                            if (mat < 13148) {
                                                if (mat == 13147) return 20;
                                            } else { // mat >= 13148
                                                if (mat == 13176) return 20;
                                            }
                                        }
                                    }
                                } else { // mat >= 13177
                                    if (mat < 13183) {
                                        if (mat < 13179) {
                                            if (mat == 13178) return 34;
                                        } else { // mat >= 13179
                                            if (mat < 13181) {
                                                if (mat == 13180) return 241;
                                            } else { // mat >= 13181
                                                if (mat == 13182) return 65;
                                            }
                                        }
                                    } else { // mat >= 13183
                                        if (mat < 13185) {
                                            if (mat == 13184) return 240;
                                        } else { // mat >= 13185
                                            if (mat < 13189) {
                                                if (mat == 13188) return 2;
                                            } else { // mat >= 13189
                                                if (mat == 13189) return 2;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13190
                                if (mat < 13227) {
                                    if (mat < 13217) {
                                        if (mat < 13191) {
                                            if (mat == 13190) return 2;
                                        } else { // mat >= 13191
                                            if (mat < 13192) {
                                                if (mat == 13191) return 2;
                                            } else { // mat >= 13192
                                                if (mat == 13216) return 5;
                                            }
                                        }
                                    } else { // mat >= 13217
                                        if (mat < 13219) {
                                            if (mat == 13218) return 27;
                                        } else { // mat >= 13219
                                            if (mat < 13225) {
                                                if (mat == 13224) return 12;
                                            } else { // mat >= 13225
                                                if (mat == 13226) return 29;
                                            }
                                        }
                                    }
                                } else { // mat >= 13227
                                    if (mat < 13254) {
                                        if (mat < 13235) {
                                            if (mat == 13234) return 242;
                                        } else { // mat >= 13235
                                            if (mat < 13253) {
                                                if (mat == 13252) return 243;
                                            } else { // mat >= 13253
                                                if (mat == 13253) return 243;
                                            }
                                        }
                                    } else { // mat >= 13254
                                        if (mat < 13255) {
                                            if (mat == 13254) return 243;
                                        } else { // mat >= 13255
                                            if (mat < 13256) {
                                                if (mat == 13255) return 243;
                                            } else { // mat >= 13256
                                                #if defined GLOWING_NETHER_TREES && defined DO_IPBR_LIGHTS
                                                if (mat == 13256) return 243;
                                                #endif
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 13257
                            if (mat < 13287) {
                                if (mat < 13281) {
                                    if (mat < 13259) {
                                        if (mat < 13258) {
                                            #if defined GLOWING_NETHER_TREES && defined DO_IPBR_LIGHTS
                                            if (mat == 13257) return 243;
                                            #endif
                                        } else { // mat >= 13258
                                            #if defined GLOWING_NETHER_TREES && defined DO_IPBR_LIGHTS
                                            if (mat == 13258) return 243;
                                            #endif
                                        }
                                    } else { // mat >= 13259
                                        if (mat < 13260) {
                                            #if defined GLOWING_NETHER_TREES && defined DO_IPBR_LIGHTS
                                            if (mat == 13259) return 243;
                                            #endif
                                        } else { // mat >= 13260
                                            if (mat < 13277) {
                                                if (mat == 13276) return 197;
                                            } else { // mat >= 13277
                                                if (mat == 13280) return 244;
                                            }
                                        }
                                    }
                                } else { // mat >= 13281
                                    if (mat < 13284) {
                                        if (mat < 13282) {
                                            if (mat == 13281) return 244;
                                        } else { // mat >= 13282
                                            if (mat < 13283) {
                                                if (mat == 13282) return 244;
                                            } else { // mat >= 13283
                                                if (mat == 13283) return 244;
                                            }
                                        }
                                    } else { // mat >= 13284
                                        if (mat < 13285) {
                                            if (mat == 13284) return 40;
                                        } else { // mat >= 13285
                                            if (mat < 13286) {
                                                if (mat == 13285) return 40;
                                            } else { // mat >= 13286
                                                if (mat == 13286) return 40;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13287
                                if (mat < 13300) {
                                    if (mat < 13297) {
                                        if (mat < 13288) {
                                            if (mat == 13287) return 40;
                                        } else { // mat >= 13288
                                            if (mat < 13293) {
                                                if (mat == 13292) return 12;
                                            } else { // mat >= 13293
                                                if (mat == 13296) return 245;
                                            }
                                        }
                                    } else { // mat >= 13297
                                        if (mat < 13298) {
                                            if (mat == 13297) return 245;
                                        } else { // mat >= 13298
                                            if (mat < 13299) {
                                                if (mat == 13298) return 245;
                                            } else { // mat >= 13299
                                                if (mat == 13299) return 245;
                                            }
                                        }
                                    }
                                } else { // mat >= 13300
                                    if (mat < 13306) {
                                        if (mat < 13301) {
                                            if (mat == 13300) return 36;
                                        } else { // mat >= 13301
                                            if (mat < 13305) {
                                                if (mat == 13304) return 246;
                                            } else { // mat >= 13305
                                                if (mat == 13305) return 246;
                                            }
                                        }
                                    } else { // mat >= 13306
                                        if (mat < 13307) {
                                            if (mat == 13306) return 246;
                                        } else { // mat >= 13307
                                            if (mat < 13308) {
                                                if (mat == 13307) return 246;
                                            } else { // mat >= 13308
                                                if (mat == 13308) return 247;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 13309
                        if (mat < 13357) {
                            if (mat < 13326) {
                                if (mat < 13317) {
                                    if (mat < 13311) {
                                        if (mat < 13310) {
                                            if (mat == 13309) return 247;
                                        } else { // mat >= 13310
                                            if (mat == 13310) return 247;
                                        }
                                    } else { // mat >= 13311
                                        if (mat < 13312) {
                                            if (mat == 13311) return 247;
                                        } else { // mat >= 13312
                                            if (mat < 13313) {
                                                if (mat == 13312) return 248;
                                            } else { // mat >= 13313
                                                if (mat == 13316) return 200;
                                            }
                                        }
                                    }
                                } else { // mat >= 13317
                                    if (mat < 13323) {
                                        if (mat < 13321) {
                                            if (mat == 13320) return 248;
                                        } else { // mat >= 13321
                                            if (mat < 13322) {
                                                if (mat == 13321) return 248;
                                            } else { // mat >= 13322
                                                if (mat == 13322) return 248;
                                            }
                                        }
                                    } else { // mat >= 13323
                                        if (mat < 13324) {
                                            if (mat == 13323) return 248;
                                        } else { // mat >= 13324
                                            if (mat < 13325) {
                                                if (mat == 13324) return 16;
                                            } else { // mat >= 13325
                                                if (mat == 13325) return 16;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13326
                                if (mat < 13340) {
                                    if (mat < 13337) {
                                        if (mat < 13327) {
                                            if (mat == 13326) return 16;
                                        } else { // mat >= 13327
                                            if (mat < 13328) {
                                                if (mat == 13327) return 16;
                                            } else { // mat >= 13328
                                                if (mat == 13336) return 250;
                                            }
                                        }
                                    } else { // mat >= 13337
                                        if (mat < 13338) {
                                            if (mat == 13337) return 250;
                                        } else { // mat >= 13338
                                            if (mat < 13339) {
                                                if (mat == 13338) return 250;
                                            } else { // mat >= 13339
                                                if (mat == 13339) return 250;
                                            }
                                        }
                                    }
                                } else { // mat >= 13340
                                    if (mat < 13351) {
                                        if (mat < 13349) {
                                            if (mat == 13348) return 19;
                                        } else { // mat >= 13349
                                            if (mat < 13350) {
                                                if (mat == 13349) return 19;
                                            } else { // mat >= 13350
                                                if (mat == 13350) return 19;
                                            }
                                        }
                                    } else { // mat >= 13351
                                        if (mat < 13352) {
                                            if (mat == 13351) return 19;
                                        } else { // mat >= 13352
                                            if (mat < 13355) {
                                                if (mat == 13354) return 65;
                                            } else { // mat >= 13355
                                                if (mat == 13356) return 12;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 13357
                            if (mat < 13397) {
                                if (mat < 13383) {
                                    if (mat < 13360) {
                                        if (mat < 13358) {
                                            if (mat == 13357) return 12;
                                        } else { // mat >= 13358
                                            if (mat < 13359) {
                                                if (mat == 13358) return 12;
                                            } else { // mat >= 13359
                                                if (mat == 13359) return 12;
                                            }
                                        }
                                    } else { // mat >= 13360
                                        if (mat < 13381) {
                                            if (mat == 13380) return 19;
                                        } else { // mat >= 13381
                                            if (mat < 13382) {
                                                if (mat == 13381) return 19;
                                            } else { // mat >= 13382
                                                if (mat == 13382) return 19;
                                            }
                                        }
                                    }
                                } else { // mat >= 13383
                                    if (mat < 13394) {
                                        if (mat < 13384) {
                                            if (mat == 13383) return 19;
                                        } else { // mat >= 13384
                                            if (mat < 13393) {
                                                if (mat == 13392) return 251;
                                            } else { // mat >= 13393
                                                if (mat == 13393) return 251;
                                            }
                                        }
                                    } else { // mat >= 13394
                                        if (mat < 13395) {
                                            if (mat == 13394) return 251;
                                        } else { // mat >= 13395
                                            if (mat < 13396) {
                                                if (mat == 13395) return 251;
                                            } else { // mat >= 13396
                                                if (mat == 13396) return 252;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13397
                                if (mat < 13403) {
                                    if (mat < 13400) {
                                        if (mat < 13398) {
                                            if (mat == 13397) return 252;
                                        } else { // mat >= 13398
                                            if (mat < 13399) {
                                                if (mat == 13398) return 252;
                                            } else { // mat >= 13399
                                                if (mat == 13399) return 252;
                                            }
                                        }
                                    } else { // mat >= 13400
                                        if (mat < 13401) {
                                            if (mat == 13400) return 253;
                                        } else { // mat >= 13401
                                            if (mat < 13402) {
                                                if (mat == 13401) return 253;
                                            } else { // mat >= 13402
                                                if (mat == 13402) return 253;
                                            }
                                        }
                                    }
                                } else { // mat >= 13403
                                    if (mat < 13410) {
                                        if (mat < 13404) {
                                            if (mat == 13403) return 253;
                                        } else { // mat >= 13404
                                            if (mat < 13409) {
                                                if (mat == 13408) return 254;
                                            } else { // mat >= 13409
                                                if (mat == 13409) return 254;
                                            }
                                        }
                                    } else { // mat >= 13410
                                        if (mat < 13411) {
                                            if (mat == 13410) return 254;
                                        } else { // mat >= 13411
                                            if (mat < 13412) {
                                                if (mat == 13411) return 254;
                                            } else { // mat >= 13412
                                                if (mat == 13412) return 257;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else { // mat >= 13413
                if (mat < 32190) {
                    if (mat < 32143) {
                        if (mat < 13452) {
                            if (mat < 13436) {
                                if (mat < 13430) {
                                    if (mat < 13415) {
                                        if (mat < 13414) {
                                            if (mat == 13413) return 257;
                                        } else { // mat >= 13414
                                            if (mat == 13414) return 257;
                                        }
                                    } else { // mat >= 13415
                                        if (mat < 13416) {
                                            if (mat == 13415) return 257;
                                        } else { // mat >= 13416
                                            if (mat < 13429) {
                                                #if (GLOWING_BLOODCAP_MUSHROOM >= 1) && defined DO_IPBR_LIGHTS
                                                if (mat == 13428) return 256;
                                                #endif
                                            } else { // mat >= 13429
                                                #if (GLOWING_BLOODCAP_MUSHROOM >= 1) && defined DO_IPBR_LIGHTS
                                                if (mat == 13429) return 256;
                                                #endif
                                            }
                                        }
                                    }
                                } else { // mat >= 13430
                                    if (mat < 13433) {
                                        if (mat < 13431) {
                                            #if (GLOWING_BLOODCAP_MUSHROOM >= 1) && defined DO_IPBR_LIGHTS
                                            if (mat == 13430) return 256;
                                            #endif
                                        } else { // mat >= 13431
                                            if (mat < 13432) {
                                                #if (GLOWING_BLOODCAP_MUSHROOM >= 1) && defined DO_IPBR_LIGHTS
                                                if (mat == 13431) return 256;
                                                #endif
                                            } else { // mat >= 13432
                                                if (mat == 13432) return 15;
                                            }
                                        }
                                    } else { // mat >= 13433
                                        if (mat < 13434) {
                                            if (mat == 13433) return 15;
                                        } else { // mat >= 13434
                                            if (mat < 13435) {
                                                if (mat == 13434) return 15;
                                            } else { // mat >= 13435
                                                if (mat == 13435) return 15;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 13436
                                if (mat < 13442) {
                                    if (mat < 13439) {
                                        if (mat < 13437) {
                                            if (mat == 13436) return 162;
                                        } else { // mat >= 13437
                                            if (mat < 13438) {
                                                if (mat == 13437) return 162;
                                            } else { // mat >= 13438
                                                if (mat == 13438) return 162;
                                            }
                                        }
                                    } else { // mat >= 13439
                                        if (mat < 13440) {
                                            if (mat == 13439) return 162;
                                        } else { // mat >= 13440
                                            if (mat < 13441) {
                                                if (mat == 13440) return 182;
                                            } else { // mat >= 13441
                                                if (mat == 13441) return 182;
                                            }
                                        }
                                    }
                                } else { // mat >= 13442
                                    if (mat < 13449) {
                                        if (mat < 13443) {
                                            if (mat == 13442) return 182;
                                        } else { // mat >= 13443
                                            if (mat < 13444) {
                                                if (mat == 13443) return 182;
                                            } else { // mat >= 13444
                                                if (mat == 13448) return 30;
                                            }
                                        }
                                    } else { // mat >= 13449
                                        if (mat < 13450) {
                                            if (mat == 13449) return 30;
                                        } else { // mat >= 13450
                                            if (mat < 13451) {
                                                if (mat == 13450) return 30;
                                            } else { // mat >= 13451
                                                if (mat == 13451) return 30;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 13452
                            if (mat < 32131) {
                                if (mat < 13457) {
                                    if (mat < 13454) {
                                        if (mat < 13453) {
                                            if (mat == 13452) return 258;
                                        } else { // mat >= 13453
                                            if (mat == 13453) return 258;
                                        }
                                    } else { // mat >= 13454
                                        if (mat < 13455) {
                                            if (mat == 13454) return 258;
                                        } else { // mat >= 13455
                                            if (mat < 13456) {
                                                if (mat == 13455) return 258;
                                            } else { // mat >= 13456
                                                if (mat == 13456) return 36;
                                            }
                                        }
                                    }
                                } else { // mat >= 13457
                                    if (mat < 13460) {
                                        if (mat < 13458) {
                                            if (mat == 13457) return 36;
                                        } else { // mat >= 13458
                                            if (mat < 13459) {
                                                if (mat == 13458) return 36;
                                            } else { // mat >= 13459
                                                if (mat == 13459) return 36;
                                            }
                                        }
                                    } else { // mat >= 13460
                                        if (mat < 32129) {
                                            if (mat == 32128) return 60020;
                                        } else { // mat >= 32129
                                            if (mat < 32130) {
                                                if (mat == 32129) return 60020;
                                            } else { // mat >= 32130
                                                if (mat == 32130) return 60021;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32131
                                if (mat < 32137) {
                                    if (mat < 32134) {
                                        if (mat < 32132) {
                                            if (mat == 32131) return 60021;
                                        } else { // mat >= 32132
                                            if (mat < 32133) {
                                                if (mat == 32132) return 60022;
                                            } else { // mat >= 32133
                                                if (mat == 32133) return 60022;
                                            }
                                        }
                                    } else { // mat >= 32134
                                        if (mat < 32135) {
                                            if (mat == 32134) return 60023;
                                        } else { // mat >= 32135
                                            if (mat < 32136) {
                                                if (mat == 32135) return 60023;
                                            } else { // mat >= 32136
                                                if (mat == 32136) return 60024;
                                            }
                                        }
                                    }
                                } else { // mat >= 32137
                                    if (mat < 32140) {
                                        if (mat < 32138) {
                                            if (mat == 32137) return 60024;
                                        } else { // mat >= 32138
                                            if (mat < 32139) {
                                                if (mat == 32138) return 60025;
                                            } else { // mat >= 32139
                                                if (mat == 32139) return 60025;
                                            }
                                        }
                                    } else { // mat >= 32140
                                        if (mat < 32141) {
                                            if (mat == 32140) return 60026;
                                        } else { // mat >= 32141
                                            if (mat < 32142) {
                                                if (mat == 32141) return 60026;
                                            } else { // mat >= 32142
                                                if (mat == 32142) return 60027;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 32143
                        if (mat < 32166) {
                            if (mat < 32154) {
                                if (mat < 32148) {
                                    if (mat < 32145) {
                                        if (mat < 32144) {
                                            if (mat == 32143) return 60027;
                                        } else { // mat >= 32144
                                            if (mat == 32144) return 60028;
                                        }
                                    } else { // mat >= 32145
                                        if (mat < 32146) {
                                            if (mat == 32145) return 60028;
                                        } else { // mat >= 32146
                                            if (mat < 32147) {
                                                if (mat == 32146) return 60029;
                                            } else { // mat >= 32147
                                                if (mat == 32147) return 60029;
                                            }
                                        }
                                    }
                                } else { // mat >= 32148
                                    if (mat < 32151) {
                                        if (mat < 32149) {
                                            if (mat == 32148) return 60030;
                                        } else { // mat >= 32149
                                            if (mat < 32150) {
                                                if (mat == 32149) return 60030;
                                            } else { // mat >= 32150
                                                if (mat == 32150) return 60031;
                                            }
                                        }
                                    } else { // mat >= 32151
                                        if (mat < 32152) {
                                            if (mat == 32151) return 60031;
                                        } else { // mat >= 32152
                                            if (mat < 32153) {
                                                if (mat == 32152) return 60032;
                                            } else { // mat >= 32153
                                                if (mat == 32153) return 60032;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32154
                                if (mat < 32160) {
                                    if (mat < 32157) {
                                        if (mat < 32155) {
                                            if (mat == 32154) return 60033;
                                        } else { // mat >= 32155
                                            if (mat < 32156) {
                                                if (mat == 32155) return 60033;
                                            } else { // mat >= 32156
                                                if (mat == 32156) return 60034;
                                            }
                                        }
                                    } else { // mat >= 32157
                                        if (mat < 32158) {
                                            if (mat == 32157) return 60034;
                                        } else { // mat >= 32158
                                            if (mat < 32159) {
                                                if (mat == 32158) return 60035;
                                            } else { // mat >= 32159
                                                if (mat == 32159) return 60035;
                                            }
                                        }
                                    }
                                } else { // mat >= 32160
                                    if (mat < 32163) {
                                        if (mat < 32161) {
                                            if (mat == 32160) return 60036;
                                        } else { // mat >= 32161
                                            if (mat < 32162) {
                                                if (mat == 32161) return 60037;
                                            } else { // mat >= 32162
                                                if (mat == 32162) return 60039;
                                            }
                                        }
                                    } else { // mat >= 32163
                                        if (mat < 32164) {
                                            if (mat == 32163) return 60056;
                                        } else { // mat >= 32164
                                            if (mat < 32165) {
                                                if (mat == 32164) return 60057;
                                            } else { // mat >= 32165
                                                if (mat == 32165) return 60058;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 32166
                            if (mat < 32178) {
                                if (mat < 32172) {
                                    if (mat < 32169) {
                                        if (mat < 32167) {
                                            if (mat == 32166) return 60059;
                                        } else { // mat >= 32167
                                            if (mat < 32168) {
                                                if (mat == 32167) return 60060;
                                            } else { // mat >= 32168
                                                if (mat == 32168) return 60061;
                                            }
                                        }
                                    } else { // mat >= 32169
                                        if (mat < 32170) {
                                            if (mat == 32169) return 60062;
                                        } else { // mat >= 32170
                                            if (mat < 32171) {
                                                if (mat == 32170) return 60063;
                                            } else { // mat >= 32171
                                                if (mat == 32171) return 60064;
                                            }
                                        }
                                    }
                                } else { // mat >= 32172
                                    if (mat < 32175) {
                                        if (mat < 32173) {
                                            if (mat == 32172) return 60065;
                                        } else { // mat >= 32173
                                            if (mat < 32174) {
                                                if (mat == 32173) return 60066;
                                            } else { // mat >= 32174
                                                if (mat == 32174) return 60067;
                                            }
                                        }
                                    } else { // mat >= 32175
                                        if (mat < 32176) {
                                            if (mat == 32175) return 60038;
                                        } else { // mat >= 32176
                                            if (mat < 32177) {
                                                if (mat == 32176) return 60040;
                                            } else { // mat >= 32177
                                                if (mat == 32177) return 60041;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32178
                                if (mat < 32184) {
                                    if (mat < 32181) {
                                        if (mat < 32179) {
                                            if (mat == 32178) return 60042;
                                        } else { // mat >= 32179
                                            if (mat < 32180) {
                                                if (mat == 32179) return 60043;
                                            } else { // mat >= 32180
                                                if (mat == 32180) return 60044;
                                            }
                                        }
                                    } else { // mat >= 32181
                                        if (mat < 32182) {
                                            if (mat == 32181) return 60045;
                                        } else { // mat >= 32182
                                            if (mat < 32183) {
                                                if (mat == 32182) return 60046;
                                            } else { // mat >= 32183
                                                if (mat == 32183) return 60047;
                                            }
                                        }
                                    }
                                } else { // mat >= 32184
                                    if (mat < 32187) {
                                        if (mat < 32185) {
                                            if (mat == 32184) return 60048;
                                        } else { // mat >= 32185
                                            if (mat < 32186) {
                                                if (mat == 32185) return 60049;
                                            } else { // mat >= 32186
                                                if (mat == 32186) return 60050;
                                            }
                                        }
                                    } else { // mat >= 32187
                                        if (mat < 32188) {
                                            if (mat == 32187) return 60051;
                                        } else { // mat >= 32188
                                            if (mat < 32189) {
                                                if (mat == 32188) return 60052;
                                            } else { // mat >= 32189
                                                if (mat == 32189) return 60053;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else { // mat >= 32190
                    if (mat < 32244) {
                        if (mat < 32213) {
                            if (mat < 32201) {
                                if (mat < 32195) {
                                    if (mat < 32192) {
                                        if (mat < 32191) {
                                            if (mat == 32190) return 60054;
                                        } else { // mat >= 32191
                                            if (mat == 32191) return 60055;
                                        }
                                    } else { // mat >= 32192
                                        if (mat < 32193) {
                                            if (mat == 32192) return 60036;
                                        } else { // mat >= 32193
                                            if (mat < 32194) {
                                                if (mat == 32193) return 60037;
                                            } else { // mat >= 32194
                                                if (mat == 32194) return 60039;
                                            }
                                        }
                                    }
                                } else { // mat >= 32195
                                    if (mat < 32198) {
                                        if (mat < 32196) {
                                            if (mat == 32195) return 60056;
                                        } else { // mat >= 32196
                                            if (mat < 32197) {
                                                if (mat == 32196) return 60057;
                                            } else { // mat >= 32197
                                                if (mat == 32197) return 60058;
                                            }
                                        }
                                    } else { // mat >= 32198
                                        if (mat < 32199) {
                                            if (mat == 32198) return 60059;
                                        } else { // mat >= 32199
                                            if (mat < 32200) {
                                                if (mat == 32199) return 60060;
                                            } else { // mat >= 32200
                                                if (mat == 32200) return 60061;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32201
                                if (mat < 32207) {
                                    if (mat < 32204) {
                                        if (mat < 32202) {
                                            if (mat == 32201) return 60062;
                                        } else { // mat >= 32202
                                            if (mat < 32203) {
                                                if (mat == 32202) return 60063;
                                            } else { // mat >= 32203
                                                if (mat == 32203) return 60064;
                                            }
                                        }
                                    } else { // mat >= 32204
                                        if (mat < 32205) {
                                            if (mat == 32204) return 60065;
                                        } else { // mat >= 32205
                                            if (mat < 32206) {
                                                if (mat == 32205) return 60066;
                                            } else { // mat >= 32206
                                                if (mat == 32206) return 60067;
                                            }
                                        }
                                    }
                                } else { // mat >= 32207
                                    if (mat < 32210) {
                                        if (mat < 32208) {
                                            if (mat == 32207) return 60038;
                                        } else { // mat >= 32208
                                            if (mat < 32209) {
                                                if (mat == 32208) return 60040;
                                            } else { // mat >= 32209
                                                if (mat == 32209) return 60041;
                                            }
                                        }
                                    } else { // mat >= 32210
                                        if (mat < 32211) {
                                            if (mat == 32210) return 60042;
                                        } else { // mat >= 32211
                                            if (mat < 32212) {
                                                if (mat == 32211) return 60043;
                                            } else { // mat >= 32212
                                                if (mat == 32212) return 60044;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 32213
                            if (mat < 32224) {
                                if (mat < 32218) {
                                    if (mat < 32215) {
                                        if (mat < 32214) {
                                            if (mat == 32213) return 60045;
                                        } else { // mat >= 32214
                                            if (mat == 32214) return 60046;
                                        }
                                    } else { // mat >= 32215
                                        if (mat < 32216) {
                                            if (mat == 32215) return 60047;
                                        } else { // mat >= 32216
                                            if (mat < 32217) {
                                                if (mat == 32216) return 60048;
                                            } else { // mat >= 32217
                                                if (mat == 32217) return 60049;
                                            }
                                        }
                                    }
                                } else { // mat >= 32218
                                    if (mat < 32221) {
                                        if (mat < 32219) {
                                            if (mat == 32218) return 60050;
                                        } else { // mat >= 32219
                                            if (mat < 32220) {
                                                if (mat == 32219) return 60051;
                                            } else { // mat >= 32220
                                                if (mat == 32220) return 60052;
                                            }
                                        }
                                    } else { // mat >= 32221
                                        if (mat < 32222) {
                                            if (mat == 32221) return 60053;
                                        } else { // mat >= 32222
                                            if (mat < 32223) {
                                                if (mat == 32222) return 60054;
                                            } else { // mat >= 32223
                                                if (mat == 32223) return 60055;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32224
                                if (mat < 32235) {
                                    if (mat < 32229) {
                                        if (mat < 32225) {
                                            if (mat == 32224) return 235;
                                        } else { // mat >= 32225
                                            if (mat < 32227) {
                                                if (mat == 32226) return 234;
                                            } else { // mat >= 32227
                                                if (mat == 32228) return 238;
                                            }
                                        }
                                    } else { // mat >= 32229
                                        if (mat < 32231) {
                                            if (mat == 32230) return 232;
                                        } else { // mat >= 32231
                                            if (mat < 32233) {
                                                if (mat == 32232) return 231;
                                            } else { // mat >= 32233
                                                if (mat == 32234) return 233;
                                            }
                                        }
                                    }
                                } else { // mat >= 32235
                                    if (mat < 32241) {
                                        if (mat < 32237) {
                                            if (mat == 32236) return 236;
                                        } else { // mat >= 32237
                                            if (mat < 32239) {
                                                if (mat == 32238) return 230;
                                            } else { // mat >= 32239
                                                if (mat == 32240) return 226;
                                            }
                                        }
                                    } else { // mat >= 32241
                                        if (mat < 32242) {
                                            if (mat == 32241) return 225;
                                        } else { // mat >= 32242
                                            if (mat < 32243) {
                                                if (mat == 32242) return 229;
                                            } else { // mat >= 32243
                                                if (mat == 32243) return 223;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else { // mat >= 32244
                        if (mat < 32271) {
                            if (mat < 32259) {
                                if (mat < 32253) {
                                    if (mat < 32246) {
                                        if (mat < 32245) {
                                            if (mat == 32244) return 222;
                                        } else { // mat >= 32245
                                            if (mat == 32245) return 224;
                                        }
                                    } else { // mat >= 32246
                                        if (mat < 32247) {
                                            if (mat == 32246) return 227;
                                        } else { // mat >= 32247
                                            if (mat < 32248) {
                                                if (mat == 32247) return 221;
                                            } else { // mat >= 32248
                                                if (mat == 32252) return 160;
                                            }
                                        }
                                    }
                                } else { // mat >= 32253
                                    if (mat < 32256) {
                                        if (mat < 32254) {
                                            if (mat == 32253) return 160;
                                        } else { // mat >= 32254
                                            if (mat < 32255) {
                                                if (mat == 32254) return 160;
                                            } else { // mat >= 32255
                                                if (mat == 32255) return 160;
                                            }
                                        }
                                    } else { // mat >= 32256
                                        if (mat < 32257) {
                                            if (mat == 32256) return 60068;
                                        } else { // mat >= 32257
                                            if (mat < 32258) {
                                                if (mat == 32257) return 60068;
                                            } else { // mat >= 32258
                                                if (mat == 32258) return 60068;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32259
                                if (mat < 32265) {
                                    if (mat < 32262) {
                                        if (mat < 32260) {
                                            if (mat == 32259) return 60068;
                                        } else { // mat >= 32260
                                            if (mat < 32261) {
                                                if (mat == 32260) return 60069;
                                            } else { // mat >= 32261
                                                if (mat == 32261) return 60069;
                                            }
                                        }
                                    } else { // mat >= 32262
                                        if (mat < 32263) {
                                            if (mat == 32262) return 60069;
                                        } else { // mat >= 32263
                                            if (mat < 32264) {
                                                if (mat == 32263) return 60069;
                                            } else { // mat >= 32264
                                                if (mat == 32264) return 60023;
                                            }
                                        }
                                    }
                                } else { // mat >= 32265
                                    if (mat < 32268) {
                                        if (mat < 32266) {
                                            if (mat == 32265) return 60023;
                                        } else { // mat >= 32266
                                            if (mat < 32267) {
                                                if (mat == 32266) return 60023;
                                            } else { // mat >= 32267
                                                if (mat == 32267) return 60023;
                                            }
                                        }
                                    } else { // mat >= 32268
                                        if (mat < 32269) {
                                            if (mat == 32268) return 60070;
                                        } else { // mat >= 32269
                                            if (mat < 32270) {
                                                if (mat == 32269) return 60070;
                                            } else { // mat >= 32270
                                                if (mat == 32270) return 60070;
                                            }
                                        }
                                    }
                                }
                            }
                        } else { // mat >= 32271
                            if (mat < 32300) {
                                if (mat < 32294) {
                                    if (mat < 32289) {
                                        if (mat < 32272) {
                                            if (mat == 32271) return 60070;
                                        } else { // mat >= 32272
                                            if (mat < 32283) {
                                                if (mat == 32282) return 29;
                                            } else { // mat >= 32283
                                                if (mat == 32288) return 237;
                                            }
                                        }
                                    } else { // mat >= 32289
                                        if (mat < 32291) {
                                            if (mat == 32290) return 228;
                                        } else { // mat >= 32291
                                            if (mat < 32293) {
                                                if (mat == 32292) return 60071;
                                            } else { // mat >= 32293
                                                if (mat == 32293) return 60071;
                                            }
                                        }
                                    }
                                } else { // mat >= 32294
                                    if (mat < 32297) {
                                        if (mat < 32295) {
                                            if (mat == 32294) return 60071;
                                        } else { // mat >= 32295
                                            if (mat < 32296) {
                                                if (mat == 32295) return 60071;
                                            } else { // mat >= 32296
                                                if (mat == 32296) return 60072;
                                            }
                                        }
                                    } else { // mat >= 32297
                                        if (mat < 32298) {
                                            if (mat == 32297) return 60072;
                                        } else { // mat >= 32298
                                            if (mat < 32299) {
                                                if (mat == 32298) return 60072;
                                            } else { // mat >= 32299
                                                if (mat == 32299) return 60072;
                                            }
                                        }
                                    }
                                }
                            } else { // mat >= 32300
                                if (mat < 32310) {
                                    if (mat < 32303) {
                                        if (mat < 32301) {
                                            if (mat == 32300) return 36;
                                        } else { // mat >= 32301
                                            if (mat < 32302) {
                                                if (mat == 32301) return 36;
                                            } else { // mat >= 32302
                                                if (mat == 32302) return 36;
                                            }
                                        }
                                    } else { // mat >= 32303
                                        if (mat < 32304) {
                                            if (mat == 32303) return 36;
                                        } else { // mat >= 32304
                                            if (mat < 32309) {
                                                if (mat == 32308) return 249;
                                            } else { // mat >= 32309
                                                if (mat == 32309) return 249;
                                            }
                                        }
                                    }
                                } else { // mat >= 32310
                                    if (mat < 32313) {
                                        if (mat < 32311) {
                                            if (mat == 32310) return 249;
                                        } else { // mat >= 32311
                                            if (mat < 32312) {
                                                if (mat == 32311) return 249;
                                            } else { // mat >= 32312
                                                if (mat == 32312) return 255;
                                            }
                                        }
                                    } else { // mat >= 32313
                                        if (mat < 32314) {
                                            if (mat == 32313) return 255;
                                        } else { // mat >= 32314
                                            if (mat < 32315) {
                                                if (mat == 32314) return 255;
                                            } else { // mat >= 32315
                                                if (mat == 32315) return 255;
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
        if (mat < 10564) {
            if (mat < 10356) {
                if (mat < 10300) {
                    if (mat < 10228) {
                        if (mat == 10056) return  14; // Lava Cauldron
                        if (mat == 10068 || mat == 10070) return  13; // Lava
                        if (mat == 10072) return   5; // Fire
                        if (mat == 10076) return  27; // Soul Fire
                        #if defined GLOWING_NETHER_TREES && defined DO_IPBR_LIGHTS
                        if (mat == 10216) return  62; // Crimson Stem, Crimson Hyphae
                        if (mat == 10224) return  63; // Warped Stem, Warped Hyphae
                        #endif
                    } else {
                        if (mat == 10228) return 60055; // Bedrock
                        #if defined GLOWING_ORE_ANCIENTDEBRIS && defined DO_IPBR_LIGHTS
                        if (mat == 10252) return  52; // Ancient Debris
                        #endif
                        #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                        if (mat == 10268) return 43; // Raw Iron Block
                        #endif
                        #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                        if (mat == 10268) return 43; // Raw Iron Block
                        #endif
                        #if defined GLOWING_ORE_IRON && defined DO_IPBR_LIGHTS
                        if (mat == 10272) return  43; // Iron Ore
                        if (mat == 10276) return  43; // Deepslate Iron Ore
                        #endif
                        #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                        if (mat == 10280) return 45; // Raw Coper Block
                        #endif
                        #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                        if (mat == 10280) return 45; // Raw Coper Block
                        #endif
                        #if defined GLOWING_ORE_COPPER && defined DO_IPBR_LIGHTS
                        if (mat == 10284) return  45; // Copper Ore
                        if (mat == 10288) return  45; // Deepslate Copper Ore
                        #endif
                        #if defined GLOWING_RAW_BLOCKS && defined DO_IPBR_LIGHTS
                        if (mat == 10296) return 44; // Raw Gold Block
                        #endif
                    }
                } else {
                    if (mat < 10332) {
                        #if defined GLOWING_ORE_GOLD && defined DO_IPBR_LIGHTS
                        if (mat == 10300) return  44; // Gold Ore
                        if (mat == 10302) return  44; // Deepslate Gold Ore
                        #endif
                        #if defined GLOWING_ORE_MODDED && defined DO_IPBR_LIGHTS
                        if (mat == 10304) return  39; // Modded Pink Ore
                        if (mat == 10306) return  36; // Modded Purple Ore
                        #endif
                        #if defined GLOWING_ORE_NETHERGOLD && defined DO_IPBR_LIGHTS
                        if (mat == 10308) return  50; // Nether Gold Ore
                        #endif
                        #if defined GLOWING_ORE_DIAMOND && defined DO_IPBR_LIGHTS
                        if (mat == 10320) return  48; // Diamond Ore
                        if (mat == 10324) return  48; // Deepslate Diamond Ore
                        #endif
                    } else {
                        if (mat == 10332) return  36; // Amethyst Cluster, Amethyst Buds
                        #if defined GLOWING_EMERALD_BLOCK && defined DO_IPBR_LIGHTS
                        if (mat == 10336) return 47; // Emerald Block
                        #endif
                        #if defined GLOWING_ORE_EMERALD && defined DO_IPBR_LIGHTS
                        if (mat == 10340) return  47; // Emerald Ore
                        if (mat == 10344) return  47; // Deepslate Emerald Ore
                        #endif
                        #if defined EMISSIVE_LAPIS_BLOCK && defined DO_IPBR_LIGHTS
                        if (mat == 10352) return  42; // Lapis Block
                        #endif
                    }
                }
            } else {
                if (mat < 10496) {
                    if (mat < 10448) {
                        #if defined GLOWING_ORE_LAPIS && defined DO_IPBR_LIGHTS
                        if (mat == 10356) return  46; // Lapis Ore
                        if (mat == 10360) return  46; // Deepslate Lapis Ore
                        #endif
                        #if defined GLOWING_ORE_NETHERQUARTZ && defined DO_IPBR_LIGHTS
                        if (mat == 10368) return  49; // Nether Quartz Ore
                        #endif
                        if (mat == 10396) return  11; // Jack o'Lantern
                        if (mat == 10404) return   6; // Sea Pickle:Waterlogged
                        if (mat == 10412) return  10; // Glowstone
                    } else {
                        if (mat == 10448) return  18; // Sea Lantern
                        if (mat == 10452) return  37; // Magma Block
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10456) return  60; // Command Block
                        #endif
                        if (mat == 10476) return  26; // Crying Obsidian
                        #if defined GLOWING_ORE_GILDEDBLACKSTONE && defined DO_IPBR_LIGHTS
                        if (mat == 10484) return  51; // Gilded Blackstone
                        #endif
                    }
                } else {
                    if (mat < 10528) {
                        if (mat == 10496) return   2; // Torch
                        if (mat == 10500) return   3; // End Rod
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10508) return  39; // Chorus Flower:Alive
                        if (mat == 10512) return  39; // Chorus Flower:Dead
                        #endif
                        if (mat == 10516) return  21; // Furnace:Lit
                    } else {
                        if (mat == 10528) return  28; // Soul Torch
                        if (mat == 10544) return  34; // Glow Lichen
                        if (mat == 10548) return  33; // Enchanting Table
                        if (mat == 10556) return  58; // End Portal Frame:Active
                        if (mat == 10560 || mat == 10562) return  12; // Lantern
                    }
                }
            }
        } else {
            if (mat < 10696) {
                if (mat < 10620) {
                    if (mat < 10592) {
                        if (mat == 10564) return  29; // Soul Lantern
                        #if defined EMISSIVE_DRAGON_EGG && defined DO_IPBR_LIGHTS
                        if (mat == 10572) return  38; // Dragon Egg
                        #endif
                        if (mat == 10576) return  22; // Smoker:Lit
                        if (mat == 10580) return  23; // Blast Furnace:Lit
                    } else {
                        if (mat == 10592) return  17; // Respawn Anchor:Lit
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10596) return  66; // Redstone Wire:Lit
                        #endif
                        if (mat == 10604) return  35; // Redstone Torch
                        #if defined EMISSIVE_REDSTONE_BLOCK && defined DO_IPBR_LIGHTS
                        if (mat == 10608) return  41; // Redstone Block
                        #endif
                        #if defined GLOWING_ORE_REDSTONE && defined DO_IPBR_LIGHTS
                        if (mat == 10612) return  32; // Redstone Ore:Unlit
                        #endif
                        if (mat == 10616) return  31; // Redstone Ore:Lit
                    }
                } else {
                    if (mat < 10648) {
                        #if defined GLOWING_ORE_REDSTONE && defined DO_IPBR_LIGHTS
                        if (mat == 10620) return  32; // Deepslate Redstone Ore:Unlit
                        #endif
                        if (mat == 10624) return  31; // Deepslate Redstone Ore:Lit
                        if (mat == 10632) return  20; // Cave Vines:With Glow Berries
                        if (mat == 10640) return  16; // Redstone Lamp:Lit
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10644) return  67; // Repeater:Lit, Comparator:Lit
                        if (mat == 10646) return  66; // Comparator:Unlit:Subtract
                        #endif
                    } else {
                        if (mat == 10648) return  19; // Shroomlight
                        if (mat == 10652) return  15; // Campfire:Lit
                        if (mat == 10656) return  30; // Soul Campfire:Lit
                        if (mat == 10680) return   7; // Ochre Froglight
                        if (mat == 10684) return   8; // Verdant Froglight
                        if (mat == 10688) return   9; // Pearlescent Froglight
                    }
                }
            } else {
                if (mat < 10868) {
                    if (mat < 10780) {
                        if (mat == 10696) return  57; // Sculk, Sculk Catalyst, Sculk Vein, Sculk Sensor:Unlit
                        if (mat == 10700) return  57; // Sculk Shrieker
                        if (mat == 10704) return  57; // Sculk Sensor:Lit
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10708) return  53; // Spawner
                        if (mat == 10736) return  64; // Structure Block, Jigsaw Block, Test Block, Test Instance Block, Test Block, Test Instance Block
                        if (mat == 10776) return  61; // Warped Fungus, Crimson Fungus
                        #endif
                    } else {
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10780) return  61; // Potted Warped Fungus, Potted Crimson Fungus
                        #endif
                        if (mat == 10784) return  36; // Calibrated Sculk Sensor:Unlit
                        if (mat == 10788) return  36; // Calibrated Sculk Sensor:Lit
                        #ifdef DO_IPBR_LIGHTS
                        if (mat == 10836) return  40; // Brewing Stand
                        #endif
                        if (mat == 10852) return  55; // Copper Bulb:BrighterOnes:Lit
                        if (mat == 10856) return  56; // Copper Bulb:DimmerOnes:Lit
                    }
                } else {
                    if (mat < 30020) {
                        if (mat < 20000){
                            if (mat == 10868) return  54; // Trial Spawner:NotOminous:Active, Vault:NotOminous:Active
                            if (mat == 10872) return  68; // Vault:Inactive
                            if (mat == 10876) return  69; // Trial Spawner:Ominous:Active, Vault:Ominous:Active
                            #ifdef DO_IPBR_LIGHTS
                            if (mat == 10884) return  65; // Weeping Vines Plant
                            #endif
                            #ifndef COLORED_CANDLE_LIGHT
                            if (mat >= 10900 && mat <= 10922) return 24; // Standard Candles:Lit
                            #else
                            if (mat == 10900) return  24; // Standard Candles:Lit
                            if (mat == 10902) return  70; // Red Candles:Lit
                            if (mat == 10904) return  71; // Orange Candles:Lit
                            if (mat == 10906) return  72; // Yellow Candles:Lit
                            if (mat == 10908) return  73; // Lime Candles:Lit
                            if (mat == 10910) return  74; // Green Candles:Lit
                            if (mat == 10912) return  75; // Cyan Candles:Lit
                            if (mat == 10914) return  76; // Light Blue Candles:Lit
                            if (mat == 10916) return  77; // Blue Candles:Lit
                            if (mat == 10918) return  78; // Purple Candles:Lit
                            if (mat == 10920) return  79; // Magenta Candles:Lit
                            if (mat == 10922) return  80; // Pink Candles:Lit
                            #endif
                            if (mat == 10924) return  81; // Open Eyeblossom
                            if (mat == 10948) return  82; // Creaking Heart: Active
                            if (mat == 10972) return  83; // Firefly Bush
                        } else {
                            if (mat == 21000) return  97; // White Modded Blocks - Also used For Black / Gray
                            if (mat == 21002) return  43; // Brown Modded Blocks
                            if (mat == 21004) return  70; // Red Modded Blocks
                            if (mat == 21006) return  71; // Orange Modded Blocks
                            if (mat == 21008) return  72; // Yellow Modded Blocks
                            if (mat == 21010) return  73; // Lime Modded Blocks
                            if (mat == 21012) return  74; // Green Modded Blocks
                            if (mat == 21014) return  75; // Cyan Modded Blocks
                            if (mat == 21016) return  76; // Light Blue Modded Blocks
                            if (mat == 21018) return  77; // Blue Modded Blocks
                            if (mat == 21020) return  78; // Purple Modded Blocks
                            if (mat == 21022) return  79; // Magenta Modded Blocks
                            if (mat == 21024) return  80; // Pink Modded Blocks
                            if (mat == 30008) return 60054; // Tinted Glass
                            if (mat == 30012) return 60013; // Slime Block
                            if (mat == 30016) return 60001; // Honey Block
                        }
                    } else {
                        if (mat == 30020) return  25; // Nether Portal
                        if (mat >= 31000 && mat < 32000) return 60000 + (mat - 31000) / 2; // Stained Glass+
                        if (mat == 32004) return 60016; // Ice
                        if (mat == 32008) return 60017; // Glass
                        if (mat == 32012) return 60018; // Glass Pane
                        if (mat == 32016) return   4; // Beacon
                    }
                }
            }
        }

        return 1; // Standard Block
    }

    #if defined SHADOW && defined VERTEX_SHADER
        void UpdateVoxelMap(int mat, vec3 normal) {
            if (mat == 32000 // Water
                || mat < 30000 && mat % 2 == 1 // Non-solid terrain
                || mat < 10000 // Block entities or unknown blocks that we treat as non-solid
            ) return;

            vec3 modelPos = gl_Vertex.xyz + at_midBlock.xyz / 64.0;
            vec3 viewPos = transform(gl_ModelViewMatrix, modelPos);
            vec3 scenePos = transform(shadowModelViewInverse, viewPos);
            vec3 voxelPos = SceneToVoxel(scenePos);

            bool isEligible = any(equal(ivec4(renderStage), ivec4(
                MC_RENDER_STAGE_TERRAIN_SOLID,
                MC_RENDER_STAGE_TERRAIN_TRANSLUCENT,
                MC_RENDER_STAGE_TERRAIN_CUTOUT,
                MC_RENDER_STAGE_TERRAIN_CUTOUT_MIPPED)));

            if (isEligible && CheckInsideVoxelVolume(voxelPos)) {
                int voxelData = GetVoxelIDs(mat);
                
                imageStore(voxel_img, ivec3(voxelPos), uvec4(voxelData, 0u, 0u, 0u));
            }
        }
    #endif

#endif //INCLUDE_VOXELIZATION
