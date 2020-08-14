Discord = require 'discord.js'

module.exports =
    name: 'prefix'
    aliases: ["sp", "setprefix"]
    category: "settings"
    usage: "`prefix [new-prefix]`"
    description: "Changes the prefix of the bot"
    run: (bot, message, args) ->
      db = bot.db

      prefix = await db.fetch "prefix_#{message.guild.id}"
      if prefix == undefined then prefix = 'l.';
      if !message.member.hasPermission 'MANAGE_GUILD'   then return message.reply "you don't have enough permissions to change my prefix!"
      if !args[0] then return message.reply "please define the new prefix you desire to set!"
      if args[1] then return message.reply "prefixes with spaces are not allowed!"
      if args[0].length > 3 then return message.channel.send "No prefixes more than 3 characters!"

      if args[0] is 'kko-' or args[0] is "reset"
        db.delete "prefix_#{message.guild.id}"
        return message.channel.send "The prefix has been reset successfully."
      
      await db.set "prefix_#{message.guild.id}", args[0]
      embedp = new Discord.MessageEmbed()
      .setDescription "My prefix for this guild is now changed to `#{args[0]}` successfully."
      .setColor "#3654ff"
      .setFooter "You can mention me for me to send my prefix in this server."
      message.channel.send embedp
