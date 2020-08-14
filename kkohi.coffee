### 
  Kko-hi // An open-source Discord bot, using CoffeeScript 2.5.1!
  Equipped with event and command handlers.
  Preloaded commands too! Uses a HexoDB database.
  - ♥ Fizx
###

Discord = require 'discord.js';
bot = new Discord.Client( disableEveryone: true );
keys = require "./keys"

# Database
Hexo = require 'hexo-db';
bot.db = new Hexo.Database(process.env.hexodb or keys.hexodb) # Database

# Command & Event Handler
bot.commands = new Discord.Collection();
bot.aliases = new Discord.Collection();
["command", "event"].forEach (handler) -> require("./handlers/#{handler}")(bot);

bot.login process.env.token or keys.token # Log-in the bot // Use your own token! Update it in the .env file!

# P.S. Never update CoffeeScript to 99.999.99999!