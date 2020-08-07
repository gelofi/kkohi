# Command Handling!
{ readdirSync } = require 'fs';
ascii = require 'ascii-table'

# Create a table
table = new ascii "Commands" ;
table.setHeading "Command", "Load Status" ;

module.exports = (bot) ->
  
  today = new Date();
  date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
  time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
  dateTime = date+' '+time;
  
  readdirSync("./commands/").forEach (dir) -> 
      # Filter so we only have .coffee command files
      commands = readdirSync("./commands/#{dir}/").filter((file) -> file.endsWith(".coffee"));
    
      # Loop over the commands, and add all of them to a collection
      # If there's no name found, prevent it from returning an error,
      # By using a cross in the table we made.
      for file in commands
        pull = require "../commands/#{dir}/#{file}";

        if pull.name then bot.commands.set pull.name, pull ; table.addRow(file, '✅');
        else table.addRow(file, "❌  -> missing a help.name, or help.name is not a string."); continue;
            
        # If there's an aliases key, read the aliases.
        if pull.aliases and Array.isArray(pull.aliases)  then pull.aliases.forEach((alias) -> bot.aliases.set(alias, pull.name))

    console.log dateTime + " changes saved | Commands Loaded"
    #console.log table.toString();
