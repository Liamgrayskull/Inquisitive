/**
 * @file Custom music disc item generation. Disc lang generation can be found in client_scripts.
 * @author Prunoidae <https://github.com/Prunoideae> Original script author
 * @author CelestialAbyss <https://github.com/CelestialAbyss> Modpack lead
 */

// ignored: false


Platform.mods.kubejs.name = 'Inquisitive'
Platform.mods.vanillabackport.name = 'Minecraft'
Platform.mods.trials.name = 'Minecraft'


ItemEvents.modification(event => {

  event.modify('enlightened_end:stardust', item => {
    const ItemBuilder = Java.loadClass("dev.latvian.mods.kubejs.item.custom.BasicItemJS$Builder")
    const builder = new ItemBuilder("enlightened_end:stardust").glow(true);
    item.setItemBuilder(builder);
  })
  event.modify('eidolon:soul_shard', item => {
    const ItemBuilder = Java.loadClass("dev.latvian.mods.kubejs.item.custom.BasicItemJS$Builder")
    const builder = new ItemBuilder("eidolon:soul_shard").glow(true);
    item.setItemBuilder(builder);
  })
  event.modify('eidolon:lesser_soul_gem', item => {
    const ItemBuilder = Java.loadClass("dev.latvian.mods.kubejs.item.custom.BasicItemJS$Builder")
    const builder = new ItemBuilder("eidolon:lesser_soul_gem").glow(true);
    item.setItemBuilder(builder);
  })
  event.modify('undergarden:regalium_crystal', item => {
    const ItemBuilder = Java.loadClass("dev.latvian.mods.kubejs.item.custom.BasicItemJS$Builder")
    const builder = new ItemBuilder("undergarden:regalium_crystal").glow(true);
    item.setItemBuilder(builder);
  })
  event.modify('eidolon:shadow_gem', item => {
    const ItemBuilder = Java.loadClass("dev.latvian.mods.kubejs.item.custom.BasicItemJS$Builder")
    const builder = new ItemBuilder("eidolon:shadow_gem").glow(true);
    item.setItemBuilder(builder);
  })

})
const musicDiscProperties = {
  pixelated_protagonist: { duration: 255, output: 6, disc_texture: 'kubejs:item/music_disc_pixelated_protagonist' },
  character_cartwheel: { duration: 337, output: 4, disc_texture: 'kubejs:item/music_disc_character_cartwheel' },
  old_school: { duration: 201, output: 5, disc_texture: 'kubejs:item/music_disc_old_school' },
  hype_dropped: { duration: 153, output: 15, disc_texture: 'kubejs:item/music_disc_hype_dropped' },
  creakstep: { duration: 209, output: 3, disc_texture: 'kubejs:item/music_disc_creakstep' },
  infinite_spooky_amethyst: { duration: 452, output: 5, disc_texture: 'kubejs:item/music_disc_infinite_spooky_amethyst' },
  minecraft_live_2022: { duration: 204, output: 2, disc_texture: 'kubejs:item/music_disc_minecraft_live_2022' },
  twelve: { duration: 144, output: 12, disc_texture: 'kubejs:item/music_disc_twelve' },
  capybara: { duration: 253, output: 13, disc_texture: 'kubejs:item/music_disc_capybara' },
  fractal: { duration: 156, output: 13, disc_texture: 'kubejs:item/music_disc_fractal' },
  fragment: { duration: 18, output: 1, disc_texture: 'kubejs:item/music_disc_fragment' },
  hullabaloo: { duration: 214, output: 7, disc_texture: 'kubejs:item/music_disc_hullabaloo' },
  kilobyte: { duration: 243, output: 9, disc_texture: 'kubejs:item/music_disc_kilobyte' },
  star: { duration: 248, output: 10, disc_texture: 'kubejs:item/music_disc_star' },
  sun: { duration: 218, output: 11, disc_texture: 'kubejs:item/music_disc_sun' },
  warp: { duration: 220, output: 11, disc_texture: 'kubejs:item/music_disc_warp' },
  fox: { duration: 156, output: 14, disc_texture: 'kubejs:item/music_disc_fox' },




}
let musicDisc = [
  'pixelated_protagonist',
  'character_cartwheel',
  'old_school',
  'hype_dropped',
  'creakstep',
  'infinite_spooky_amethyst',
  'minecraft_live_2022',
  'twelve',
  'capybara',
  'fractal',
  'fragment',
  'hullabaloo',
  'kilobyte',
  'star',
  'sun',
  'warp',
  'fox',
]

StartupEvents.registry('sound_event', event => {
  for (let element of musicDisc) {
    event.create(element)
  }
})

StartupEvents.registry('item', event => {
  for (let element of musicDisc) {
    event.create(`kubejs:music_disc_${element}`, 'music_disc')
      .song(`kubejs:${element}`, musicDiscProperties[element].duration)
      .analogOutput(musicDiscProperties[element].output)
      .texture(musicDiscProperties[element].disc_texture)
      .tag('minecraft:music_discs')
      .tag('minecraft:creeper_drop_music_discs')
  }
})