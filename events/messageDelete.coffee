Discord = require "discord.js"
Util = require "../util/Util"
# Simple event: triggered when someone edits a message!
module.exports =
  event: "messageDelete"
  emitter: "on"
  run: (message, bot) ->
    db = bot.db
    try
      channel = await db.get("logchannel_#{message.guild.id}")
      if channel == null then return
      deleted = new Discord.MessageEmbed()
      .setAuthor "#{message.author.tag} deleted their message!", message.author.displayAvatarURL()
      .setDescription "#{message}\n\nChannel: #{message.channel}"
      .setColor '#ed8755'
      .setFooter "Author ID: ${message.author.id}\nMessage ID: ${message.id}"
      .setTimestamp();
      ch = message.guild.channels.cache.find((ch) -> ch.id is channel)
      return ch.send deleted
    catch err
      bot.users.cache.get(Util.Manage.error.channel).send embed: parse.error(err)
      console.error(err)