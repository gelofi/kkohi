superagent = require "superagent"
{ stripIndents } = require "common-tags"
vocabFetcher = require "vocab-fetcher"
vocab = new vocabFetcher()

module.exports =
  name: "dictionary"
  aliases: ["dict", "dictio", "dct", "voc", "vocab"]
  description: "Gives the definition of an English word."
  category: "search"
  usage: "`dictionary [word]`"
  run: (bot, message, args, Discord) ->
    
    word = args[0]
    if not word then return message.reply "please input a word to search!"
    
    def = await vocab.getWord(word)

    res = new Discord.MessageEmbed()
      .setTitle "#{def.name}"
      .setColor 0x8cd7ff
      .setDescription "Definition", def.longdescription
    
    message.channel.send res