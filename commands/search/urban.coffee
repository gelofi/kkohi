urban = require "urban"
img = "https://jurispage.com/wp-content/uploads/sites/337/2013/05/featured-image4.jpg"

module.exports =
  name: "urban"
  aliases: ["urbandic", "ud", "urbdic", "urbandictionary"]
  description: "Searches for the most clicked definition of a word in Urban Dictionary, or sends a random word deifnition."
  category: "search"
  usage: "`urban [word]`"
  run: (bot, message, args, Discord) ->
    
    if not args[0]
      urban.random().first (json) ->
        def = new Discord.MessageEmbed()
          .setTitle json.word
          .setDescription json.definition
          .setThumbnail img
          .setColor "#1a1c33"
          .setFooter "Written by #{json.author}\nUpvotes: #{json.thumbs_up}   |   Downvotes: #{json.thumbs_down}"
        message.channel.send def
    else
      try
        urban(args.slice(0).join(" ")).first (json) ->
          if json == undefined then return message.channel.send(":x: No search results for __**#{args[0]}**__")
          search = new Discord.MessageEmbed()
            .setTitle json.word
            .setDescription json.definition
            .setThumbnail img
            .setColor "#1a1c33"
            .setFooter "Written by #{json.author}\nUpvotes: #{json.thumbs_up}   |   Downvotes: #{json.thumbs_down}"
          message.channel.send search
      catch err
        message.channel.send(":x: No search results for __**#{args[0]}**__")