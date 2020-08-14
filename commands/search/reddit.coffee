musakui = require "musakui"
module.exports =
  name: "reddit"
  aliases: ["reddit-fetch", "rd", "rdt"]
  category: "search"
  description: "Fetches a random reddit post from a specified subreddit."
  usage: "`reddit [subreddit]`"
  run: (bot, message, args, Discord) ->
    
    if not args[0] then return message.reply "specify a subreddit to fetch a post from!"
    subr = args[0]
    result = await musakui args[0]
    if not message.channel.nsfw and result.nsfw is true then return message.channel.send "Failed! The fetched post was NSFW, this channel isn't an NSFW channel!"
    try
      reddit = new Discord.MessageEmbed()
        .setDescription "**[r/#{subr}](https://reddit.com/r/#{subr})** • [u/#{result.author}](https://reddit.com/u/#{result.author}) | [Post~link](#{result.reddit_url})\n\n**#{result.title}**\n\n#{result.content}"
        .setImage result.media_url
        .setColor "#ff5700"
        .setFooter "Upvotes: #{result.upvotes} | Downvotes: #{result.downvotes} | Comments: #{result.comments}"
      message.channel.send reddit
    catch err
      message.reply "I can't find that subreddit!"