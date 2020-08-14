perms = require "../../util/perms"
Util = require "../../util/Util"
ms = require "ms"

module.exports =
  name: "slowmode"
  aliases: ["sm", "slm", "slow"]
  description: "Turn on or edit slowmode in the current/tagged channel."
  category: "tools"
  usage: "`slowmode [number]` or `slowmode [number] [#channel]`"
  run: (bot, message, args, Discord) ->
    
    if not message.guild.me.hasPermission Util.Manage.channels then return message.reply perms.me.channels
    if not message.member.hasPermission Util.Manage.channels then return message.reply perms.channels
    
    if not args[0] then return message.reply "input a number to modify the slowmode time!"
    if args[0] is "off"
      message.channel.setRateLimitPerUser(0).catch (err) -> 
        bot.channels.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
      message.channel.send "**Slowmode** for this channel is now set to `#{args[0]}` (Toggled off)."
    if isNaN parseInt(args[0]) then return message.reply "that's not a number!"
    num = ms (parseInt args[0])
    if message.mentions.channels.first()
      channel = message.mentions.channels.first() or message.guild.channels.get args[0]
      channel.setRateLimitPerUser(ms(num)).catch (err) ->
        bot.channels.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
      message.channel.send "**Slowmode** for #{channel} channel has been set to `#{args[0]}`."
    else
      message.channel.setRateLimitPerUser(ms(num)).catch (err) -> 
        bot.channels.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
        message.channel.send embed: Util.Handle.error(err)
      message.channel.send "**Slowmode** for this channel is now set to `#{args[0]}`."