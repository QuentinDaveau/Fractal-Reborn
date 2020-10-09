extends Area2D
# Class dedicated to scan an area to find an empty space to spawn a character/item

signal spawn_position_found(spawn_position)
signal spawn_position_lost()


var _searching: bool = false


func _ready() -> void:
	randomize()


# Public call function alone to facilitate thread creation if needed. Will be removed if
# that's not the case
func find_spawn_position(spawn_area: Rect2) -> void:
	_searching = true
	_test_random_position(spawn_area)


func is_searching() -> bool:
	return _searching


# Valid area searching function
func _test_random_position(test_area: Rect2) -> void:
	var test_position: Vector2
	while(true):
		test_position.x = (randi() % int(test_area.size.x)) + test_area.position.x
		test_position.y = (randi() % int(test_area.size.y)) + test_area.position.y
		position = test_position
		yield(get_tree(), "physics_frame")
		$RayCast2D.force_raycast_update()
		if $RayCast2D.is_colliding():
			yield(get_tree(), "physics_frame")
			if get_overlapping_bodies().size() == 0:
				_searching = false
				emit_signal("spawn_position_found", test_position)
				return


func _on_SpawnFinder_body_entered(body: Node) -> void:
	if _searching:
		return
	emit_signal("spawn_position_lost")
