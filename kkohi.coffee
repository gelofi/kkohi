Discord = require 'discord.js'; bot = new Discord.Client( disableEveryone: true );

# Get required tokens
keys = require './keys';

# Collections
bot.commands = new Discord.Collection(); bot.aliases = new Discord.Collection();

# Command Handler
["command"].forEach (handler) -> require("./handlers/#{handler}")(bot)

prefix = keys.bot.prefix;

bot.on "ready", ->
  console.log "#{bot.user.tag} is now online!"
  bot.user.setActivity("CoffeeScript",  type: "PLAYING" )
  
bot.on "message", (message) ->
  if message.channel.type == "dm" then return
  if message.author.bot then return;
  if message.mentions.users.first() then if message.mentions.users.first().id == "#{bot.user.id}" then return message.channel.send "My prefix is `kko-`. You may change it by the `prefix` command!"
  
  if !message.content.startsWith prefix  then return;
  args = message.content.slice(prefix.length).trim().split(/ +/g)
  cmd = args.shift().toLowerCase();
  if cmd.length == 0 then return;

  # Get the command
  command = bot.commands.get(cmd);
  # If none is found, try to find it by alias
  if !command then command = bot.commands.get(bot.aliases.get(cmd));

  # If a command is finally found, run the command
  if command then command.run(bot, message, args);
  
bot.login keys.bot.token