perms = require "../../util/perms"
Util = require "../../util/Util"

module.exports =
  name: "purge"
  aliases: ["del", "delmsg", "clean"]
  description: "Deletes a number of messages between 1 - 99."
  category: "tools"
  usage: "`purge [number]` or `purge [number] [#channel]`"
  run: (bot, message, args, Discord) ->
    
    if not message.guild.me.hasPermission Util.Manage.messages then return message.reply perms.me.messages
    if not message.member.hasPermission Util.Manage.messages then return message.reply perms.messages
    
    if not message.guild.me.hasPermission manage.channels then return message.reply perms.me.channels
    if not message.member.hasPermission manage.channels then return message.reply perms.channels
  
    if message.mentions.channels.first()
      try
        channel = message.mentions.channels.first() or message.guild.channels.get args[0]
        if not args[0] then return message.reply 'type a # of messages to purge! Maximum deleted messages are 99.'
        if isNaN(args[0]) == true then return message.reply("that isn't a number!")
        if args[0] < 1 or args[0] > 99 then return message.reply("only 2 - 99 messages can be purged per command!")
        x = parseInt(args[0]) + 1
        channel.bulkDelete x
        message.channel.send "Successfully purged #{x} messages in #{channel}!"
      catch err
        bot.users.cache.get(Util.Manage.error.channel).send embed: parse.error(err)
        message.channel.send embed: parse.error(err)
    else
      try
        if not args[0] then return message.reply 'type a # of messages to purge! Maximum deleted messages are 99.'
        if isNaN(args[0]) == true then return message.reply("that isn't a number!")
        if args[0] < 1 or args[0] > 99 then return message.reply("only 2 - 99 messages can be purged per command!")
        x = parseInt(args[0]) + 1
        message.channel.bulkDelete x
      catch err
        bot.users.cache.get(Util.Manage.error.channel).send embed: parse.error(err)
        message.channel.send embed: parse.error(err)