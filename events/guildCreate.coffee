Discord = require 'discord.js'
module.exports =
  event: "guildCreate"
  emitter: "on"
  run: (guild, bot) ->
    
    channelID;
    channels = guild.channels;
    for c in channels
      channelType = c[1].type;
      if channelType is "text" then channelID = c[0];
    
    channel = bot.channels.cache.get guild.systemChannelID or channelID
    welcome = new Discord.MessageEmbed()
    .setTitle "Thanks for inviting me!"
    .setDescription """
    Hi! I'm Kko-hi, a Discord bot coded purely on CoffeeScript!
    See my commands list using the `help` command.
    Mention me to discover my prefix! Default is `kko-`

    You may find the starter source code by the link below.
    Thanks! ♥ - Fizx
    """
    .setColor "#db9a7b"
    channel.send welcome