Util = require "../../util/Util"
perms = require "../../util/perms"

module.exports =
  name: "emoji"
  aliases: ["emote", "emo"]
  description: "Add, clone, or view a custom-emoji."
  category: "tools"
  usage: "`emoji [ clone | add | view ] [custom-emoji]`"
  run: (bot, message, args, Discord) ->
    
    if not message.guild.me.hasPermission Util.Manage.emojis then return message.reply perms.me.emoji
    if not message.member.hasPermission Util.Manage.emojis then return message.reply perms.emoji
    
    action = args[0].toLowerCase()
    if not action then return message.reply "specify an action! `[ clone | add | view ]` :coffee:"
    
    emoji = args[1]
    if not emoji then return message.reply "specify an emoji! :coffee:"

    if action is "clone"
      
      try
        def = (format) ->
          clone = Util.Parse.emojiID emoji
          if format and format.toLowerCase() == ("moving" or "animated" )
            markup = "https://cdn.discordapp.com/emojis/" + clone + ".gif";
            created = await message.guild.emojis.create markup, args[2] or clone
            return message.channel.send "Emoji #{created} (`#{created.name}`) created for this guild!"
          else
            markup = "https://cdn.discordapp.com/emojis/" + clone + ".png";
            created = await message.guild.emojis.create markup, args[2] or clone
            return message.channel.send "Emoji #{created} (`#{created.name}`) created for this guild!"

        guilded = ->
          clone = bot.emojis.cache.find (e) -> e.id is Util.Parse.emojiID emoji
          markup = "https://cdn.discordapp.com/emojis/" + clone.id + (if clone.animated is true then ".gif" else ".png") or ".png"
          created = await message.guild.emojis.create markup, args[2] or clone.name
          message.channel.send "Emoji #{created} (`#{created.name}`) created for this guild!"
        
        # Functions
        act = bot.emojis.cache.find (e) -> e.id is Util.Parse.emojiID emoji
        if act == undefined
          def(args[3])
        else
          guilded()
          
      catch err
        bot.users.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
        
    if action is "add"
      
      markup = args[1]
      
      if not markup then return message.reply "provide an image URL!"
      if not markup.startsWith "http" then return message.reply "that's an invalid image URL!"
      
      try
        
        created = await message.guild.emojis.create markup, args[2] or Date.now()
        message.channel.send "Emoji #{created} (`#{created.name}`) created for this guild!"
        
      catch err
        bot.users.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
        
    if action is "view" or action is "enlarge"
      try
        def = (format) ->
          clone = Util.Parse.emojiID emoji
          if format and format.toLowerCase() == ("moving" or "animated" )
            markup = "https://cdn.discordapp.com/emojis/" + clone + ".gif";
            return message.channel.send markup
          else
            markup = "https://cdn.discordapp.com/emojis/" + clone + ".png";
            return message.channel.send markup

        guilded = ->
          clone = bot.emojis.cache.find (e) -> e.id is Util.Parse.emojiID emoji
          markup = "https://cdn.discordapp.com/emojis/" + clone.id + (if clone.animated is true then ".gif" else ".png") or ".png"
          message.channel.send markup

        if act == undefined
          def(args[2])
        else
          guilded()
      catch err
        bot.users.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
        