Discord = require("discord.js")
{ stripIndent } = require("common-tags")

module.exports = 
    name: "hi"
    category: "fun"
    description: "Call this command and say hi to Kko-hi!"
    run: (bot, message, args) -> 
      
      message.channel.send "Hi! I'm Kko-hi. A Discord bot created on CoffeeScript 2.0!"
