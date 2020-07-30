module.exports =
  event: "messageUpdate"
  emitter: "on"
  run: (oM, nM) ->
    if oM.content is nM.content then return
    console.log "#{oM}, #{nM}"