extends CharacterBody2D

const GRAVITY = 1200.0
const FLAP_VELOCITY = -400.0
const MAX_FALL = 600.0

var is_alive = true
var has_started = false

const BIRD_COLOR = Color(1.0, 0.85, 0.2)
const BIRD_EYE = Color(1.0, 1.0, 1.0)
const BIRD_PUPIL = Color(0.1, 0.1, 0.1)
const BIRD_BEAK = Color(1.0, 0.5, 0.2)
const BIRD_RADIUS = 20

@onready var collision = $Collision

func _ready():
	rotation = 0

func _physics_process(delta):
	if not has_started:
		return

	if is_alive:
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_FALL)

		if velocity.y < 0:
			rotation = lerp_angle(rotation, -0.5, delta * 8)
		else:
			rotation = lerp_angle(rotation, 1.2, delta * 4)

		move_and_slide()

	queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, BIRD_RADIUS, BIRD_COLOR)
	draw_circle(Vector2.ZERO, BIRD_RADIUS, BIRD_COLOR, false, 2, true)

	draw_circle(Vector2(8, -6), 6, BIRD_EYE)
	draw_circle(Vector2(10, -6), 3, BIRD_PUPIL)

	var beak_points = PackedVector2Array([
		Vector2(14, -2),
		Vector2(26, 2),
		Vector2(14, 6)
	])
	draw_colored_polygon(beak_points, BIRD_BEAK)

func flap():
	if not is_alive or not has_started:
		return
	velocity.y = FLAP_VELOCITY
	SoundManager.play_flap()

func start():
	has_started = true

func die():
	is_alive = false
	collision.set_deferred("disabled", true)

func reset():
	velocity = Vector2.ZERO
	rotation = 0
	is_alive = true
	has_started = false
	collision.disabled = false
	position = Vector2(150, 400)
	queue_redraw()
