extends Control

@onready var title_label = $Title
@onready var player_list = $Panel/ScrollContainer/VBoxContainer
@onready var new_player_input = $Panel/NewPlayerContainer/LineEdit
@onready var new_player_button = $Panel/NewPlayerContainer/AddButton
@onready var start_button = $StartButton

func _ready():
	new_player_button.pressed.connect(_on_add_player)
	start_button.pressed.connect(_on_start)
	start_button.disabled = true
	_populate_players()

func _populate_players():
	for child in player_list.get_children():
		if child is Button:
			child.queue_free()

	var names = PlayerManager.get_player_names()

	if names.is_empty():
		var label = Label.new()
		label.text = "Add a player below to start!"
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.add_theme_font_size_override("font_size", 24)
		player_list.add_child(label)
	else:
		for name in names:
			var btn = Button.new()
			btn.text = name
			btn.add_theme_font_size_override("font_size", 28)
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.custom_minimum_size = Vector2(0, 60)
			btn.pressed.connect(_on_player_selected.bind(name))
			player_list.add_child(btn)

func _on_player_selected(name: String):
	SoundManager.play_ui()
	PlayerManager.select_player(name)
	start_button.disabled = false
	start_button.text = "Play as " + name

func _on_add_player():
	var name = new_player_input.text.strip_edges()
	if name.is_empty():
		return
	if PlayerManager.create_player(name):
		SoundManager.play_ui()
		new_player_input.text = ""
		_populate_players()
	else:
		new_player_input.text = ""

func _on_start():
	SoundManager.play_ui()
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
