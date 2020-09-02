Discord = require "discord.js"
Util = require "../util/Util"
# Simple event: triggered when someone edits a message!
module.exports =
  event: "messageUpdate"
  emitter: "on"
  run: (oM, nM, bot) ->
    db = bot.db
    try
      channel = await db.get("logchannel_#{oM.guild.id}"); if channel == null then return
      if oM.author.bot then return; if oM.content is nM.content then return
      edited = new Discord.MessageEmbed()
      .setAuthor "#{nM.author.tag} edited their message!", nM.author.displayAvatarURL()
      .setDescription "In #{nM.channel} | [Link](https://discordapp.com/channels/#{nM.guild.id}/#{nM.channel.id}/#{nM.id})"
      .addField "Old Message", "#{oM}", true
      .addField "New Message", "#{nM}", true
      .setColor '#ed8755'
      .setFooter "Message ID: #{nM.id}"
      .setTimestamp();
      ch = nM.guild.channels.cache.find((ch) -> ch.id is channel)
      return ch.send edited
    catch err
      bot.users.cache.get(Util.Manage.error.channel).send embed: parse.error(err)
      console.error(err)