extends Node2D

signal pipe_passed
signal bird_hit

const PIPE_SCENE = preload("res://scenes/Pipe.tscn")
const SPAWN_INTERVAL = 1.8
const MIN_GAP_CENTER = 180
const MAX_GAP_CENTER = 550

var spawn_timer = 0.0
var game_active = false

func _ready():
	pass

func start():
	game_active = true
	spawn_timer = SPAWN_INTERVAL

func stop():
	game_active = false

func reset():
	game_active = false
	spawn_timer = 0
	for child in get_children():
		if child is Area2D:
			child.queue_free()

func _physics_process(delta):
	if not game_active:
		return

	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_pipe()
		spawn_timer = SPAWN_INTERVAL

	var to_remove: Array = []
	for child in get_children():
		if child is Area2D and child.has_method("is_off_screen"):
			if child.is_off_screen():
				to_remove.append(child)
	for child in to_remove:
		child.queue_free()

func spawn_pipe():
	var pipe = PIPE_SCENE.instantiate()
	var gap_center = randf_range(MIN_GAP_CENTER, MAX_GAP_CENTER)
	pipe.position = Vector2(get_viewport_rect().size.x + 100, 0)
	pipe.gap_center = gap_center
	pipe.speed = 300.0
	pipe.body_entered.connect(_on_pipe_body_entered)
	add_child(pipe)

func _on_pipe_body_entered(body):
	if body.is_in_group("bird"):
		bird_hit.emit()

func check_pipe_passed(bird_x: float):
	for child in get_children():
		if child is Area2D and not child.passed and child.has_method("is_off_screen"):
			if child.position.x < bird_x:
				child.passed = true
				pipe_passed.emit()
				return
