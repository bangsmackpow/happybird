extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var pause_button = $PauseButton

func _ready():
	pause_button.pressed.connect(_on_pause)

func update_score(score: int):
	score_label.text = str(score)

func _on_pause():
	SoundManager.play_ui()
	get_tree().paused = not get_tree().paused
	pause_button.text = "||" if not get_tree().paused else "▶"
