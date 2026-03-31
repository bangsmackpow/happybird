extends Node2D

var cloud_offsets = []

func _ready():
	for i in range(5):
		cloud_offsets.append(Vector2(randf() * 600, randf() * 300))

func _draw():
	var w = get_viewport_rect().size.x
	var h = get_viewport_rect().size.y - 120

	for i in range(cloud_offsets.size()):
		var pos = cloud_offsets[i]
		_draw_cloud(pos, 0.6 + i * 0.1)

func _draw_cloud(pos: Vector2, alpha: float):
	var cloud_color = Color(1, 1, 1, alpha * 0.5)
	draw_circle(pos, 30, cloud_color)
	draw_circle(pos + Vector2(25, -10), 25, cloud_color)
	draw_circle(pos + Vector2(50, 0), 35, cloud_color)
	draw_circle(pos + Vector2(25, 10), 20, cloud_color)
	draw_circle(pos + Vector2(70, 5), 22, cloud_color)
