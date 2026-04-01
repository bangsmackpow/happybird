extends Area2D

var speed = 300.0
var passed = false
var gap_center = 400.0

const PIPE_WIDTH = 80
const GAP_SIZE = 220
const PIPE_COLOR = Color(0.2, 0.7, 0.2)
const PIPE_DARK = Color(0.15, 0.55, 0.15)
const PIPE_HIGHLIGHT = Color(0.3, 0.8, 0.3)
const CAP_HEIGHT = 30
const CAP_OVERHANG = 8

func _ready():
	pass

func _physics_process(delta):
	position.x -= speed * delta
	queue_redraw()

func _draw():
	var viewport_height = get_viewport_rect().size.y
	var half_w = PIPE_WIDTH / 2
	var cap_half = (PIPE_WIDTH + CAP_OVERHANG * 2) / 2

	var top_pipe_bottom = gap_center - GAP_SIZE / 2
	var bottom_pipe_top = gap_center + GAP_SIZE / 2

	draw_rect(Rect2(-half_w, -viewport_height, PIPE_WIDTH, viewport_height + top_pipe_bottom), PIPE_COLOR)
	draw_rect(Rect2(-half_w + 4, -viewport_height, PIPE_WIDTH - 8, viewport_height + top_pipe_bottom), PIPE_HIGHLIGHT)

	draw_rect(Rect2(-half_w, bottom_pipe_top, PIPE_WIDTH, viewport_height), PIPE_COLOR)
	draw_rect(Rect2(-half_w + 4, bottom_pipe_top, PIPE_WIDTH - 8, viewport_height), PIPE_HIGHLIGHT)

	draw_rect(Rect2(-cap_half, top_pipe_bottom - CAP_HEIGHT, PIPE_WIDTH + CAP_OVERHANG * 2, CAP_HEIGHT), PIPE_COLOR)
	draw_rect(Rect2(-cap_half + 3, top_pipe_bottom - CAP_HEIGHT + 3, PIPE_WIDTH + CAP_OVERHANG * 2 - 6, CAP_HEIGHT - 6), PIPE_HIGHLIGHT)
	draw_rect(Rect2(-cap_half, top_pipe_bottom - CAP_HEIGHT, PIPE_WIDTH + CAP_OVERHANG * 2, CAP_HEIGHT), PIPE_DARK)

	draw_rect(Rect2(-cap_half, bottom_pipe_top, PIPE_WIDTH + CAP_OVERHANG * 2, CAP_HEIGHT), PIPE_COLOR)
	draw_rect(Rect2(-cap_half + 3, bottom_pipe_top + 3, PIPE_WIDTH + CAP_OVERHANG * 2 - 6, CAP_HEIGHT - 6), PIPE_HIGHLIGHT)
	draw_rect(Rect2(-cap_half, bottom_pipe_top, PIPE_WIDTH + CAP_OVERHANG * 2, CAP_HEIGHT), PIPE_DARK)

func is_off_screen() -> bool:
	return position.x < -(PIPE_WIDTH + CAP_OVERHANG * 2)
