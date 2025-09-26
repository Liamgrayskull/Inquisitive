/* 
 * ServerEvents.recipes(callback) is a function that accepts another function,
 * called the "callback", as a parameter. The callback gets run when the 
 * server is working on recipes, and then we can make our own changes.
 * When the callback runs, it is also known as the event "firing". 
*/

// Listen for the "recipes" server event.
ServerEvents.recipes(event => {
  // You can replace `event` with any name you like, as
  // long as you change it inside the callback too!

  // This part, inside the curly braces, is the callback.
  // You can modify as many recipes as you like in here,
  // without needing to use ServerEvents.recipes() again.

  console.log('Hello! The recipe event has fired!')

  //Recipe Removals
  //-------------------------------------------------------------------------------------------

  event.remove({ output: 'minecraft:spyglass' })

  //Smelting Recipes
  //-------------------------------------------------------------------------------------------

  event.blasting('enlightened_end:irradium_bar', 'alexscaves:uranium').xp(8).cookingTime(800)
  event.smelting('undergarden:froststeel_block', 'undergarden:raw_froststeel_block').xp(4).cookingTime(800)
  event.smelting('undergarden:cloggrum_block', 'undergarden:raw_cloggrum_block').xp(4).cookingTime(800)
  event.smelting('oreganized:asbestos_block', 'oreganized:raw_asbestos_block').xp(12).cookingTime(800)
  event.smelting('etcetera:bismuth_block', 'etcetera:raw_bismuth_block').xp(4).cookingTime(800)
  event.smelting('oreganized:silver_block', 'oreganized:raw_silver_block').xp(4).cookingTime(800)
  event.smelting('enlightened_end:depleted_irradium_bar', 'create:crushed_raw_uranium').xp(2).cookingTime(400)
  event.smelting('caverns_and_chasms:silver_ingot', 'caverns_and_chasms:raw_silver').xp(0.5).cookingTime(400)
  event.smelting('caverns_and_chasms:silver_ingot', 'create:crushed_raw_silver').xp(1).cookingTime(400)
  event.smelting('caverns_and_chasms:silver_ingot', 'caverns_and_chasms:silver_ore').xp(1).cookingTime(400)
  event.smelting('caverns_and_chasms:silver_ingot', 'caverns_and_chasms:deepslate_silver_ore').xp(1).cookingTime(400)
  event.smelting('caverns_and_chasms:silver_nugget', 'spelunkery:raw_silver_nugget').xp(0.1).cookingTime(100)
  
  










  //Shaped Recipes
  //-------------------------------------------------------------------------------------------

  event.shaped(
    Item.of('minecraft:spyglass', 1),
    [
      'AG ',
      'GC ',
      '  C'
    ],
    {
      A: 'galosphere:allurite_shard',
      G: 'minecraft:gold_nugget',
      C: 'minecraft:copper_ingot'
    }
  )

  event.shaped(
    Item.of('netherexp:enigma_flesh', 8),
    [
      'AAA',
      'ABA',
      'AAA'
    ],
    {
      A: 'caverns_and_chasms:living_flesh',
      B: 'netherexp:warped_wart'
    }
  )
  event.remove({ output: 'vanillabackport:dried_ghast' })
  event.shaped(
    Item.of('vanillabackport:dried_ghast', 1),
    [
      'AAA',
      'ABA',
      'AAA'
    ],
    {
      A: 'minecraft:ghast_tear',
      B: 'mynethersdelight:ghast_sourdough'
    }
  )
  event.remove({ output: 'healpgood:withered_heart' })
  event.shaped(
    Item.of('healpgood:withered_heart', 1),
    [
      'ACA',
      'CBC',
      'ACA'
    ],
    {
      A: 'oreganized:electrum_ingot',
      B: '#forge:glass_panes',
      C: 'oreganized:electrum_nugget'
    }
  )

  event.remove({ output: 'create:empty_blaze_burner' })
  event.shaped('create:empty_blaze_burner', [
    '   ',
    ' C ',
    'ABA'
  ], {
    A: 'caverns_and_chasms:silver_bars',
    B: 'supplementaries:cage',
    C: 'minecraft:netherrack',
  })
  event.remove({ output: 'alexscaves:uranium_rod' })
event.shaped('alexscaves:uranium_rod', [
  'BAB',
  'CAC',
  'BAB'
], {
  A: 'enlightened_end:irradium_bar',
  B: 'oreganized:lead_nugget',
  C: '#forge:glass_panes',
})
  event.shaped('sortilege:heart_rhodonite_staff', [
    ' CB',
    ' CC',
    'A  '
  ], {
    A: 'healpgood:heart_crystal_shard',
    B: 'healpgood:crystal_heart',
    C: 'minecraft:stick',
  })
  event.shaped('sortilege:divine_beryl_staff', [
    ' BA',
    ' BB',
    'A  '
  ], {
    A: 'minecraft:emerald',
    B: 'minecraft:stick'
  })
  event.shaped('sortilege:spider_kunzite_staff', [
    ' BA',
    ' BB',
    'A  '
  ], {
    A: 'caverns_and_chasms:spinel',
    B: 'minecraft:stick'
  })


  //Shapeless Recipes
  //-------------------------------------------------------------------------------------------

  event.shapeless(
    Item.of('netherexp:strange_enigma_flesh', 1),
    [
      'netherexp:enigma_flesh',
      'netherexp:ectoplasm_bucket'
    ]
  )
  event.shapeless(
    Item.of('minecraft:book', 1),
    [
      'scriptor:leather_binder',
      'minecraft:paper',
      'minecraft:paper'
    ]
  )
  event.shapeless(
    Item.of('scriptor:identify_scroll', 1),
    [
      'eidolon:parchment',
      'eidolon:arcane_seal'
    ]
  )
  event.remove({ output: 'scriptor:writable_spellbook' })
  Item.of('scriptor:writable_spellbook', 1),
    [
      'eidolon:notetaking_tools',
      'scriptor:spellbook_binder'
    ]
  Item.of('enlightened_end:stardust', 4),
    [
      'enlightened_end:stardust_block'
    ]

    Item.of('alexscaves:uranium', 9),
  [
    'enlightened_end:raw_irradium_block'
  ]




























  //FD Knife Recipes
  //-------------------------------------------------------------------------------------------

  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'caverns_and_chasms:peeper_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'caverns_and_chasms:living_flesh', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'caverns_and_chasms:mime_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'caverns_and_chasms:spinel', count: 4 },
      { item: 'alexsmobs:mimicream', count: 1, chance: 0.5 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'neapolitan:chimpanzee_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'undergarden:blood_globule', count: 2 },
      { item: 'neapolitan:dried_banana', count: 1, chance: 0.5 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:dragon_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'quark:dragon_scale', count: 1, chance: 0.1 },
      { item: 'minecraft:dragon_breath', count: 1 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'supplementaries:enderman_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'healpgood:ender_soul', count: 1, chance: 0.5 },
      { item: 'minecraft:ender_eye', count: 1 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:frostbitten_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'rottencreatures:frozen_rotten_flesh', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:glacial_hunter_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'rottencreatures:frozen_rotten_flesh', count: 6 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:mummy_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'sleep_tight:bedbug_eggs', count: 3, chance: 0.5 },
      { item: 'dungeonsdelight:gritty_flesh', count: 6 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:burned_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'rottencreatures:magma_rotten_flesh', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:dead_beard_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'dungeonsdelight:brined_flesh', count: 8 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:immortal_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'dungeonsdelight:brined_flesh', count: 6 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:zap_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'dungeonsdelight:brined_flesh', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:swampy_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'endrem:undead_soul', count: 1, chance: 0.1 },
      { item: 'dungeonsdelight:brined_flesh', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'vanillabackport:dried_ghast' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'mynethersdelight:ghasta', count: 4 },
      { item: 'dungeonsdelight:ghast_tentacle', count: 2 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:creeper_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'minecraft:gunpowder', count: 4 },
      { item: 'savage_and_ravage:creeper_spores', count: 2 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:creeper_head' }
    ],
    tool: { tag: 'minecraft:pickaxes' },
    result: [
      { item: 'minecraft:gunpowder', count: 8 },
      { item: 'quark:sturdy_stone', count: 2 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:zombie_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'minecraft:rotten_flesh', count: 4 },
      { item: 'minecraft:skeleton_skull', count: 1 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'rottencreatures:undead_miner_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'minecraft:rotten_flesh', count: 4 },
      { item: 'minecraft:skeleton_skull', count: 1 },
      { item: 'sullysmod:miners_helmet', count: 1, chance: 0.1 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:piglin_head' }
    ],
    tool: { tag: 'hearthandharvest:cleavers' },
    result: [
      { item: 'farmersdelight:bacon', count: 4 },
      { item: 'undergarden:blood_globule', count: 2 },
      { item: 'aquaculture:gold_hook', count: 1, chance: 0.1 }
    ]
  })
  event.custom({
  type: 'farmersdelight:cutting',
  ingredients: [
    { item: 'undergarden:regalium_crystal' }
  ],
  tool: { item: 'galospheric_delight:silver_hammer' },
  result: [
    { item: 'eidolon:lesser_soul_gem', count: 2 }
  ]
})
event.custom({
  type: 'farmersdelight:cutting',
  ingredients: [
    { item: 'eidolon:shadow_gem' }
  ],
  tool: { item: 'galospheric_delight:silver_hammer' },
  result: [
    { item: 'eidolon:lesser_soul_gem', count: 4 }
  ]
})
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'eidolon:lesser_soul_gem' }
    ],
    tool: { item: 'galospheric_delight:silver_hammer' },
    result: [
      { item: 'eidolon:soul_shard', count: 4 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:glowstone' }
    ],
    tool: { item: 'galospheric_delight:silver_hammer' },
    result: [
      { item: 'minecraft:glowstone_dust', count: 4 }
    ]
  })



  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'alexsmobs:bear_fur' }
    ],
    tool: { item: 'dungeonsdelight:stained_knife' },
    result: [
      { item: 'alexsmobs:bear_dust', count: 0.01 }
    ]
  })

  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'alexsmobs:blood_sac' }
    ],
    tool: { tag: 'forge:tools/knives' },
    result: [
      { item: 'undergarden:blood_globule', count: 1 }
    ]
  })


  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:nether_wart_block' }
    ],
    tool: { tag: 'forge:tools/knives' },
    result: [
      { item: 'minecraft:nether_wart', count: 1 }
    ]
  })
  event.custom({
    type: 'farmersdelight:cutting',
    ingredients: [
      { item: 'minecraft:warped_wart_block' }
    ],
    tool: { tag: 'forge:tools/knives' },
    result: [
      { item: 'netherexp:warped_wart', count: 1 }
    ]
  })



  //Input Replacers
  //-------------------------------------------------------------------------------------------




  event.replaceInput(
    { input: 'bountifulfares:orange' }, 
    'bountifulfares:orange',            
    'atmospheric:orange'         
  )
  event.replaceInput(
    { input: 'alexscaves:amber' }, 
    'alexscaves:amber',            
    'sullysmod:amber'         
  )

  event.replaceInput(
    { input: 'rubinated_nether:ruby' }, 
    'rubinated_nether:ruby',            
    'miningmaster:kinetic_opal'         
  )

  event.replaceInput(
    { input: 'hearthandharvest:cotton' }, 
    'hearthandharvest:cotton',            
    'etcetera:cotton_flower'         
  )

  event.replaceInput(
    { input: 'environmental:plum' }, 
    'environmental:plum',            
    'bountifulfares:plum'         
  )
  event.replaceInput(
    { input: 'bountifulfares:passion_fruit' }, 
    'bountifulfares:passion_fruit',            
    'atmospheric:passion_fruit'         
  )
  event.replaceInput(
    { input: 'alexscaves:sulfur_dust' }, 
    'alexscaves:sulfur_dust',            
    'spelunkery:sulfur'         
  )
  event.replaceInput(
    { input: 'eidolon:sulfur' }, 
    'eidolon:sulfur',            
    'spelunkery:sulfur'         
  )
  event.replaceInput(
    { input: 'hearthandharvest:cherry' }, 
    'hearthandharvest:cherry',            
    'environmental:cherries'         
  )
  event.replaceInput(
    { input: 'eidolon:lead_ingot' }, 
    'eidolon:lead_ingot',            
    'oreganized:lead_ingot'         
  )
  event.replaceInput(
    { input: 'eidolon:warped_sprouts' }, 
    'eidolon:warped_sprouts',            
    'netherexp:warped_wart'         
  )
  event.replaceInput(
    { input: 'eidolon:fungus_sprouts' }, 
    'eidolon:fungus_sprouts',            
    'gardens_of_the_dead:soulblight_fungus'         
  )


  event.replaceInput(
    { input: 'galosphere:silver_ingot' }, 
    'galosphere:silver_ingot',            
    'caverns_and_chasms:silver_ingot'         
  )
  event.replaceInput(
    { input: 'oreganized:silver_ingot' }, 
    'oreganized:silver_ingot',            
    'caverns_and_chasms:silver_ingot'         
  )

  event.replaceInput(
    { input: 'create:dough' }, 
    'create:dough',            
    'farmersdelight:wheat_dough'         
  )
  event.replaceInput(
{ input: 'create:bar_of_chocolate' }, 
'create:bar_of_chocolate',            
'neapolitan:chocolate_bar'         
)
  event.replaceInput(
{ input: 'hearthandharvest:chocolate_bar' }, 
'hearthandharvest:chocolate_bar',            
'neapolitan:chocolate_bar'         
)
  event.replaceInput(
{ input: 'netherdungeons:cooked_hoglin_leg' }, 
'netherdungeons:cooked_hoglin_leg',            
'mynethersdelight:cooked_loin'         
)
  event.replaceInput(
    { input: 'bountifulfares:flour' }, 
    'bountifulfares:flour',            
    'create:wheat_flour'         
  )

  event.replaceInput(
    { input: 'spawn:snail_shell' }, 
    'spawn:snail_shell',            
    'autumnity:snail_shell_piece'         
  )

  event.replaceInput(
    { input: 'autumnity:snail_goo' }, 
    'autumnity:snail_goo',            
    'spawn:mucus'         
  )

  event.replaceInput(
    { input: 'immersive_weathering:azalea_flowers' }, 
    'immersive_weathering:azalea_flowers',            
    'twigs:azalea_flowers'         
  )
  event.replaceInput(
    { input: 'galospheric_delight:azalea_petals' }, 
    'galospheric_delight:azalea_petals',            
    'twigs:azalea_flowers'         
  )



  //Eidolon Recipes
  //-------------------------------------------------------------------------------------------


  /*
  {
    "type": "eidolon:crucible",
    "steps": [
      {
        "items": [
          { "tag": "forge:dusts/sulfur" },
          { "item": "minecraft:bone_meal" }
        ]
      },
      {
        "stirs": 1,
        "items": [
          { "item": "minecraft:charcoal" }
        ]
      }
    ],
    "result": {
      "item": "minecraft:gunpowder",
      "count": 4
    }
  }
  */







  let brazier_summoning = (Focus, Input1, Input2, Input3, Mob) => {
    event.custom({
      "type": "eidolon:ritual_brazier_summoning",
      "focusItems": [],
      "output": {
        "entity": Mob
      },
      "pedestalItems": [
        {
          "item": Focus
        },
        {
          "item": Input1
        },
        {
          "item": Input2
        },
        {
          "item": Input3
        }
      ],
      "reagent": [
        {
          "item": "enlightened_end:stardust"
        }
      ]
    })
  }
  // Mob Brazier Summons
  //-------------------------------------------------------------------------------------------

  brazier_summoning(
    "eidolon:soul_shard",
    "composite_material:warden_hand",
    "dungeonsdelight:wardenzola",
    "eidolon:soul_shard",

    "minecraft:warden"
  )

  brazier_summoning(
    "eidolon:soul_shard",
    "minecraft:bone",
    "minecraft:bone",
    "eidolon:soul_shard",

    "minecraft:skeleton"
  )

  brazier_summoning(
    "eidolon:lesser_soul_gem",
    "mynethersdelight:ghast_sourdough",
    "minecraft:ghast_tear",
    "eidolon:lesser_soul_gem",

    "minecraft:ghast"
  )

  brazier_summoning(
    "eidolon:lesser_soul_gem",
    "caverns_and_chasms:rotten_flesh_block",
    "caverns_and_chasms:rotten_flesh_block",
    "eidolon:lesser_soul_gem",

    "eidolon:zombie_brute"
  )

  brazier_summoning(
    "alexscaves:dark_tatters",
    "alexscaves:occult_gem",
    "alexscaves:pure_darkness",
    "eidolon:lesser_soul_gem",

    "alexscaves:watcher"
  )

  brazier_summoning(
    "eidolon:lesser_soul_gem",
    "minecraft:blaze_rod",
    "minecraft:blaze_rod",
    "eidolon:lesser_soul_gem",

    "minecraft:blaze"
  )

  brazier_summoning(
    "eidolon:lesser_soul_gem",
    "minecraft:end_stone",
    "healpgood:ender_soul",
    "eidolon:lesser_soul_gem",

    "minecraft:enderman"
  )


  brazier_summoning(
    "eidolon:lesser_soul_gem",
    "minecraft:shulker_shell",
    "minecraft:purpur_block",
    "paradise_lost:levita_gem",

    "minecraft:shulker"
  )

  //Brazier Recipes
  //-------------------------------------------------------------------------------------------


  event.remove({ output: 'scriptor:casting_crystal' })
  event.custom({
    "type": "eidolon:crucible",
    "steps": [
      {
        "items": [
          { "item": "healpgood:heart_crystal_shard" }
        ]
      },
      {
        "stirs": 1,
        "items": [
          { "item": "enlightened_end:stardust" }
        ]
      }
    ],
    "result": {
      "item": "scriptor:casting_crystal",
      "count": 1
    }
  })

  event.remove({ output: 'scriptor:chalk' })
  event.custom({
    "type": "eidolon:crucible",
    "steps": [
      {
        "items": [
          { "tag": "chalk:chalks" }
        ]
      },
      {
        "stirs": 1,
        "items": [
          { "item": "enlightened_end:stardust" }
        ]
      }
    ],
    "result": {
      "item": "scriptor:chalk",
      "count": 1
    }
  })
  event.remove({ output: 'scriptor:spellbook_binder' })
  event.custom({
    "type": "eidolon:crucible",
    "steps": [
      {
        "items": [
          { "item": "scriptor:leather_binder" }
        ]
      },
      {
        "stirs": 1,
        "items": [
          { "item": "eidolon:soul_shard" }
        ]
      }
    ],
    "result": {
      "item": "scriptor:spellbook_binder",
      "count": 1
    }
  })

})