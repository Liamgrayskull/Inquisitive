ServerEvents.loaded(event => {
  if (event.server.persistentData.gameRules) return
  event.server.gameRules.set("announceAdvancements", false)
  event.server.gameRules.set("spawnRadius", 1)
  event.server.gameRules.set("snowAccumulationHeight", 1)

  event.server.persistentData.gameRules = true





  // Listen to the item entity creation event
  EntityEvents.spawned(event => {
    if (event.entity.type == 'minecraft:item') {
      let itemEntity = event.entity
      let itemStack = itemEntity.item

      // Check if the spawned item is the one we want
      if (itemStack.id == 'eidolon:shadow_gem') {
        // Disable gravity for this item entity
        itemEntity.setNoGravity(true)
      }
      if (itemStack.id == 'undergarden:regalium_crystal') {
        // Disable gravity for this item entity
        itemEntity.setNoGravity(true)
      }
      if (itemStack.id == 'eidolon:lesser_soul_gem') {
        // Disable gravity for this item entity
        itemEntity.setNoGravity(true)
      }
      if (itemStack.id == 'eidolon:soul_shard') {
        // Disable gravity for this item entity
        itemEntity.setNoGravity(true)
      }
      if (itemStack.id == 'enlightened_end:stardust') {
        // Disable gravity for this item entity
        itemEntity.setNoGravity(true)
      }
    }
  })




})

PlayerEvents.loggedIn(event => {
  //Checks if the player already has the 'new_join' stage and if not it adds it, effectively only running
  //this once on first world join.
  if (!event.player.stages.has('new_join')) {
    event.player.stages.add('new_join')
    //Equips player in full leather
    event.entity.setItemSlot(5, 'ad_astra:space_helmet')
    event.entity.setItemSlot(4, 'ad_astra:space_suit')
    event.entity.setItemSlot(3, 'ad_astra:space_pants')
    event.entity.setItemSlot(2, 'ad_astra:space_boots')
  }
  });