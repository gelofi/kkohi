req = require "node-superfetch"
Util = require "../../util/Util"

module.exports =
  name: "autocomplete"
  aliases: ["ac", "auto", "atc"]
  description: "Autocompletes a search query for you."
  category: "fun"
  usage: "`autocomplete [query]`"
  run: (bot, message, args, Discord) ->
    
    try
      if not args[0] then return message.reply "please search for something!"
      { text } = await req
      .get 'https://suggestqueries.google.com/complete/search'
      .query
        client: "firefox"
        q: args.join " "
      data = JSON.parse(text)[1];
      if not data.length then return message.reply "I cannot find any results!"
      urls = []
      data.forEach (data) ->
        urls.push "[#{data}](https://www.google.com/search?q=#{data.replace(/\ /g, '+')})"
      final = new Discord.MessageEmbed()
      .setTitle args.join " "
      .setDescription urls.join "\n"
      message.channel.send final
    catch err        
      bot.users.cache.get(manage.error.channel).send embed: Util.Handle.error(err)
      message.channel.send embed: Util.Handle.error(err)