# The core event!
module.exports =
  event: "message"
  emitter: "on"
  run: (message, bot) ->
    prefix = await bot.db.fetch("prefix_#{message.guild.id}")
    if prefix == null then prefix = process.env.prefix;
    if message.channel.type is "dm" then return # Ignores DMs
    if message.author.bot then return; # Ignores other bots
    if message.mentions.users.first() 
      if message.mentions.users.first().id is bot.user.id # Ensure the mention
        message.channel.send "My prefix is `#{prefix}`. You may change it by the `prefix` command!"
    
    if not message.content.startsWith prefix  then return;
    args = message.content.slice(prefix.length).trim().split(/ +/g)
    cmd = args.shift().toLowerCase();
    if cmd.length is 0 then return;
    command = bot.commands.get(cmd); # Get the command
    if not command then command = bot.commands.get(bot.aliases.get(cmd)); # If none is found, try to find it by alias
    if command then command.run(bot, message, args); # If a command is finally found, run the command