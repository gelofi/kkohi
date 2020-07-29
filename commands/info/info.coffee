Discord = require "discord.js"
{ stripIndent } = require "common-tags"
moment = require "moment";
keys = require '../../keys.json'

verificationLevels = keys.filters.verification
regions = keys.filters.regions

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
    category: "information"
    description: "Displays the information of a certain Discord object."
    run: (bot, message, args) -> 
      
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
        .addField 'Partnered', (if message.guild.partnered == true then "Yes" else "No"), true

        .addField 'Created on', moment.utc(message.guild.createdAt).format('MM/DD/YYYY h:mm A'), true
        
        .setTimestamp()
        .setColor "#b88769"
        return message.channel.send(serverembed);
      
      else
        
        if message.mentions.users.first()
          
          member = message.mentions.members.first() or message.guild.members.get(args[0]) or message.member;
          target = message.mentions.users.first() or message.author
          
          userembed = new Discord.MessageEmbed()
          .setAuthor member.user.tag + "'s information"
          .setThumbnail target.displayAvatarURL()
          .setColor member.displayHexColor
          .addField "ID", member.user.id
          
          .addField "Nickname", (if member.nickname != null then member.nickname else "None"), true
          .addField "Status", userstatus[member.user.presence.status], true
          .addField "Member List Role", member.roles.hoist, true
    
          .addField "Activity", (if member.user.presence.game then "🎮 #{membere.user.presence.game.name}" else "No activities"), true
          .addField "Permissions", "[#{member.permissions.bitfield}](https://discordapi.com/permissions.html##{member.permissions.bitfield})", true
          .addField "Color", "#{member.roles.color} #{member.displayHexColor}", true
          
          .addField "Roles", member.roles.cache.filter((r) => r.id isnt message.guild.id).map((roles) -> "#{roles}").join(" ") or "No Roles", true
          .addField 'Avatar URL', member.user.avatarURL()
          .addField "Join Date", member.joinedAt
          .addField "Created Account", member.user.createdAt
          .setTimestamp()
          message.channel.send(userembed);