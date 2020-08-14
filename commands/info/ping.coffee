splashes = require "../../util/Splashes.json"
module.exports = 
  name: "ping"
  aliases: ["p"]
  category: "info"
  usage: "`ping`"
  description: "Returns latency ping of Kko-hi, with Coffee facts!"
  run: (bot, message, args) -> 
  
    m = await message.channel.send("Pinging...");
    ping = splashes.ping
    m.edit(ping[Math.round(Math.random() * (ping.length - 1))] + " -#{m.createdTimestamp - message.createdTimestamp}ms-")