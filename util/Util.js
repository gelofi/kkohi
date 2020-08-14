const Util = {
  Handle: {
    error: (err) => {
      let error = {
        "color": "#e8e856",
        "title": `Error Occured`,
        "description": "An unexpected error occured.",
        "fields": [{ "name": "Error", "value": `\`\`\`${err}\`\`\``}],
        "footer": { "text": "The error was automatically reported to the developers." }
      }
      return error
    }
  },
  Parse: {
    emojiID: (emoji) => {
      var raw = emoji.split(":")[2]
      var emojiID = raw.substring(0, raw.length - 1)
      return emojiID
    }
  },
  Manage: {
    "error": {
      "channel": "742343953491165276",
      "id": Date.now()
      },  
    "channels": "MANAGE_CHANNELS",
    "messages": "MANAGE_MESSAGES",
    "emojis": "MANAGE_EMOJIS",
    "roles": "MANAGE_ROLES",
    "kick": "KICK_MEMBERS",
    "ban": "BAN_MEMBERS"
  }
}

module.exports = Util