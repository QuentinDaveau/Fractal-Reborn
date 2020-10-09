extends Node


signal spawn_position_found(spawn_position)


func update_area() -> void:
	$SpawnArea.update_spawn_area()


func find_spawn_position() -> void:
	_search_new_spawn()


func _search_new_spawn() -> void:
	if $SpawnFinder.is_searching():
		return
	$SpawnFinder.find_spawn_position($SpawnArea.get_spawn_area())
	var spawn_position: Vector2 = yield($SpawnFinder, "spawn_position_found")
	emit_signal("spawn_position_found", spawn_position)


func _on_SpawnFinder_spawn_position_lost() -> void:
	_search_new_spawn()
