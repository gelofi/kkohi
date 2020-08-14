ms = require "ms"
Util = require "../../util/Util"

module.exports =
  name: "remind"
  aliases: ["reminder", "remindme", "rmd"]
  category: "tools"
  description: "Kko-hi will remind you anything you need."
  usage: "`remind [time] [reminder]`"
  run: (bot, message, args, Discord) =>
    try
      remind = args.slice(1).join " "
      if not args[0] then return message.reply "specify an amount of time!"
      time = ms parseInt(args[0])
      if not args[1] then return message.reply "about what am I gonna remind you?"
      # if isNaN time then return message.reply "that's not a number / time input!"
      message.channel.send "Alright! I will remind you: **#{remind}** in __#{ms(time, { long: true })}__!"

      reminder = ->
        embed = new Discord.MessageEmbed()
        .setTitle ":alarm_clock: Here's your reminder!"
        .setDescription remind
        .setColor message.member.displayHexColor
        .setFooter "This is a reminder you set #{ms(time, { long: true })} ago."
        message.author.send embed

      setTimeout reminder, time
    catch err
      bot.users.cache.get(Util.Manage.error.channel).send embed: Util.Handle.error(err)
      message.channel.send embed: Util.Handle.error(err)