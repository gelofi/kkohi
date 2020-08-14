module.exports = 
  name: "invite"
  aliases: ["inv"]
  category: "info"
  usage: "`invite`"
  description: "Invite Kko-hi to your server, today!"
  run: (bot, message, args, Discord) ->
    
    inv = new Discord.MessageEmbed()
    .setTitle "Invite Kko-hi to your server!"
    .setDescription "Click [here](https://discord.com/api/oauth2/authorize?client_id=733558874044366878&permissions=2117463415&scope=bot) to invite!"
    .setColor "#c47b58"
    .setFooter "You may pick the permissions too!"
    message.author.send inv
    message.reply "I DMed you! :coffee:"