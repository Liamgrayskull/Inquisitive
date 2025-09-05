const $Rarity = Java.loadClass("net.minecraft.world.item.Rarity")
const $UnaryOperator = Java.loadClass("java.util.function.UnaryOperator")
const $UtilsJS = Java.loadClass("dev.latvian.mods.kubejs.util.UtilsJS")
const $Style = Java.loadClass("net.minecraft.network.chat.Style")
const withColorMethod = $Style.EMPTY.class.declaredMethods.filter((method) => method.name.includes("m_131148_"))[0]

function createRarity(/** @type {string} */ name, /** @type {number} */ colorCode) {
    let color = $UtilsJS.makeFunctionProxy("startup", $UnaryOperator, (style) => {
        return withColorMethod.invoke(style, Color.of(colorCode).createTextColorJS())
    })
    return $Rarity["create(java.lang.String,java.util.function.UnaryOperator)"](name, color)
}

// create your rarities here

createRarity("ENDER", 0x8855a0)
createRarity("NETHER", 0x5a2d2d)
createRarity("PARADISE", 0x966463)
createRarity("UNDERGARDEN", 0x776753)

createRarity("FOODSTUFFS", 0xb5b5e2)


createRarity("STONE", 0x868685)

createRarity("SOIL", 0x705139)
createRarity("GREENERY", 0x507f11)

createRarity("COGGED", 0x604628)



createRarity("ANCIENT", 0xba7d27)
createRarity("FOSSIL", 0xb09766)
createRarity("POTTERY", 0x794438)





createRarity("LIGHT_GRAY", 0x7d7d72)
createRarity("WHITE", 0xaeacaa)
createRarity("ORANGE", 0xbd6012)
createRarity("CYAN", 0x0d7675)
createRarity("LIME", 0x598f11)
createRarity("BLACK", 0x393553)
createRarity("GREEN", 0x445b10)
createRarity("MAGENTA", 0x852a7f)
createRarity("BROWN", 0x654025)
createRarity("BLUE", 0x2c4d87)
createRarity("RED", 0xaa342d)
createRarity("LIGHT_BLUE", 0x2c9bc5)
createRarity("PINK", 0xdb7a99)
createRarity("GRAY", 0x5e686d)
createRarity("PURPLE", 0x7c2ba8)
createRarity("YELLOW", 0xe3c233)

createRarity("OAK", 0x927447)
createRarity("SPRUCE", 0x634929)
createRarity("BIRCH", 0xa29667)
createRarity("JUNGLE", 0x8a654a)
createRarity("ACACIA", 0x8c4b29)
createRarity("CHERRY", 0xb07e76)
createRarity("DARK_OAK", 0x3e2920)
createRarity("MANGROVE", 0x5e2a27)
createRarity("BAMBOO", 0xa4a44f)
createRarity("AUREL", 0x774f3b)
createRarity("MOTHER_AUREL", 0xd7bd50)
createRarity("HOARY", 0x413935)
createRarity("WALNUT", 0x57422b)
createRarity("FAIRY_RING", 0xcdc175)
createRarity("AERONOS", 0x566971)
createRarity("STROPHAR", 0xaba38c)
createRarity("GLACIAN", 0xa17786)
createRarity("REDWOOD", 0x481e1c)
createRarity("SUGI", 0x693f2b)
createRarity("FIR", 0x58433d)
createRarity("WILLOW", 0x3d2f19)
createRarity("ASPEN", 0xd0ae40)
createRarity("CYPRESS", 0x82745a)
createRarity("OLIVE", 0x574d2d)
createRarity("JOSHUA", 0x46413e)
createRarity("GHAF", 0x825933)
createRarity("PALO_VERDE", 0x797528)
createRarity("COCONUT", 0xad7754)
createRarity("CEDAR", 0x93594b)
createRarity("LARCH", 0x454e52)
createRarity("MAHOGANY", 0x693629)
createRarity("SAXAUL", 0x5e5243)
createRarity("SMOGSTEM", 0x4f5c59)
createRarity("WIGGLEWOOD", 0x564129)
createRarity("GRONGLE", 0x42492a)
createRarity("CERULEAN", 0x569ba3)
createRarity("POWDERY", 0x2e2c33)
createRarity("ROTTEN_WOOD", 0x4c3b36)
createRarity("CLARET", 0x85150f)
createRarity("SMOKESTALK", 0x220c0b)
createRarity("ILLWOOD", 0x3f342b)
createRarity("WHISTLECANE", 0x920e39)
createRarity("PETRIFIED", 0x855225)
createRarity("POISE", 0x804381)
createRarity("MAPLE", 0x805631)
createRarity("PINE", 0xb39068)
createRarity("PLUM", 0x602821)
createRarity("WISTERIA", 0xbdbaa4)
createRarity("DRIFTWOOD", 0x71655d)
createRarity("RIVER", 0x7a593d)
createRarity("PEWEN", 0xaa7b36)
createRarity("THORNWOOD", 0x373028)
createRarity("ROSEWOOD", 0x81606a)
createRarity("MORADO", 0x814646)
createRarity("YUCCA", 0xa66c5b)
createRarity("LAUREL", 0xa18446)
createRarity("GRIMWOOD", 0x30221c)
createRarity("KOUSA", 0x728a71)
createRarity("ASHEN", 0xd8dcce)

