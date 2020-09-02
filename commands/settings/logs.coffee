module.exports =
  name: 'log'
  aliases: ["logging", "logchannel", "logs"]
  category: "settings"
  usage: "`log [#channel]`"
  description: "Sets up the log channel for Kko-hi."
  run: (bot, message, args, Discord) ->
    
    db = bot.db
    guild = message.guild.id
    if not message.member.hasPermission 'MANAGE_GUILD'
      return message.reply "you don't have enough permissions to change the logging channel!"
    
    if not args[0] or not message.mentions.channels.first()
      return message.reply "please specify a channel to set it as the logging channel!"
    
    if args[0].toLowerCase() is "reset" or args[0].toLowerCase() is "delete"
      db.delete("logchannel_#{guild}");
      return message.channel.send "**Log Channel** has been reset."
    
    channel = message.mentions.channels.first() or message.guild.channels.get args[0]
    
    await db.set("logchannel_#{guild}", channel.id)
    message.channel.send "**Log Channel** is now set to #{channel}."