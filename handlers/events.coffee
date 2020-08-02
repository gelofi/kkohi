# Event Handling!

fs = require('fs'); # fs is the package we need to read all files which are in folders

module.exports = (bot) ->
  
  console.log "-- Events Loaded --"
  fs.readdir './events/', (err, files) -> # We use the method readdir to read what is in the events folder
    if err then return console.error(err); # If there is an error during the process to read all contents of the ./events folder, throw an error in the console
    files.forEach (file) ->
      eventFunction = require "./../events/#{file}" # Here we require the event file of the events folder
      if eventFunction.disabled then return; # Check if the eventFunction is disabled. If yes return without any error

      event = eventFunction.event or file.split('.')[0]; # Get the exact name of the event from the eventFunction variable. If it's not given, the code just uses the name of the file as name of the event
      bot.on event, (...args) ->
        eventFunction.run(...args, bot)
        
      