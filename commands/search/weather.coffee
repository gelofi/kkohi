weather = require 'weather-js';
skies = require('../../util/Filters.json').skies;

module.exports =
  name: 'weather'
  aliases: ["wt"]
  category: "search"
  description: "Gives weather info on a specfied location."
  usage: "`weather [location]`"
  run: (bot, message, args, Discord) ->

    if not args[0] then return message.reply("specify a location!")
    weather.find { search: args.join(" "), degreeType: "C" }, (err, result) ->
      
      if err then return message.channel.send(err)
      if result.length is 0 then return message.reply "**I cannot find that location!**"
      current = result[0].current
      weatherembed = new Discord.MessageEmbed()
        .setTitle "Weather for #{current.observationpoint}"
        .setColor 0x8cd7ff
        .addField "Sky", skies[current.skytext]
        .addField ":thermometer: Temperature", "#{current.temperature}°C"
        .addField ":dash: Winds", current.winddisplay, true
        .addField ":thermometer_face: Feels like", "#{current.feelslike}°C", true
        .addField ":droplet: Humidity", "#{current.humidity}%", true
        message.channel.send weatherembed