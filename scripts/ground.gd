extends Node2D

var scroll_offset = 0.0
var speed = 300.0
var active = false

const GROUND_HEIGHT = 120
const GROUND_COLOR = Color(0.6, 0.4, 0.2)
const GRASS_COLOR = Color(0.3, 0.7, 0.2)
const TILE_WIDTH = 40

func _ready():
	position.y = get_viewport_rect().size.y - GROUND_HEIGHT

func start():
	active = true

func stop():
	active = false

func reset():
	scroll_offset = 0
	active = false
	position.y = get_viewport_rect().size.y - GROUND_HEIGHT

func _physics_process(delta):
	if active:
		scroll_offset = fmod(scroll_offset + speed * delta, TILE_WIDTH)

func _draw():
	var w = get_viewport_rect().size.x + TILE_WIDTH * 2
	var h = GROUND_HEIGHT

	draw_rect(Rect2(-TILE_WIDTH, 0, w, 12), GRASS_COLOR)
	draw_rect(Rect2(-TILE_WIDTH, 12, w, h - 12), GROUND_COLOR)

	for x in range(-TILE_WIDTH, int(w), TILE_WIDTH):
		var offset_x = x - fmod(scroll_offset, TILE_WIDTH)
		draw_line(Vector2(offset_x, 12), Vector2(offset_x, h), Color(0.5, 0.3, 0.15), 2)
	for y in range(24, h, 24):
		draw_line(Vector2(-TILE_WIDTH, y), Vector2(w - TILE_WIDTH, y), Color(0.5, 0.3, 0.15), 2)
