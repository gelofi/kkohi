# Simple event: triggered when someone edits a message!
module.exports =
  event: "messageUpdate"
  emitter: "on"
  run: (oM, nM) ->
    if oM.author.bot then return
    if oM.content is nM.content then return
    console.log "#{oM}, #{nM}"