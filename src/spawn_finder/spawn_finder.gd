extends Area2D


func find_spawn_position() -> Vector2:
	var camera_position = CameraManager.get_camera().get_camera_position()
	var screen_size = get_viewport().size
	var area_extents = $CollisionShape2D.get_shape().extents
	randomize()
	randi() % (screen_size - (area_extents.x * 2))
	return Vector2.ZERO
