<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Randomizer Result</title>
</head>
<body>
    <h1>Team Randomizer Result</h1>
    <h2>Team 1</h2>
    <ul>
        <% 
        String[] players = request.getParameterValues("players");
        String[] teams = request.getParameterValues("teams");
        
        // Define team lists and unassigned players list
        java.util.List<String> team1 = new java.util.ArrayList<>();
        java.util.List<String> team2 = new java.util.ArrayList<>();
        java.util.List<String> unassignedPlayers = new java.util.ArrayList<>();

        if (players != null && teams != null) {
            // Assign players to specified teams and collect unassigned players
            for (int i = 0; i < players.length; i++) {
                String player = players[i];
                String team = teams[i];
                if ("1".equals(team)) {
                    team1.add(player);
                } else if ("2".equals(team)) {
                    team2.add(player);
                } else {
                    unassignedPlayers.add(player);
                }
            }

            // Randomly assign unassigned players to Team 1 or Team 2
            java.util.Collections.shuffle(unassignedPlayers);
            int halfSize = unassignedPlayers.size() / 2;
            for (int i = 0; i < unassignedPlayers.size(); i++) {
                if (i < halfSize) {
                    team1.add(unassignedPlayers.get(i));
                } else {
                    team2.add(unassignedPlayers.get(i));
                }
            }

            // Display Team 1
            for (String player : team1) {
                %><li><%= player %></li><%
            }
        }
        %>
    </ul>

    <h2>Team 2</h2>
    <ul>
        <% 
        // Display Team 2
        if (players != null && teams != null) {
            for (String player : team2) {
                %><li><%= player %></li><%
            }
        }
        %>
    </ul>
    <a href="index.jsp">Randomize Again</a>
</body>
</html>
