let prevDimension = null
PlayerEvents.tick(event => {
  let level = event.level
  let server = event.server
  if (level.dimension != prevDimension) {
    if (level.dimension == "cosmos:solar_system") {
      server.scheduleInTicks(10, callback => {
      Utils.server.runCommandSilent(`execute in cosmos:solar_system run place template ad_astra:space_station -24000 1000 5000 none`)
      })
    } 
  }
  prevDimension = level.dimension
})