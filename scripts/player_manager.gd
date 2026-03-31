extends Node

const SAVE_PATH = "user://players.json"

var players: Dictionary
var current_player: String = ""
var current_player_data: Dictionary

func _ready():
	load_players()

func load_players():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var json = JSON.new()
		var err = json.parse(file.get_as_text())
		file.close()
		if err == OK:
			players = json.data
		else:
			players = {}
	else:
		players = {}

func save_players():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(players)
	file.store_string(json_string)
	file.close()

func get_player_names() -> Array:
	var names: Array = []
	for key in players.keys():
		names.append(key)
	names.sort()
	return names

func create_player(name: String):
	if name.is_empty() or players.has(name):
		return false
	players[name] = {
		"high_score": 0,
		"games_played": 0,
		"total_score": 0
	}
	save_players()
	return true

func select_player(name: String):
	current_player = name
	current_player_data = players[name]

func record_score(score: int):
	if current_player.is_empty():
		return
	if not players.has(current_player):
		return
	players[current_player]["games_played"] += 1
	players[current_player]["total_score"] += score
	if score > players[current_player]["high_score"]:
		players[current_player]["high_score"] = score
	save_players()
	current_player_data = players[current_player]

func get_leaderboard() -> Array:
	var entries: Array = []
	for name in players.keys():
		entries.append({
			"name": name,
			"high_score": players[name]["high_score"],
			"games_played": players[name]["games_played"],
			"total_score": players[name]["total_score"]
		})
	entries.sort_custom(func(a, b): return a["high_score"] > b["high_score"])
	return entries

func get_high_score() -> int:
	if current_player.is_empty() or not players.has(current_player):
		return 0
	return players[current_player]["high_score"]
