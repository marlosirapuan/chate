// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import { Presence } from "phoenix"
import socket from "./socket"

let channel = socket.channel('room:lobby', {}) // connect to chat "room"
let chatMessages = document.getElementById("chat-messages")
let message = document.getElementById('message-input')
let totalUsers = document.getElementById('users-online')

let presences = {}
let onlineUsers = document.getElementById("online-users")
let listUsers = (user) => {
    return {
        user: user
    }
}
let renderUsers = (presences) => {
    onlineUsers.innerHTML = Presence
        .list(presences, listUsers)
        .map(presence => `<li class="list-group-item d-flex justify-content-between lh-condensed">${presence.user}</li>`).join("")

    totalUsers.innerHTML = document.getElementById('online-users').getElementsByTagName("li").length
}

channel.on('presence_state', state => {
    presences = Presence.syncState(presences, state)
    renderUsers(presences)
});
channel.on('presence_diff', diff => {
    presences = Presence.syncDiff(presences, diff)
    renderUsers(presences)
});

channel.on('shout', function (payload) { // listen to the 'shout' event
    let name = payload.name;
    let msg = payload.message;
    var tmpl = document.createElement("div");
    tmpl.innerHTML = `<b>${name}</b>: ${msg}`
    chatMessages.appendChild(tmpl)
    chatMessages.scrollTop = chatMessages.scrollHeight
});

channel.join()
    .receive("ok", resp => { console.log("All good, bois.") })
    .receive("error", resp => { console.log("Unable to join", resp) })

let msg = document.getElementById('message-input')

// "listen" for the [Enter] keypress event to send a message:
if (msg && channel) {
    msg.addEventListener('keypress', function (event) {
        if (event.keyCode == 13 && msg.value.length > 0) { // don't sent empty msg.
            channel.push('shout', { // send the message to the server on "shout" channel
                message: msg.value    // get message text (value) from msg input field.
            })
            msg.value = ''         // reset the message input field for next message.
        }
    })

    socket.connect()
    message.focus()
}