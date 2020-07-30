Discord = require("discord.js")
{ stripIndent } = require("common-tags")

module.exports = 
    name: "say"
    aliases: ["msg"]
    category: "fun"
    description: "Call this command and Kko-hi will repeat what you said."
    run: (bot, message, args) -> 

      if not args.slice(0).join(" ")
        return message.channel.send("Say something!").then (msg) -> message.delete( timeout: 4000 )
      
      sayMsg = args.slice(0).join(" ");
      message.delete(); 
      message.channel.send sayMsg