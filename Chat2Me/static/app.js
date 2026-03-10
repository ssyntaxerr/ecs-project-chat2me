const usernameInput = document.getElementById("username");
const connectBtn = document.getElementById("connect-btn");
const messageInput = document.getElementById("message");
const sendBtn = document.getElementById("send-btn");
const chatBox = document.getElementById("chat-box");

let socket = null;
let lockedUsername = "";

function addMessage(text) {
    const messageEl = document.createElement("div");
    messageEl.className = "chat-message";
    messageEl.textContent = text;
    chatBox.appendChild(messageEl);
    chatBox.scrollTop = chatBox.scrollHeight;
}

connectBtn.addEventListener("click", function () {
    const username = usernameInput.value.trim();

    if (!username) {
        alert("Enter a username first.");
        return;
    }

    lockedUsername = username;

    const protocol = window.location.protocol === "https:" ? "wss" : "ws";
    socket = new WebSocket(`${protocol}://${window.location.host}/ws`);

    socket.onopen = function () {
        usernameInput.disabled = true;
        connectBtn.disabled = true;
        messageInput.disabled = false;
        sendBtn.disabled = false;

        addMessage(`Connected as ${lockedUsername}`);
    };

    socket.onmessage = function (event) {
        const data = JSON.parse(event.data);
        addMessage(`${data.username}: ${data.message}`);
    };

    socket.onclose = function () {
        addMessage("Disconnected from chat.");
        messageInput.disabled = true;
        sendBtn.disabled = true;
    };
});

sendBtn.addEventListener("click", function () {
    const message = messageInput.value.trim();

    if (!message || !socket || socket.readyState !== WebSocket.OPEN) return;

    socket.send(JSON.stringify({
        username: lockedUsername,
        message: message
    }));

    messageInput.value = "";
});

messageInput.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        sendBtn.click();
    }
});