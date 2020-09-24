extends Node


var _game_camera: Camera2D


func _ready() -> void:
	_game_camera = _find_camera(get_tree().get_root())
	# assert(_game_camera != null)


func get_camera() -> Camera2D:
	return _game_camera


func _find_camera(parent_node: Node) -> Camera2D:
	for children in parent_node.get_children():
		if children.get_name() == "GameCamera":
			return children
		else:
			var camera := _find_camera(children)
			if camera:
				return camera
	return null

