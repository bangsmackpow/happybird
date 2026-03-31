extends Node2D

enum GameState { MENU, PLAYING, GAME_OVER }

var state = GameState.PLAYING
var score = 0

@onready var bird = $Bird
@onready var pipe_manager = $PipeManager
@onready var ground = $Ground
@onready var hud = $HUD
@onready var game_over_screen = $GameOverScreen
@onready var tap_to_start = $TapToStart

func _ready():
	bird.reset()
	ground.reset()
	pipe_manager.reset()
	hud.hide()
	game_over_screen.hide()
	tap_to_start.hide()
	state = GameState.PLAYING
	pipe_manager.pipe_passed.connect(on_pipe_passed)
	pipe_manager.bird_hit.connect(on_bird_died)

func _unhandled_input(event):
	if state == GameState.PLAYING:
		if event is InputEventScreenTouch and event.pressed:
			bird.flap()
			get_viewport().set_input_as_handled()

func _physics_process(delta):
	if state != GameState.PLAYING:
		return

	var ground_y = get_viewport_rect().size.y - ground.GROUND_HEIGHT
	if bird.position.y > ground_y - 20:
		bird.position.y = ground_y - 20
		on_bird_died()
	if bird.position.y < 0:
		bird.position.y = 0
		bird.velocity.y = 0

	pipe_manager.check_pipe_passed(bird.position.x)

func on_pipe_passed():
	score += 1
	hud.update_score(score)
	SoundManager.play_score()

func on_bird_died():
	if state != GameState.PLAYING:
		return
	state = GameState.GAME_OVER
	bird.die()
	pipe_manager.stop()
	ground.stop()
	SoundManager.play_death()
	PlayerManager.record_score(score)
	get_tree().create_timer(0.5).timeout.connect(show_game_over)

func show_game_over():
	game_over_screen.show()
	game_over_screen.set_score(score)
	game_over_screen.set_best_score(PlayerManager.get_high_score())
	hud.hide()

func go_to_menu():
	state = GameState.PLAYING
	bird.reset()
	pipe_manager.reset()
	ground.reset()
	hud.hide()
	game_over_screen.hide()
	get_tree().change_scene_to_file("res://scenes/PlayerSelectScreen.tscn")
