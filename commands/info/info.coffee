Discord = require "discord.js"; moment = require "moment"
{ stripIndent } = require "common-tags"

filters = require '../../util/Filters'

verificationLevels = filters.verification
regions = filters.regions
bool = filters.bool

timeouts = 
  "60": "1 minute"
  "300": "5 minutes"
  "600": "10 minutes"
  "900": "15 minutes"
  "1800": "30 minutes"
  "3600": "1 hour"

userstatus = 
  online: "Online"
  idle: "Idle"
  dnd: "Do Not Disturb"
  offline: "Offline/Invisible"

module.exports = 
    name: "info"
    aliases: ["information", "i"]
    category: "information"
    description: "Displays the information of a certain Discord object."
    run: (bot, message, args) -> 
      
      if not args[0] then return message.reply "please mention a `user`/`channel`/`role`! Or enter `server`, `me` or a custom emoji to collect useful info!"
      
      if args[0] is 'server' or args[0] is 'guild'
        
        serverembed = new Discord.MessageEmbed()
        .setTitle 'Info for ' + message.guild.name
        .setThumbnail message.guild.iconURL()
        .addField 'Server ID', message.guild.id
        
        .addField 'Owner', message.guild.owner, true 
        .addField 'Emojis', message.guild.emojis.cache.size, true
        .addField 'Boosts', message.guild.premiumSubscriptionCount or 0 + message.guild.premiumTier ? "Tier #{message.guild.premiumTier}" : 'No tier', true 
        
        .addField 'Region', regions[message.guild.region], true
        .addField 'AFK Channel',  (if message.guild.afkChannel == null then 'None' else message.guild.afkChannel.name), true
        .addField 'AFK Timeout', timeouts[message.guild.afkTimeout], true
        
        .addField 'Verification Level', verificationLevels[message.guild.verificationLevel], true
        .addField 'Members', message.guild.members.cache.filter((member) -> not member.user.bot).size, true
        .addField "Bots", message.guild.members.cache.filter((m) -> m.user.bot).size, true
        
        .addField "Roles", message.guild.roles.cache.size, true
        .addField 'Channels', message.guild.channels.cache.filter((channel) -> channel.type isnt 'category' and channel.type isnt 'voice').size, true
        .addField "Catergories", message.guild.channels.cache.filter((channel) -> channel.type == 'category').size, true
        
        .addField 'Voice Channels', message.guild.channels.cache.filter((c) -> c.type == 'voice').size, true
        .addField 'Alert Channel', message.guild.systemChannel.name or 'None', true
        .addField 'Partnered', bool[message.guild.partnered], true

        .addField 'Created on', moment.utc(message.guild.createdAt).format('MM/DD/YYYY h:mm A'), true
        
        .setTimestamp()
        .setColor "#b88769"
        return message.channel.send(serverembed);
      
      else if message.mentions.users.first()
          
          member = message.mentions.members.first() or message.guild.members.get args[0] or message.member;
          target = message.mentions.users.first() or message.author
          
          userembed = new Discord.MessageEmbed()
          .setAuthor member.user.tag + "'s information"
          .setThumbnail target.displayAvatarURL()
          .setColor member.displayHexColor
          .addField "ID", member.user.id
          
          .addField "Nickname", member.nickname or "None", true
          .addField "Status", userstatus[member.user.presence.status], true
          .addField "Member List Role", member.roles.hoist or "None", true
    
          .addField "Activity", (if member.user.presence.game then "🎮 #{member.user.presence.game.name}" else "No activities"), true
          .addField "Permissions", "[#{member.permissions.bitfield}](https://discordapi.com/permissions.html##{member.permissions.bitfield})", true
          .addField "Color", "#{member.roles.color} #{member.displayHexColor}", true
          
          .addField "Roles", member.roles.cache.filter((r) => r.id isnt message.guild.id).map((roles) -> "#{roles}").join(" ") or "No Roles", true
          .addField 'Avatar URL', member.user.avatarURL()
          .addField "Join Date", member.joinedAt
          .addField "Created Account", member.user.createdAt
          .setTimestamp()
          return message.channel.send userembed
          
      else if message.mentions.channels.first()
          
          try
            channel = message.mentions.channels.first() or message.guild.channels.get args[0]
          
            invites = await channel.fetchInvites()
            pins = await channel.messages.fetchPinned()
            channelembed = new Discord.MessageEmbed()
            .setAuthor "Info for ##{channel.name}"
            .setDescription channel.topic or 'None'
            .addField "ID", channel.id
          
            .addField "Category", (if channel.parent == null then 'None' else channel.parent.name), true
            .addField "NSFW", bool[channel.nsfw], true 
            .addField "Slowmode", (if channel.rateLimitPerUser is 0 then 'Off' else channel.rateLimitPerUser), true
    
            .addField "Members w/ access", channel.members.filter((member) -> not member.user.bot).size, true
            .addField "Pins", pins.size  or "None", true
            .addField "Invites", invites.size, true
          
            .addField "Last Pin at", if channel.lastPinAt is null then "No pins yet" else channel.lastPinAt
            .addField "Created at", channel.createdAt
            .setColor "#b88769"
            return message.channel.send channelembed
          catch err
            return message.channel.send "Invalid channel specified! Please specify a **valid** channel."
          
      else if args[0] is "me"
          
          target = message.member
          
          meembed = new Discord.MessageEmbed()
          .setAuthor target.user.tag + "'s information"
          .setThumbnail target.user.displayAvatarURL()
          .setColor target.displayHexColor
          .addField "ID", target.user.id
          
          .addField "Nickname", (if target.nickname != null then target.nickname else "None"), true
          .addField "Status", userstatus[target.user.presence.status], true
          .addField "Member List Role", target.roles.hoist, true
    
          .addField "Activity", (if target.user.presence.game then "🎮 #{target.user.presence.game.name}" else "No activities"), true
          .addField "Permissions", "[#{target.permissions.bitfield}](https://discordapi.com/permissions.html##{target.permissions.bitfield})", true
          .addField "Color", "#{target.roles.color} #{target.displayHexColor}", true
          
          .addField "Roles", target.roles.cache.filter((r) => r.id isnt message.guild.id).map((roles) -> "#{roles}").join(" ") or "No Roles", true
          .addField 'Avatar URL', target.user.avatarURL()
          .addField "Join Date", target.joinedAt
          .addField "Created Account", target.user.createdAt
          .setTimestamp()
          return message.channel.send meembed
        
      else if message.mentions.roles.first()
        
        try
          role = message.mentions.roles.first() or message.guild.roles.get args[0]
          roledMembers = await role.members.size
        
          roleembed = new Discord.MessageEmbed()
          .setAuthor "Info for #{role.name}"
        
          .addField "ID", role.id
          .addField "Raw Tag", "`#{role}`" 
        
          .addField "Tag", role, true
          .addField "Color", role.hexColor, true
          .addField "Mentionable", bool[role.mentionable], true
        
          .addField "Separated", bool[role.hoist], true
          .addField "Permissions", "[#{role.permissions.bitfield}](https://discordapi.com/permissions.html##{role.permissions.bitfield})", true
          .addField "Position", "#{message.guild.roles.cache.size - role.position} / #{message.guild.roles.cache.size}", true
        
          .addField "Highest Role of", "#{role.members.filter((mem) -> mem.roles.highest.id == role.id).size} member(s)", true
          .addField "Externally Managed", bool[role.managed], true
          .addField "Anyone can mention", bool[role.mentionable], true
        
          .addField "Users with this role", role.members.map((mem) -> "#{mem}").join(" ") or "None"
          .addField "Created at", role.createdAt
        
          .setColor role.hexColor
          return message.channel.send roleembed
        
        catch err
          console.error err
          error = await message.channel.send "An unknown error has occured.\nIgnore this message, the error has been sent to the developers to fix."
          error.delete( timeout: 5000 )
          
      else if args[0].startsWith("<:") and args[0].endsWith(">")
          
          try
            name = args[0].split(":")[1]
            raw = args[0].split(":")[2]
            emojiID = raw.substring(0, raw.length - 1)
            emoji = bot.emojis.cache.find (e) -> e.id is emojiID
            
            try
              emojiMaker = await emoji.fetchAuthor()
            catch err
              emojiMaker = "Unknown #0000"
            
            emojiEmbed = new Discord.MessageEmbed()
            .setColor "#b88769"
            .setAuthor "Info for emoji :#{emoji.name}:"
            .setThumbnail emoji.url
          
            .addField "ID", emoji.id
            .addField "Animated", bool[emoji.animated], true
            .addField "Server", emoji.guild.name, true
            .addField "Added by", emojiMaker, true
            
            .addField "Creation Date", emoji.createdAt
            return message.channel.send emojiEmbed
          catch err
            message.channel.send "I can't find that emoji! Perhaps I'm not in the server that emoji is from..?"
            
      else
        
        return message.channel.send "\\*sips coffee\\* Hmm... I can't find any information for that."