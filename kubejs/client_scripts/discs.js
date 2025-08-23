ClientEvents.lang('en_us', event => {
  let discLang = {
    'pixelated_protagonist': 'Tolxxd - Pixelated Protagonist',
    'character_cartwheel': 'Tolxxd - Character Cartwheel',
    'old_school': 'Tolxxd - Old School',
    'hype_dropped': 'Clutterfunk - Hype Dropped',
    'creakstep': 'Camilo Forero - Creakstep',
    'infinite_spooky_amethyst': 'Jukio Kallio - Infinite Spooky Amethyst',
    'minecraft_live_2022': 'Element Paul - Minecraft Live 2022',
    'fox': 'RENREN - fox',
    'hullabaloo': "RENREN - hullabaloo",
    'kilobyte': "RENREN - kilobyte",
    'warp': "RENREN - warp",
    'capybara': "RENREN - capybara",
    'star': "RENREN - star",
    'twelve': "RENREN - 12",
    'sun': "RENREN - sun",
    'fractal': "RENREN - fractal",
    'fragment': "RENREN - fragment"

  }
  for (let [id, txt] of Object.entries(discLang)) {
    event.add('kubejs', `item.kubejs.music_disc_${id}`, 'Music Disc')
    event.add('kubejs', `item.kubejs.music_disc_${id}.desc`, txt)
  }
})