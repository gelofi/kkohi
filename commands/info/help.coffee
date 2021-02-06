splashes = require "../../util/Splashes.json"

module.exports = 
  name: "help"
  aliases: ["h", "command", "cmd", "commands"],
  category: "info"
  description: "Returns all Kko-hi commands, with some links to help you."
  usage: "`help [command]` or `help`"
  run: (bot, message, args, Discord) -> 
  
    prefix = await bot.db.fetch "prefix_#{message.guild.id}"
    if prefix == null then prefix = process.env.prefix;
    
    if not args[0]
      commands = []
      allhelp = new Discord.MessageEmbed()
      .setAuthor "Kko-hi - Commands List", bot.user.displayAvatarURL()
      .setColor "#ed8755"
      .setDescription """
**Call `#{prefix}help [command]` for more command info!**
You may also visit our [server](https://discord.gg/Ajpz8wu) for help,
Or our [website](https://kko-hi.herokuapp.com) to learn more.
"""
      .setFooter "Currently in #{bot.guilds.cache.size} servers!"
      .setTimestamp()
      bot.commands.forEach (command) ->
        commands.push("#{command.name} #{command.category}")
      # Categories
      bot = []; info = []; settings = []; images = [];
      fun = []; search = []; tools = [];
      commands.forEach (cmd) ->
        if cmd.includes "bot" then bot.push cmd.split(" ")[0]
        if cmd.includes "fun" then fun.push cmd.split(" ")[0]
        if cmd.includes "images" then images.push cmd.split(" ")[0]
        if cmd.includes "info" then info.push cmd.split(" ")[0]
        if cmd.includes "tools" then tools.push cmd.split(" ")[0]
        if cmd.includes "search" then search.push cmd.split(" ")[0]
        if cmd.includes "settings" then settings.push cmd.split(" ")[0]
          
      allhelp.addField ":video_game: Fun & Random", "`#{fun.join("` `")}`"
      .addField ":frame_photo: Images", "`#{images.join("` `")}`"
      .addField ":card_box: Information", "`#{info.join("` `")}`"
      .addField ":tools: Utilities & Tools", "`#{tools.join("` `")}`"
      .addField ":mag_right: Search things", "`#{search.join("` `")}`"
      .addField ":coffee: Kko-hi Settings", "`#{settings.join("` `")}`"
      message.channel.send allhelp
      
    # Things below are automatically added
    else
      cmd = bot.commands.get args[0]
      if not cmd then cmd = bot.commands.get bot.aliases.get(args[0])
      if not cmd then return message.reply "I don't have that command... :thinking:"
      help = new Discord.MessageEmbed()
      .setAuthor "Command - \"#{cmd.name}\""
      .setDescription cmd.description
      .addField "Usage", prefix + cmd.usage
      .addField "Aliases", "`" + (cmd.aliases).join("`, `") + "`"
      .setColor "#b38c79"
      message.channel.send help