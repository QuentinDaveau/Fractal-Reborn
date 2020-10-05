extends Area2D


func update_bounds() -> void:
	position = CameraManager.get_camera().global_position


func _on_ArenaBound_body_entered(body: Node) -> void:
	if is_instance_valid(body):
		body.log_and_free()
