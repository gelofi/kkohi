# Event Handling!

fs = require('fs'); # fs is the package we need to read all files which are in folders

module.exports = (bot) ->
  
  console.log "-- Events Loaded --"
  fs.readdir './events/', (err, files) -> # We use the method readdir to read what is in the events folder
    # If there is an error during the process to read all contents of the ./events folder, throw an error in the console
    if err then return console.error(err); 
    files.forEach (file) ->
      eventFunction = require "./../events/#{file}" # Here we require the event file of the events folder
      if eventFunction.disabled then return; # Check if the eventFunction is disabled. If yes return without any error
    
      bot.on eventFunction.event, (...args) ->
        eventFunction.run(...args, bot)