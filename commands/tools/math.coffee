math = require("mathjs");

module.exports =
  name: 'math'
  aliases: ["calculate", "calc"]
  description: "Calculates the given arithmetic problem."
  category: "tools"
  usage: "`math [equation]`"
  run: (bot, message, args, Discord) ->
    
    input = args.join " "
    if not input then return message.reply "provide an input to calculate!"
      
    try 
      resp = math.evaluate input
      output = new Discord.MessageEmbed()
      .setAuthor "Kko-Calculator"
      .setColor "#ed8755"
      .addField "**Equation:**", "```#{input}```"
      .addField "**Answer:**", "```#{resp}```"
      message.channel.send output
    catch err 
      console.error err
      return message.channel.send "Weird equation, even I don't know the answer!"
      