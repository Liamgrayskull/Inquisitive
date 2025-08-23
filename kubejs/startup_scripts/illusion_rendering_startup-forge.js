let Minecraft = Java.loadClass("net.minecraft.client.Minecraft")
let OverlayTexture = Java.loadClass("net.minecraft.client.renderer.texture.OverlayTexture");
let RenderType = Java.loadClass("net.minecraft.client.renderer.RenderType");
let Axis = Java.loadClass("com.mojang.math.Axis");
let RenderLevelStageEvent = Java.loadClass("net.minecraftforge.client.event.RenderLevelStageEvent$Stage")
let Mth = Java.loadClass("net.minecraft.util.Mth")
// Set the number of illusions, I've tested this and with a hundred models it doesn't lag >.>
let illusionCount = 4;
// Set the minimum and maximum radius your clones should render at
let minRadius = 2;
let maxRadius = 8;
ForgeEvents.onEvent("net.minecraftforge.client.event.RenderLevelStageEvent", event => global.levelRender(event))
/**
 * 
 * @param {Internal.RenderLevelStageEvent} event 
 */
global.levelRender = event => {
    let { poseStack, camera, stage, partialTick } = event;
    let player = Minecraft.getInstance().player;
    if (player == null) return;
    let buffer = Minecraft.getInstance().renderBuffers().bufferSource()
    // We return after entities are rendered for proper rendering order
    if (stage != RenderLevelStageEvent.AFTER_ENTITIES) return;
    if (!player.persistentData.init) player.persistentData.init = 0;
    if (!player.persistentData.illOff) player.persistentData.illOff = [];
    // Reset model random positions if the client player holds a diamond
    if (player.mainHandItem.id == "minecraft:diamond") {
        player.persistentData.init = 0;
        player.persistentData.illOff = [];
    }
    // Set random positions once based on initialization
    if (player.persistentData.init == 0) {
        let baseYaw = (player.yaw % 360) * (JavaMath.PI / 180);
        for (let i = 0; i < illusionCount; i++) {
            let angle = baseYaw + (i * (2 * JavaMath.PI) / illusionCount);

            let radius = minRadius + (JavaMath.random() * (maxRadius - minRadius));
            let offsetX = radius * JavaMath.cos(angle);
            let offsetZ = radius * JavaMath.sin(angle);
            offsetX += -1.5 + (JavaMath.random() * 3);
            offsetZ += -1.5 + (JavaMath.random() * 3);
            player.persistentData.illOff.push({ x: offsetX, y: 0, z: offsetZ });
        }
        player.persistentData.init = 1;
    }
    // Render each model with its associated offset and rotation
    try {
        if (!player.persistentData.ModelsToRender) player.persistentData.ModelsToRender = []
        for (let i = 0; i < player.persistentData.ModelsToRender.length; i++) {
            let element = player.persistentData.ModelsToRender[i];
            if (element == null) return
            let username = element.Name;
            if (username == null) return
            let userData = player.persistentData.get(username);
            if (userData == null) return
            if (userData.HoldingAxe == 1) {
                player.persistentData.illOff.forEach(offset => {
                    let coordinatesString = camera.position.toString();
                    let coordinatesArray = coordinatesString.replace("(", '').replace(")", '').split(',');
                    let [xCoord, yCoord, zCoord] = coordinatesArray;
                    renderEntity(username, xCoord, yCoord, zCoord, partialTick, poseStack, buffer, offset)
                });
            }
        }
    } catch (error) {
        console.log(error);
    }
};

function renderEntity(username, pCamX, pCamY, pCamZ, pPartialTick, pPoseStack, pBufferSource, offset) {
    try {
        let player = null
        Minecraft.getInstance().level.players.forEach(p => {
            if (p.username == username) {
                player = p
            }
        })
        if (player == null) return
        let d0 = Mth.lerp(pPartialTick, player.xOld, (player.getX()));
        let d1 = Mth.lerp(pPartialTick, player.yOld, (player.getY()));
        let d2 = Mth.lerp(pPartialTick, player.zOld, (player.getZ()));
        let f = Mth.lerp(pPartialTick, player.yRotO, player.yaw);

        Minecraft.getInstance().entityRenderDispatcher.render(
            player,
            (d0 - pCamX) - offset.x,
            (d1 - pCamY) - offset.y,
            (d2 - pCamZ) - offset.z,
            f,
            pPartialTick,
            pPoseStack,
            pBufferSource,
            Minecraft.getInstance().entityRenderDispatcher.getPackedLightCoords(player, pPartialTick)
        );
    } catch (error) {
        console.log(error);
    }
}