createRarity("MUSHROOM", 0x8c765a)

createRarity("IRIDESCENT", 0x9aa798)


createRarity("ELECTRUM", 0xc7a900)
createRarity("GOLD", 0xaa962c)
createRarity("SILVER", 0x6d737d)
createRarity("LEAD", 0x33374f)
createRarity("BISMUTH", 0x9aa798)
createRarity("NETHERITE", 0x4c3c3c)
createRarity("REDSTONE", 0xc52020)
createRarity("NECROMIUM", 0x506a5d)
createRarity("SANGUINE", 0x6c3f40)

createRarity("LAPIS", 0x213c7e)
createRarity("DIAMOND", 0x6cb8aa)
createRarity("EMERALD", 0x92b6a1)
createRarity("CARNELIAN", 0xa65800)
createRarity("JADE", 0x99bb76)
createRarity("AMETHYST", 0xa88698)
createRarity("SPINEL", 0x744979)
createRarity("RUBY", 0xac4783)
createRarity("ALLURITE", 0x5ca9a9)
createRarity("LUMIERE", 0xcebe7f)

createRarity("WARPED", 0xd473e1)
createRarity("CRIMSON", 0xf46800)
createRarity("BLIGHT", 0x6aa7aa)



createRarity("GUNK", 0xc674c0)
createRarity("SPAWNER", 0x5a0a46)

createRarity("PRISMARINE", 0xb3bfaf)

createRarity("ARACHNID", 0x97353c)
createRarity("MISCHIEVIOUS", 0x5d8c48)

createRarity("FIREY", 0xf69918)
createRarity("FRIGID", 0xa1bae6)
createRarity("RAD", 0x81f43a)
createRarity("OCCULT", 0xd60000)
createRarity("SCULK", 0x1faab4)
createRarity("SOUL", 0x00ffef)

createRarity("STEEL", 0x565457)

createRarity("IRON", 0x979591)

createRarity("TWISTED", 0xba49eb)

createRarity("LICHEN", 0x6ad29e)
createRarity("GLOWSTONE", 0xcdc6b0)

createRarity("BRASS", 0xb8af61)
createRarity("ANDESITE", 0x646866)

createRarity("SAND", 0xa89272)

createRarity("AMBER", 0xcb5714)

createRarity("CHILL", 0x66a039)

createRarity("CLOUD", 0xbbcbcf)

createRarity("PALE", 0x747972)

createRarity("GHAST", 0x819c9c)

createRarity("WITHER", 0x352a25)

createRarity("SALT", 0xad837a)

createRarity("COPPER", 0xc2735f)
createRarity("EXPOSED_COPPER", 0xa97b61)
createRarity("WEATHERED_COPPER", 0x807d60)
createRarity("OXIDIZED_COPPER", 0x5a9178)
createRarity("CUPRIC", 0x52b446)

createRarity("WICKED", 0xc82478)

createRarity("RUNIC", 0x3b094e)

createRarity("SKELETAL", 0xcbbe9f)
createRarity("MUSICAL", 0x3faeab)


createRarity("NULL", 0xFF00DA)

createRarity("AZALEA", 0x753e82)

