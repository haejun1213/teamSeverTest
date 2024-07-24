<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Randomizer</title>
<style>
    .player-input {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
    }
    .player-input label {
        width: 100px;
        text-align: right;
        margin-right: 8px;
    }
    .team-select {
        margin-left: 10px;
    }
    #savedNamesList li {
        display: flex;
        align-items: center;
        margin-bottom: 8px;
    }
    #savedNamesList button {
        margin-left: 8px;
    }
</style>
<script>
function saveName() {
    let playerName = document.getElementById("newPlayer").value;
    if (playerName) {
        let storedNames = JSON.parse(localStorage.getItem("playerNames")) || [];
        storedNames.push(playerName);
        localStorage.setItem("playerNames", JSON.stringify(storedNames));
        document.getElementById("newPlayer").value = "";
        loadSavedNames();
    }
}

function loadSavedNames() {
    let storedNames = JSON.parse(localStorage.getItem("playerNames")) || [];
    let savedNamesList = document.getElementById("savedNamesList");
    savedNamesList.innerHTML = "";
    storedNames.forEach((name, index) => {
        let listItem = document.createElement("li");
        listItem.textContent = name;

        let deleteButton = document.createElement("button");
        deleteButton.textContent = "Delete";
        deleteButton.onclick = () => {
            storedNames.splice(index, 1);
            localStorage.setItem("playerNames", JSON.stringify(storedNames));
            loadSavedNames();
        };

        let addButton = document.createElement("button");
        addButton.textContent = "Add";
        addButton.onclick = () => {
            let playerInputs = document.querySelectorAll('input[name="players"]');
            for (let input of playerInputs) {
                if (!input.value) {
                    input.value = name;
                    break;
                }
            }
        };

        listItem.appendChild(addButton);
        listItem.appendChild(deleteButton);
        savedNamesList.appendChild(listItem);
    });
}

function addAllPlayers() {
    let storedNames = JSON.parse(localStorage.getItem("playerNames")) || [];
    let playerInputs = document.querySelectorAll('input[name="players"]');
    let inputIndex = 0;

    for (let name of storedNames) {
        while (inputIndex < playerInputs.length && playerInputs[inputIndex].value) {
            inputIndex++;
        }
        if (inputIndex < playerInputs.length) {
            playerInputs[inputIndex].value = name;
        } else {
            break;
        }
    }
}

function handleKeyPress(event) {
    if (event.key === 'Enter') {
        saveName();
        event.preventDefault();
    }
}

window.onload = loadSavedNames;
</script>
</head>
<body>
    <h1>Enter 10 Player Names</h1>
    <form action="result.jsp" method="post">
        <% for (int i = 1; i <= 10; i++) { %>
            <div class="player-input">
                <label for="player<%= i %>">Player <%= i %>:</label>
                <input type="text" id="player<%= i %>" name="players" required>
                <select id="team<%= i %>" name="teams" class="team-select" required>
                    <option value="0">Random</option>
                    <option value="1">Team 1</option>
                    <option value="2">Team 2</option>
                </select>
            </div>
        <% } %>
        <input type="submit" value="Randomize Teams">
    </form>
    <h2>Save a New Player Name</h2>
    <input type="text" id="newPlayer" placeholder="Enter player name" onkeypress="handleKeyPress(event)">
    <button type="button" onclick="saveName()">플레이어 저장</button>
    <h2>Saved Player Names</h2>
    <button type="button" onclick="addAllPlayers()">전체 추가</button>
    <ul id="savedNamesList"></ul>
</body>
</html>
