module.exports =
  name: "dashboard"
  aliases: ["db", "website"]
  category: "settings"
  description: "Get useful links to go to the dashboard."
  usage: "`dashboard`"
  run: (bot, message, args, Discord) ->
    
    embed = new Discord.MessageEmbed()
    .setTitle "Configure Kko-hi fast!"
    .setDescription """
    [Website](https://kko-hi.herokuapp.com/)
    [Dashboard](https://kko-hi.herokuapp.com/#{message.guild.id})
    [Leaderboards](https://kko-hi.herokuapp.com/leaderboards/#{message.guild.id})
    [Manual](https://kko-hi.herokuapp.com/manual)
    """
    .setColor "#d9976f"
    message.channel.send embed