createRarity("STARLIGHT", 0xe9a5f1)
ItemEvents.modification((event) => {
    // modify your items rarity here


    event.modify(/dragon/, (item) => { item.rarity = "ENDER" })
    event.modify(/purpur/, (item) => { item.rarity = "ENDER" })
    event.modify(/nether/, (item) => { item.rarity = "NETHER" })
    event.modify(/undergarden/, (item) => { item.rarity = "UNDERGARDEN" })
    event.modify(/paradise/, (item) => { item.rarity = "PARADISE" })


    event.modify(/stone/, (item) => { item.rarity = "STONE" })
    event.modify(/slate/, (item) => { item.rarity = "STONE" })
    event.modify(/calcite/, (item) => { item.rarity = "STONE" })
    event.modify(/diorite/, (item) => { item.rarity = "STONE" })
    event.modify(/andesite/, (item) => { item.rarity = "STONE" })
    event.modify(/granite/, (item) => { item.rarity = "STONE" })
    event.modify(/tuff/, (item) => { item.rarity = "STONE" })
    event.modify(/travertine/, (item) => { item.rarity = "STONE" })
    event.modify(/terracotta/, (item) => { item.rarity = "STONE" })
    event.modify(/shale/, (item) => { item.rarity = "STONE" })
    event.modify(/onyx/, (item) => { item.rarity = "STONE" })
    event.modify(/basalt/, (item) => { item.rarity = "STONE" })
    event.modify(/tremblecrust/, (item) => { item.rarity = "STONE" })
    event.modify(/dolerite/, (item) => { item.rarity = "STONE" })
    event.modify(/schist/, (item) => { item.rarity = "STONE" })
    event.modify(/rhyolite/, (item) => { item.rarity = "STONE" })


    event.modify(/soil/, (item) => { item.rarity = "SOIL" })
    event.modify(/dirt/, (item) => { item.rarity = "SOIL" })
    event.modify(/earth/, (item) => { item.rarity = "SOIL" })
    event.modify(/mud/, (item) => { item.rarity = "SOIL" })
    event.modify(/clay/, (item) => { item.rarity = "SOIL" })
    event.modify(/gravel/, (item) => { item.rarity = "SOIL" })
    event.modify(/coprolith/, (item) => { item.rarity = "SOIL" })
    event.modify(/guano/, (item) => { item.rarity = "SOIL" })
    event.modify(/podzol/, (item) => { item.rarity = "SOIL" })
    event.modify(/crustose/, (item) => { item.rarity = "SOIL" })
    event.modify(/geomancer/, (item) => { item.rarity = "SOIL" })


    event.modify(/mushroom/, (item) => { item.rarity = "MUSHROOM" })
    event.modify(/moss/, (item) => { item.rarity = "GREENERY" })
    event.modify(/plant/, (item) => { item.rarity = "GREENERY" })
    event.modify(/clover/, (item) => { item.rarity = "GREENERY" })
    event.modify(/flower/, (item) => { item.rarity = "GREENERY" })
    event.modify(/leaves/, (item) => { item.rarity = "GREENERY" })
    event.modify(/weed/, (item) => { item.rarity = "GREENERY" })
    event.modify(/grass/, (item) => { item.rarity = "GREENERY" })
    event.modify(/kelp/, (item) => { item.rarity = "GREENERY" })
    event.modify(/seed/, (item) => { item.rarity = "GREENERY" })
    event.modify(/pips/, (item) => { item.rarity = "GREENERY" })

    event.modify(/create:/, (item) => { item.rarity = "COGGED" })


    event.modify("#diet:proteins", (item) => { item.rarity = "FOODSTUFFS" })
    event.modify("#diet:grains", (item) => { item.rarity = "FOODSTUFFS" })
    event.modify("#diet:sugars", (item) => { item.rarity = "FOODSTUFFS" })
    event.modify("#diet:vegetables", (item) => { item.rarity = "FOODSTUFFS" })
    event.modify("#diet:fruits", (item) => { item.rarity = "FOODSTUFFS" })
    event.modify("#diet:special_foods", (item) => { item.rarity = "FOODSTUFFS" })




    event.modify(/_gray/, (item) => { item.rarity = "GRAY" })
    event.modify(/gray_/, (item) => { item.rarity = "GRAY" })

    event.modify(/light_gray/, (item) => { item.rarity = "LIGHT_GRAY" })

    event.modify(/_white/, (item) => { item.rarity = "WHITE" })
    event.modify(/white_/, (item) => { item.rarity = "WHITE" })

    event.modify(/_orange/, (item) => { item.rarity = "ORANGE" })
    event.modify(/orange_/, (item) => { item.rarity = "ORANGE" })

    event.modify(/_lime/, (item) => { item.rarity = "LIME" })
    event.modify(/lime_/, (item) => { item.rarity = "LIME" })

    event.modify(/_green/, (item) => { item.rarity = "GREEN" })
    event.modify(/green_/, (item) => { item.rarity = "GREEN" })

    event.modify(/_black/, (item) => { item.rarity = "BLACK" })
    event.modify(/black_/, (item) => { item.rarity = "BLACK" })

    event.modify(/_cyan/, (item) => { item.rarity = "CYAN" })
    event.modify(/cyan_/, (item) => { item.rarity = "CYAN" })

    event.modify(/_magenta/, (item) => { item.rarity = "MAGENTA" })
    event.modify(/magenta_/, (item) => { item.rarity = "MAGENTA" })

    event.modify(/_brown/, (item) => { item.rarity = "BROWN" })
    event.modify(/brown_/, (item) => { item.rarity = "BROWN" })

    event.modify(/_blue/, (item) => { item.rarity = "BLUE" })
    event.modify(/blue_/, (item) => { item.rarity = "BLUE" })

    event.modify(/_red/, (item) => { item.rarity = "RED" })
    event.modify(/red_/, (item) => { item.rarity = "RED" })

    event.modify(/light_blue/, (item) => { item.rarity = "LIGHT_BLUE" })

    event.modify(/_pink/, (item) => { item.rarity = "PINK" })
    event.modify(/pink_/, (item) => { item.rarity = "PINK" })

    event.modify(/_purple/, (item) => { item.rarity = "PURPLE" })
    event.modify(/purple_/, (item) => { item.rarity = "PURPLE" })

    event.modify(/_yellow/, (item) => { item.rarity = "YELLOW" })
    event.modify(/yellow_/, (item) => { item.rarity = "YELLOW" })


    event.modify(/oak_/, (item) => { item.rarity = "OAK" })
    event.modify(/spruce/, (item) => { item.rarity = "SPRUCE" })
    event.modify(/birch/, (item) => { item.rarity = "BIRCH" })
    event.modify(/acacia/, (item) => { item.rarity = "ACACIA" })
    event.modify(/jungle_/, (item) => { item.rarity = "JUNGLE" })
    event.modify(/cherry/, (item) => { item.rarity = "CHERRY" })
    event.modify(/dark_oak/, (item) => { item.rarity = "DARK_OAK" })
    event.modify(/mangrove/, (item) => { item.rarity = "MANGROVE" })
    event.modify(/bamboo/, (item) => { item.rarity = "BAMBOO" })

    event.modify(/aurel/, (item) => { item.rarity = "AUREL" })
    event.modify(/mother_aurel/, (item) => { item.rarity = "MOTHER_AUREL" })

    event.modify(/hoary_/, (item) => { item.rarity = "HOARY" })
    event.modify(/walnut/, (item) => { item.rarity = "WALNUT" })

    event.modify(/fairy_ring/, (item) => { item.rarity = "FAIRY_RING" })

    event.modify(/aeronos/, (item) => { item.rarity = "AERONOS" })
    event.modify(/strophar/, (item) => { item.rarity = "STROPHAR" })
    event.modify(/glacian/, (item) => { item.rarity = "GLACIAN" })

    event.modify(/redwood/, (item) => { item.rarity = "REDWOOD" })
    event.modify(/sugi_/, (item) => { item.rarity = "SUGI" })
    event.modify(/fir_/, (item) => { item.rarity = "FIR" })
    event.modify(/willow/, (item) => { item.rarity = "WILLOW" })
    event.modify(/cypress/, (item) => { item.rarity = "CYPRESS" })
    event.modify(/olive/, (item) => { item.rarity = "OLIVE" })
    event.modify(/joshua/, (item) => { item.rarity = "JOSHUA" })
    event.modify(/ghaf_/, (item) => { item.rarity = "GHAF" })
    event.modify(/palo_verde/, (item) => { item.rarity = "PALO_VERDE" })
    event.modify(/coconut/, (item) => { item.rarity = "COCONUT" })
    event.modify(/cedar/, (item) => { item.rarity = "CEDAR" })
    event.modify(/larch_/, (item) => { item.rarity = "LARCH" })
    event.modify(/mahogany/, (item) => { item.rarity = "MAHOGANY" })
    event.modify(/saxaul/, (item) => { item.rarity = "SAXAUL" })

    event.modify(/smogstem/, (item) => { item.rarity = "SMOGSTEM" })
    event.modify(/wigglewood/, (item) => { item.rarity = "WIGGLEWOOD" })
    event.modify(/grongle/, (item) => { item.rarity = "GRONGLE" })

    event.modify(/cerulean/, (item) => { item.rarity = "CERULEAN" })

    event.modify(/powdery/, (item) => { item.rarity = "POWDERY" })

    event.modify(/spawn:cracked_rotten/, (item) => { item.rarity = "ROTTEN_WOOD" })
    event.modify(/spawn:rotten/, (item) => { item.rarity = "ROTTEN_WOOD" })
    event.modify(/spawn:stripped_rotten/, (item) => { item.rarity = "ROTTEN_WOOD" })
    event.modify(/spawn\/rotten/, (item) => { item.rarity = "ROTTEN_WOOD" })


    event.modify(/claret/, (item) => { item.rarity = "CLARET" })
    event.modify(/smokestalk/, (item) => { item.rarity = "SMOKESTALK" })

    event.modify(/illwood/, (item) => { item.rarity = "ILLWOOD" })

    event.modify(/whistlecane/, (item) => { item.rarity = "WHISTLECANE" })

    event.modify(/petrified/, (item) => { item.rarity = "PETRIFIED" })

    event.modify(/maple/, (item) => { item.rarity = "MAPLE" })
    event.modify(/pine_/, (item) => { item.rarity = "PINE" })
    event.modify(/plum/, (item) => { item.rarity = "PLUM" })
    event.modify(/wisteria/, (item) => { item.rarity = "WISTERIA" })
    event.modify(/driftwood/, (item) => { item.rarity = "DRIFTWOOD" })
    event.modify(/river_/, (item) => { item.rarity = "RIVER" })
    event.modify(/azalea/, (item) => { item.rarity = "AZALEA" })
    event.modify(/pewen/, (item) => { item.rarity = "PEWEN" })
    event.modify("alexscaves:ancient_leaves", (item) => { item.rarity = "PEWEN" })
    event.modify("alexscaves:ancient_sapling", (item) => { item.rarity = "PEWEN" })
    event.modify(/thornwood/, (item) => { item.rarity = "THORNWOOD" })
    event.modify(/rosewood/, (item) => { item.rarity = "ROSEWOOD" })
    event.modify(/morado/, (item) => { item.rarity = "MORADO" })
    event.modify(/yucca/, (item) => { item.rarity = "YUCCA" })
    event.modify(/aspen/, (item) => { item.rarity = "ASPEN" })
    event.modify(/laurel/, (item) => { item.rarity = "LAUREL" })
    event.modify(/kousa/, (item) => { item.rarity = "KOUSA" })
    event.modify(/grimwood/, (item) => { item.rarity = "GRIMWOOD" })



























    event.modify(/bone/, (item) => { item.rarity = "SKELETAL" })
    event.modify(/skull/, (item) => { item.rarity = "SKELETAL" })

    event.modify(/music/, (item) => { item.rarity = "MUSICAL" })
    event.modify(/jukebox/, (item) => { item.rarity = "MUSICAL" })
    event.modify(/instrument/, (item) => { item.rarity = "MUSICAL" })
    event.modify(/note_block/, (item) => { item.rarity = "MUSICAL" })
    event.modify(/melodies/, (item) => { item.rarity = "MUSICAL" })





    event.modify(/brass/, (item) => { item.rarity = "BRASS" })

    event.modify(/andesite/, (item) => { item.rarity = "ANDESITE" })

    event.modify(/sand/, (item) => { item.rarity = "SAND" })

    event.modify(/nirvana/, (item) => { item.rarity = "CHILL" })

    event.modify(/pale_/, (item) => { item.rarity = "PALE" })















    event.modify(/cloud/, (item) => { item.rarity = "CLOUD" })


    event.modify(/warped/, (item) => { item.rarity = "WARPED" })

    event.modify(/crimson/, (item) => { item.rarity = "CRIMSON" })

    event.modify(/blight/, (item) => { item.rarity = "BLIGHT" })


    event.modify(/coral/, (item) => { item.rarity = "PRISMARINE" })
    event.modify(/prismarine/, (item) => { item.rarity = "PRISMARINE" })


    event.modify(/spawner/, (item) => { item.rarity = "SPAWNER" })
    event.modify(/dungeonsdelight:stained/, (item) => { item.rarity = "SPAWNER" })
    event.modify(/dungeon/, (item) => { item.rarity = "SPAWNER" })
    event.modify("quark:monster_box", (item) => { item.rarity = "SPAWNER" })

    event.modify(/dungeonsdelight:rot/, (item) => { item.rarity = "GUNK" })
    event.modify(/dungeonsdelight:living/, (item) => { item.rarity = "GUNK" })
    event.modify(/gunk/, (item) => { item.rarity = "GUNK" })


    event.modify(/species:wicked/, (item) => { item.rarity = "WICKED" })
    event.modify("species:monster_meal", (item) => { item.rarity = "WICKED" })

    event.modify(/rune/, (item) => { item.rarity = "RUNIC" })
    event.modify(/runic/, (item) => { item.rarity = "RUNIC" })
    event.modify(/spell/, (item) => { item.rarity = "RUNIC" })
    event.modify(/enchanted/, (item) => { item.rarity = "RUNIC" })
    event.modify("scriptor:identify_scroll", (item) => { item.rarity = "RUNIC" })
    event.modify("scriptor:book_of_books", (item) => { item.rarity = "RUNIC" })
    event.modify("scriptor:chalk", (item) => { item.rarity = "RUNIC" })


    event.modify(/spider/, (item) => { item.rarity = "ARACHNID" })
    event.modify("minecraft:cobweb", (item) => { item.rarity = "ARACHNID" })
    event.modify("atmospheric:grimweb", (item) => { item.rarity = "ARACHNID" })
    event.modify("dungeonsdelight:cob_n_candy", (item) => { item.rarity = "ARACHNID" })


    event.modify(/creeper/, (item) => { item.rarity = "MISCHIEVIOUS" })
    event.modify(/mischief/, (item) => { item.rarity = "MISCHIEVIOUS" })
    event.modify(/blast_proof/, (item) => { item.rarity = "MISCHIEVIOUS" })
    event.modify(/kabloom/, (item) => { item.rarity = "MISCHIEVIOUS" })
    event.modify(/griefer/, (item) => { item.rarity = "MISCHIEVIOUS" })



    event.modify(/twisted/, (item) => { item.rarity = "TWISTED" })
    event.modify(/warpstone/, (item) => { item.rarity = "TWISTED" })
    event.modify(/crying/, (item) => { item.rarity = "TWISTED" })
    event.modify(/portal_fluid/, (item) => { item.rarity = "TWISTED" })


    event.modify(/glowstone/, (item) => { item.rarity = "GLOWSTONE" })

    event.modify(/salt/, (item) => { item.rarity = "SALT" })
    event.modify(/wither/, (item) => { item.rarity = "WITHER" })

    event.modify(/squid/, (item) => { item.rarity = "BLACK" })


    event.modify(/glow_ink/, (item) => { item.rarity = "LICHEN" })
    event.modify(/glow_squid/, (item) => { item.rarity = "LICHEN" })
    event.modify(/lichen/, (item) => { item.rarity = "LICHEN" })


    event.modify(/campfire/, (item) => { item.rarity = "FIREY" })
    event.modify(/flame/, (item) => { item.rarity = "FIREY" })
    event.modify(/torch/, (item) => { item.rarity = "FIREY" })
    event.modify(/magma/, (item) => { item.rarity = "FIREY" })
    event.modify(/blaze/, (item) => { item.rarity = "FIREY" })
    event.modify(/bomb/, (item) => { item.rarity = "FIREY" })
    event.modify(/lava/, (item) => { item.rarity = "FIREY" })
    event.modify(/soot/, (item) => { item.rarity = "FIREY" })
    event.modify(/charred/, (item) => { item.rarity = "FIREY" })
    event.modify(/ash_/, (item) => { item.rarity = "FIREY" })
    event.modify(/_ash/, (item) => { item.rarity = "FIREY" })
    event.modify(/brazier/, (item) => { item.rarity = "FIREY" })
    event.modify(/furnace/, (item) => { item.rarity = "FIREY" })


    event.modify(/steel/, (item) => { item.rarity = "STEEL" })


    event.modify(/_iron/, (item) => { item.rarity = "IRON" })
    event.modify(/iron_/, (item) => { item.rarity = "IRON" })

    event.modify("minecraft:anvil", (item) => { item.rarity = "IRON" })
    event.modify("minecraft:chain", (item) => { item.rarity = "IRON" })




    event.modify(/ice_/, (item) => { item.rarity = "FRIGID" })
    event.modify(/_ice/, (item) => { item.rarity = "FRIGID" })
    event.modify(/ ice/, (item) => { item.rarity = "FRIGID" })
    event.modify('minecraft:ice', (item) => { item.rarity = "FRIGID" })


    event.modify(/snow/, (item) => { item.rarity = "FRIGID" })
    event.modify(/frozen/, (item) => { item.rarity = "FRIGID" })
    event.modify(/freeze/, (item) => { item.rarity = "FRIGID" })
    event.modify(/frost/, (item) => { item.rarity = "FRIGID" })
    event.modify(/icicle/, (item) => { item.rarity = "FRIGID" })
    event.modify(/glacium/, (item) => { item.rarity = "FRIGID" })

    event.modify(/gold/, (item) => { item.rarity = "GOLD" })
    event.modify(/gilded/, (item) => { item.rarity = "GOLD" })
    event.modify(/piglin/, (item) => { item.rarity = "GOLD" })


    event.modify(/lead/, (item) => { item.rarity = "LEAD" })
    event.modify(/glance/, (item) => { item.rarity = "LEAD" })
    event.modify(/brain_damage/, (item) => { item.rarity = "LEAD" })
    event.modify(/shrapnel_/, (item) => { item.rarity = "LEAD" })
    event.modify("supplementaries:bomb_spiky", (item) => { item.rarity = "LEAD" })

    event.modify(/amethyst/, (item) => { item.rarity = "AMETHYST" })

    event.modify(/redstone/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/cinnabar/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/repeater/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/dropper/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/dispenser/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/minecart/, (item) => { item.rarity = "REDSTONE" })
    event.modify(/rail/, (item) => { item.rarity = "REDSTONE" })


    event.modify(/allurite/, (item) => { item.rarity = "ALLURITE" })

    event.modify(/lumiere/, (item) => { item.rarity = "LUMIERE" })

    event.modify(/lapis/, (item) => { item.rarity = "LAPIS" })
    event.modify(/lazurite/, (item) => { item.rarity = "LAPIS" })


    event.modify(/diamond/, (item) => { item.rarity = "DIAMOND" })
    event.modify('quark:diamond_heart', (item) => { item.rarity = "DIAMOND" })



    event.modify(/amber/, (item) => { item.rarity = "AMBER" })
    event.modify(/resin/, (item) => { item.rarity = "AMBER" })



    event.modify(/jade/, (item) => { item.rarity = "JADE" })

    event.modify(/emerald/, (item) => { item.rarity = "EMERALD" })







    event.modify(/ruby/, (item) => { item.rarity = "RUBY" })
    event.modify(/heart_crystal/, (item) => { item.rarity = "RUBY" })
    event.modify(/heartstone/, (item) => { item.rarity = "RUBY" })
    event.modify(/heart_rhodonite/, (item) => { item.rarity = "RUBY" })
    event.modify(/healpgood:polished/, (item) => { item.rarity = "RUBY" })
    event.modify(/healpgood:heart/, (item) => { item.rarity = "RUBY" })
    event.modify(/healpgood:crystal/, (item) => { item.rarity = "RUBY" })
    event.modify(/healpgood:golden/, (item) => { item.rarity = "RUBY" })



    event.modify(/carnelian/, (item) => { item.rarity = "CARNELIAN" })
    event.modify(/kinetic_opal/, (item) => { item.rarity = "CARNELIAN" })
    event.modify(/rubinated_nether/, (item) => { item.rarity = "CARNELIAN" })

    event.modify(/bismuth/, (item) => { item.rarity = "BISMUTH" })
    event.modify(/iridescent/, (item) => { item.rarity = "BISMUTH" })
    event.modify(/power_pyrite/, (item) => { item.rarity = "BISMUTH" })
    event.modify("eidolon:pewter_inlay", (item) => { item.rarity = "BISMUTH" })
    event.modify("eidolon:unholy_symbol", (item) => { item.rarity = "BISMUTH" })
    event.modify("eidolon:crucible", (item) => { item.rarity = "BISMUTH" })
    event.modify("eidolon:brazier", (item) => { item.rarity = "BISMUTH" })

    event.modify(/silver/, (item) => { item.rarity = "SILVER" })
    event.modify(/sterling/, (item) => { item.rarity = "SILVER" })

    event.modify(/netherite/, (item) => { item.rarity = "NETHERITE" })

    event.modify(/necromium/, (item) => { item.rarity = "NECROMIUM" })

    event.modify(/sanguine/, (item) => { item.rarity = "SANGUINE" })
    event.modify(/flesh/, (item) => { item.rarity = "SANGUINE" })
    event.modify(/blood/, (item) => { item.rarity = "SANGUINE" })
    event.modify(/entrail/, (item) => { item.rarity = "SANGUINE" })

    event.modify(/ghast/, (item) => { item.rarity = "GHAST" })


    event.modify(/spinel/, (item) => { item.rarity = "SPINEL" })
    event.modify(/spider_kunzite/, (item) => { item.rarity = "SPINEL" })
    event.modify(/bejeweled/, (item) => { item.rarity = "SPINEL" })


    event.modify(/copper/, (item) => { item.rarity = "COPPER" })
    event.modify(/exposed_copper/, (item) => { item.rarity = "EXPOSED_COPPER" })
    event.modify(/weathered_copper/, (item) => { item.rarity = "WEATHERED_COPPER" })
    event.modify(/oxidized_copper/, (item) => { item.rarity = "OXIDIZED_COPPER" })
    event.modify(/rusted_copper/, (item) => { item.rarity = "OXIDIZED_COPPER" })
    event.modify(/patina/, (item) => { item.rarity = "OXIDIZED_COPPER" })
    event.modify(/cupric/, (item) => { item.rarity = "CUPRIC" })
    event.modify("supplementaries:sconce_green", (item) => { item.rarity = "CUPRIC" })



    event.modify(/soul/, (item) => { item.rarity = "SOUL" })
    event.modify(/soul/, (item) => { item.rarity = "SOUL" })


    event.modify(/ender/, (item) => { item.rarity = "ENDER" })

    event.modify(/sculk/, (item) => { item.rarity = "SCULK" })
    event.modify(/warden/, (item) => { item.rarity = "SCULK" })
    event.modify(/echo/, (item) => { item.rarity = "SCULK" })

    event.modify(/radrock/, (item) => { item.rarity = "RAD" })
    event.modify(/radiation/, (item) => { item.rarity = "RAD" })
    event.modify(/nuclear/, (item) => { item.rarity = "RAD" })
    event.modify(/radon/, (item) => { item.rarity = "RAD" })
    event.modify(/fissile/, (item) => { item.rarity = "RAD" })
    event.modify(/irradium/, (item) => { item.rarity = "RAD" })
    event.modify(/uranium/, (item) => { item.rarity = "RAD" })
    event.modify(/hazmat/, (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:tremorzilla_egg", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:siren_light", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:nuclear_siren", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:waste_drum", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:unrefined_waste", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:charred_remnant", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:toxic_paste", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:raygun", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:remote_detonator", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:radgill", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:cooked_radgill", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:radgill_bucket", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:acid_bucket", (item) => { item.rarity = "RAD" })


    event.modify("alexscaves:totem_of_possession", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:desolate_dagger", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:cloak_of_darkness", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:hood_of_darkness", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:shadow_silk", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:pure_darkness", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:dark_tatters", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:occult_gem", (item) => { item.rarity = "OCCULT" })
    event.modify("eidolon:shadow_gem_block", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:beholder", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:peering_coprolith", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:forsaken_idol", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:dreadbow", (item) => { item.rarity = "OCCULT" })
    event.modify("alexscaves:darkened_apple", (item) => { item.rarity = "OCCULT" })
    event.modify("eidolon:sapping_sword", (item) => { item.rarity = "OCCULT" })
    event.modify("eidolon:enervating_ring", (item) => { item.rarity = "OCCULT" })

    event.modify(/utherium/, (item) => { item.rarity = "OCCULT" })
    event.modify(/netherexp:ancient/, (item) => { item.rarity = "OCCULT" })
    event.modify(/shadow/, (item) => { item.rarity = "OCCULT" })
    event.modify(/treacherous/, (item) => { item.rarity = "OCCULT" })
    event.modify(/occult/, (item) => { item.rarity = "OCCULT" })


    event.modify(/electrum/, (item) => { item.rarity = "ELECTRUM" })
    event.modify("backpack_id:oreg_electrum", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:gold_inlay", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:basic_ring", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:basic_amulet", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:holy_symbol", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:goblet", (item) => { item.rarity = "ELECTRUM" })
    event.modify("eidolon:soul_enchanter", (item) => { item.rarity = "ELECTRUM" })



    event.modify("minecraft:nether_star", (item) => { item.rarity = "STARLIGHT" })
    event.modify("enlightened_end:stardust", (item) => { item.rarity = "STARLIGHT" })
    event.modify("enlightened_end:stardust_block", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:lesser_soul_gem", (item) => { item.rarity = "STARLIGHT" })
    event.modify("undergarden:regalium_crystal", (item) => { item.rarity = "STARLIGHT" })
    event.modify("undergarden:depthrock_regalium_ore", (item) => { item.rarity = "STARLIGHT" })
    event.modify("undergarden:shiverstone_regalium_ore", (item) => { item.rarity = "STARLIGHT" })
    event.modify("undergarden:regalium_block", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:soul_shard", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:arcane_gold_block", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:shadow_gem", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:soulfire_wand", (item) => { item.rarity = "STARLIGHT" })
    event.modify("minecraft:experience_bottle", (item) => { item.rarity = "STARLIGHT" })
    event.modify("create:experience_block", (item) => { item.rarity = "STARLIGHT" })
    event.modify("create:experience_nugget", (item) => { item.rarity = "STARLIGHT" })
    event.modify("eidolon:codex", (item) => { item.rarity = "STARLIGHT" })





    event.modify(/ancient/, (item) => { item.rarity = "ANCIENT" })
    event.modify("#sullysmod:artifacts", (item) => { item.rarity = "ANCIENT" })
    event.modify(/integrated/, (item) => { item.rarity = "ANCIENT" })
    event.modify(/idas/, (item) => { item.rarity = "ANCIENT" })

    event.modify(/fossil/, (item) => { item.rarity = "FOSSIL" })
    event.modify(/ancient_skull/, (item) => { item.rarity = "FOSSIL" })
    event.modify("#wan_ancient_beasts:ancient_skull", (item) => { item.rarity = "FOSSIL" })

    event.modify(/sherd/, (item) => { item.rarity = "POTTERY" })
    event.modify(/pot_/, (item) => { item.rarity = "POTTERY" })
    event.modify(/vase/, (item) => { item.rarity = "POTTERY" })



    event.modify(/iridescent/, (item) => { item.rarity = "IRIDESCENT" })
    event.modify(/ceramic/, (item) => { item.rarity = "IRIDESCENT" })







    event.modify("architects_palette:unobtanium", (item) => { item.rarity = "NULL" })
    event.modify("architects_palette:unobtanium_block", (item) => { item.rarity = "NULL" })
    event.modify("undergarden:music_disc_gloomper_secret", (item) => { item.rarity = "NULL" })
    event.modify("alexsmobs:farseer_arm", (item) => { item.rarity = "NULL" })
    event.modify("alexsmobs:bear_dust", (item) => { item.rarity = "NULL" })








    event.modify(/poise/, (item) => { item.rarity = "POISE" })


    event.modify(/quark:stripped_ancient/, (item) => { item.rarity = "ASHEN" })
    event.modify(/quark:ancient/, (item) => { item.rarity = "ASHEN" })
    event.modify(/quark:ashen/, (item) => { item.rarity = "ASHEN" })

    event.modify("minecraft:conduit", (item) => { item.rarity = "PRISMARINE" })
    event.modify("minecraft:heart_of_the_sea", (item) => { item.rarity = "PRISMARINE" })


    event.modify("kubejs:music_disc_sun", (item) => { item.rarity = "SALT" })
    event.modify("kubejs:music_disc_twelve", (item) => { item.rarity = "SALT" })
    event.modify("kubejs:music_disc_fractal", (item) => { item.rarity = "SALT" })
    event.modify("kubejs:music_disc_fragment", (item) => { item.rarity = "SALT" })

    event.modify("doom_and_gloom:music_disc_afterlife", (item) => { item.rarity = "SOUL" })
    event.modify("kubejs:music_disc_minecraft_live_2022", (item) => { item.rarity = "SOUL" })

    event.modify("kubejs:music_disc_warp", (item) => { item.rarity = "UNDERGARDEN" })

    event.modify("upgrade_aquatic:disc_fragment_atlantis", (item) => { item.rarity = "PRISMARINE" })
    event.modify("upgrade_aquatic:music_disc_atlantis", (item) => { item.rarity = "PRISMARINE" })

    event.modify("enlightened_end:sprog_music_disc", (item) => { item.rarity = "ENDER" })
    event.modify("alexsmobs:music_disc_daze", (item) => { item.rarity = "ENDER" })

    event.modify("alexscaves:disc_fragment_fusion", (item) => { item.rarity = "RAD" })
    event.modify("alexscaves:music_disc_fusion", (item) => { item.rarity = "RAD" })


    event.modify("minecraft:disc_fragment_5", (item) => { item.rarity = "SCULK" })
    event.modify("minecraft:music_disc_5", (item) => { item.rarity = "SCULK" })

    event.modify("mowziesmobs:music_disc_petiole", (item) => { item.rarity = "FRIGID" })
    event.modify("species:music_disc_lapidarian", (item) => { item.rarity = "STONE" })


    event.modify("vanillabackport:music_disc_tears", (item) => { item.rarity = "GHAST" })

    event.modify("sullysmod:music_disc_scour", (item) => { item.rarity = "JADE" })

    event.modify("sullysmod:music_disc_sunken_past", (item) => { item.rarity = "PRISMARINE" })
    event.modify("oreganized:music_disc_structure", (item) => { item.rarity = "BISMUTH" })
    event.modify("caverns_and_chasms:music_disc_epilogue", (item) => { item.rarity = "SPINEL" })

    event.modify("netherexp:music_disc_cricket", (item) => { item.rarity = "WARPED" })
    event.modify("cloudstorage:music_disc_drift", (item) => { item.rarity = "CLOUD" })
    event.modify("spawn:music_disc_rot", (item) => { item.rarity = "ROTTEN_WOOD" })
    event.modify("netherexp:music_disc_buckshot_wonderland", (item) => { item.rarity = "OCCULT" })


    event.modify("minecraft:music_disc_pigstep", (item) => { item.rarity = "GOLD" })

    event.modify("trials:music_disc_creator", (item) => { item.rarity = "OXIDIZED_COPPER" })
    event.modify("trials:music_disc_creator_box", (item) => { item.rarity = "COPPER" })
    event.modify("trials:music_disc_precipice", (item) => { item.rarity = "WEATHERED_COPPER" })


    event.modify("kubejs:music_disc_creakstep", (item) => { item.rarity = "AMBER" })

    event.modify("kubejs:music_disc_character_cartwheel", (item) => { item.rarity = "DIAMOND" })

})