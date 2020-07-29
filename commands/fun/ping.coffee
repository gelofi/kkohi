Discord = require("discord.js")
{ stripIndent } = require("common-tags")

module.exports = 
    name: "ping",
    aliases: ["pp"],
    category: "fun",
    description: "Returns latency ping of Kko-hi.",
    run: (bot, message, args) -> 
    
      m = await message.channel.send("Pinging...");

      keys = require "../../keys.json"
      ping = keys.splashes.ping
      m.edit(ping[Math.round(Math.random() * (ping.length - 1))] + " -#{m.createdTimestamp - message.createdTimestamp}ms-")
    
