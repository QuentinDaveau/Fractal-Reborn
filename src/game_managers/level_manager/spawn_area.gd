extends Node2D


var _spawn_area: Rect2


func update_spawn_area() -> void:
	_spawn_area = Rect2(CameraManager.get_camera().global_position - Vector2(825, 425)
			, Vector2(825, 425) * 2)
	update()


func get_spawn_area() -> Rect2:
	return _spawn_area


func _draw() -> void:
	draw_rect(_spawn_area, Color.red, false)
