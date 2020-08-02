### 
  Kko-hi // An open-source Discord bot, using CoffeeScript 2.5.1!
  Equipped with an event and command handler.
  Preloaded commands too! Uses a HexoDb database.
  - ♥ Fizx
###

Discord = require 'discord.js'; bot = new Discord.Client( disableEveryone: true );
Hexo = require 'hexo-db'; bot.db = new Hexo.Database(process.env.hexodb) # Database

# Command & Event Handler
bot.commands = new Discord.Collection(); bot.aliases = new Discord.Collection();
["command", "events"].forEach (handler) -> require("./handlers/#{handler}")(bot)

bot.login process.env.token # Log-in the bot // Use your own token! Update it in the .env file!

# P.S. Never update CoffeeScript to 99.999.99999!