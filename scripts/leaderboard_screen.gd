extends CanvasLayer

var came_from_game = false

@onready var leaderboard_list = $Panel/ScrollContainer/VBoxContainer
@onready var back_button = $Panel/BackButton

func _ready():
	back_button.pressed.connect(_on_back)
	_populate_leaderboard()

func _populate_leaderboard():
	for child in leaderboard_list.get_children():
		child.queue_free()

	var leaderboard = PlayerManager.get_leaderboard()

	if leaderboard.is_empty():
		var label = Label.new()
		label.text = "No players yet!"
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 28)
		leaderboard_list.add_child(label)
		return

	var header = HBoxContainer.new()
	header.add_child(_make_label("Rank", 80, 28))
	header.add_child(_make_label("Name", 160, 28))
	header.add_child(_make_label("Best", 80, 28))
	header.add_child(_make_label("Games", 80, 28))
	leaderboard_list.add_child(header)

	var separator = HSeparator.new()
	leaderboard_list.add_child(separator)

	for i in range(leaderboard.size()):
		var entry = leaderboard[i]
		var row = HBoxContainer.new()

		var rank_text = ""
		if i == 0:
			rank_text = "1st"
		elif i == 1:
			rank_text = "2nd"
		elif i == 2:
			rank_text = "3rd"
		else:
			rank_text = str(i + 1) + "th"

		row.add_child(_make_label(rank_text, 80, 24))
		row.add_child(_make_label(entry["name"], 160, 24))
		row.add_child(_make_label(str(entry["high_score"]), 80, 24))
		row.add_child(_make_label(str(entry["games_played"]), 80, 24))

		leaderboard_list.add_child(row)

func _make_label(text: String, min_width: int, font_size: int) -> Label:
	var label = Label.new()
	label.text = text
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("font_size", font_size)
	label.custom_minimum_size = Vector2(min_width, 40)
	return label

func _on_back():
	SoundManager.play_ui()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
