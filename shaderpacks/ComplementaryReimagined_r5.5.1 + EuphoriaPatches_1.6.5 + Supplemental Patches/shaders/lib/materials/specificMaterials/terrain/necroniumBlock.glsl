// TODO find out why this doesnt work
materialMask = OSIEBCA * 24;  // Necronium Fresnel

smoothnessG = pow2(color.g) * 2.0;
highlightMult = smoothnessG * 2.0;
smoothnessD = smoothnessG;

#ifdef COATED_TEXTURES
    noiseFactor = 0.33;
#endif