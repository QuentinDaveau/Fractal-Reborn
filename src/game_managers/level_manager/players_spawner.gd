extends Node

signal players_spawned()


func spawn_players(level: Node, spawn_manager: Node) -> void:
	get_tree().paused = true
	var spawn_positions := []
	for i in range(1):
		spawn_manager.find_spawn_position()
		spawn_positions.append(yield(spawn_manager, "spawn_position_found"))
	ReplayClock.reset_timer()
	for p in spawn_positions:
		var player: Replayable = Warehouse.get_resource("Character").instance()
		player.global_position = p
		player.prepare_and_spawn(level.get_entities_container(), Warehouse.get_resource("CharacterClone"))
	get_tree().paused = false
	emit_signal("players_spawned")
