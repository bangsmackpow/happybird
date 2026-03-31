extends CanvasLayer

@onready var score_label = $Panel/ScoreLabel
@onready var best_label = $Panel/BestLabel
@onready var retry_button = $Panel/RetryButton
@onready var leaderboard_button = $Panel/LeaderboardButton
@onready var home_button = $Panel/HomeButton

func _ready():
	retry_button.pressed.connect(_on_retry)
	leaderboard_button.pressed.connect(_on_leaderboard)
	home_button.pressed.connect(_on_home)

func set_score(score: int):
	score_label.text = "Score: " + str(score)

func set_best_score(best: int):
	best_label.text = "Best: " + str(best)

func _on_retry():
	SoundManager.play_ui()
	get_parent().start_game()

func _on_leaderboard():
	SoundManager.play_ui()
	get_tree().change_scene_to_file("res://scenes/LeaderboardScreen.tscn")

func _on_home():
	SoundManager.play_ui()
	get_parent().go_to_menu()
