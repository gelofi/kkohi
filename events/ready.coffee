module.exports = 
  event: "ready"
  emitter: "on"
  run: (bot) ->
    console.log "#{bot.user.tag} is now online!"
    bot.user.setActivity "CoffeeScript",  type: "PLAYING" 