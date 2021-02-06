Discord = require "discord.js"
{ stripIndent } = require "common-tags"
superagent = require "superagent"

module.exports = 
    name: "cat"
    aliases: ["catto"]
    category: "images"
    usage: "`cat`"
    description: "Sends a photo of a cute cat."
    run: (bot, message, args) -> 

        { body } = await superagent.get "http://aws.random.cat/meow"
        if not { body } then return message.channel.send "An error occured! Please try again later!"
      
        cat = new Discord.MessageEmbed()
        .setAuthor 'Cats!', message.guild.iconURL
        .setColor "#6fd1de"
        .setImage body.file
        .setFooter 'Cat lovers are called Ailurophiles.'
        
        message.channel.send cat