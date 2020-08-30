COVID = require "novelcovid"
track = new COVID.NovelCovid()

module.exports =
  name: "covid"
  aliases: ["corona", "cv", "cr"]
  category: "search"
  description: "Searches COVID-19 statistics in a specified country."
  usage: "`covid [country]`"
  run: (bot, message, args, Discord) ->
    
    if not args[0] then return message.reply "specify a country to fetch its statistics!"
    type = args[0].toLowerCase()
    
    if type is "worldwide" or type is "global" or type is "world"
      corona = await track.all()
      
      corembed = new Discord.MessageEmbed()
      .setTitle "Global Cases"
      .setColor "#f55538"
      .setDescription "Information given is not 100% accurate."
      .addField "Total Cases", corona.cases, true
      .addField "Total Deaths", corona.deaths, true
      .addField "Total Recovered", corona.recovered, true
      .addField "Fresh Cases", corona.todayCases, true
      .addField "Deaths Today", corona.todayDeaths, true
      .addField "Active Cases", corona.active, true
      .setTimestamp();
      
      return message.channel.send corembed
    
    else
      
      corona = await track.countries args[0]
      if not corona.country then return message.channel.send "I can't fetch statistics from that location!"
      coronaembed = new Discord.MessageEmbed()
      .setTitle corona.country
      .setColor "#f55538"
      .setDescription "Information given is not 100% accurate."
      .addField "Total Cases", corona.cases, true
      .addField "Total Deaths", corona.deaths, true
      .addField "Total Recovered", corona.recovered, true
      .addField "Fresh Cases", corona.todayCases, true
      .addField "Deaths Today", corona.todayDeaths, true
      .addField "Active Cases", corona.active, true
      .setTimestamp();
      
      return message.channel.send coronaembed