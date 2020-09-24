extends Node2D


func _process(delta: float) -> void:
	update()


func _draw():
	for l in get_parent()._logs:
		draw_line(l[1], l[1] + (l[2]/10), Color.red)
