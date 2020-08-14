Discord = require "discord.js"

module.exports = 
    name: "avatar"
    aliases: ["pfp", "av"]
    category: "tools"
    usage: "`avatar [@user]` or `avatar`"
    description: "Fetches the profile photo of a user."
    run: (bot, message, args) -> 

      member = message.mentions.members.first() or message.member
      avatarembed = new Discord.MessageEmbed()
        .setAuthor member.user.username + "'s avatar and URL:"
        .setDescription member.user.avatarURL( format: "png", size: 2048 )
        .setImage member.user.displayAvatarURL( size: 2048 )
        .setColor member.displayHexColor
        .setTimestamp()
      message.channel.send avatarembed