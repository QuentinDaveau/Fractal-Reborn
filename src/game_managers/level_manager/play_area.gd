extends Node2D


func update_area() -> void:
	$SpawnArea.update_spawn_area()
	$ArenaBound.update_bounds()
