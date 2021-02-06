Discord = require "discord.js"
translate = require "@vitalets/google-translate-api"
img = 'https://cdn.clipart.email/b362c028ba2007d4563c521999b73c72_download-best-free-google-logo-icon-vector-drawing-google-_2000-2000.png'

module.exports = 
  name: "translate"
  aliases: ["tl", "trans"]
  category: "tools"
  usage: "`translate [language] [text]"
  description: "Translates the text entered to the desired language."
  run: (bot, message, args) -> 
    
    text = args.slice(1).join()
    lang = args[0]
    
    fix = {
      undefined: lang
    }

    if not text then return message.reply "please put a text to translate!"
    if not lang then return message.reply "please put a language for the text to be translated into!"
  
    translate(text, { to: lang }).then (res) ->
      translation = new Discord.MessageEmbed()
      .setTitle "Translated from #{translate.languages[res.from.language.iso]} to #{translate.languages[lang]} (#{lang})"
      .setThumbnail img
      .addField "Text:", "#{text}", true
      .addField "Translation", "#{res.text}", true
      .setFooter "Google Translate API is used!"
      .setColor "#4c8bf5"
      try
        message.channel.send translation
      catch error
        console.error error