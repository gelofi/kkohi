module.exports =
  name: "poll"
  aliases: ["vote", "pl"]
  description: "Reacts to your message as a poll."
  category: "tools"
  usage: "`poll [option here! (12, 123, 1234)] [Question Here!]`"
  run: (bot, message, args, Discord) ->

    switch args[0]
      when "12"
        if not args[1] then return message.reply "uhh... where's the Q?"
        message.react "1️⃣"
        .then () -> message.react "2️⃣"
        break
      when "123"
        if not args[1] then return message.reply "uhh... where's the Q?"
        message.react "1️⃣"
        .then () -> message.react "2️⃣"
        .then () -> message.react "3️⃣"
        break
      when "1234"
        if not args[1] then return message.reply "uhh... where's the Q?"
        message.react "1️⃣"
        .then () -> message.react "2️⃣"
        .then () -> message.react "3️⃣"
        .then () -> message.react "4️⃣"
        break
      else
        if not args[0] then return message.reply "uhh... where's the Q?"
        message.react "⬆️"
        message.react "⬇️"