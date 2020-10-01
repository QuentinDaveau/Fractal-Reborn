extends Node


func convert_to_player(logger: Node, zoom_level: float) -> Node:
	var l = logger.get_log_data()
	var clone: Resource
	if l.has("clone") and l["clone"]:
		clone = l["clone"]
	else:
		clone = Warehouse.get_resource("CharacterClone")
	var entity_player = Warehouse.get_resource("Player").instance()
	entity_player.setup(l["log"], clone, zoom_level)
#		clone.setup(e)
#		_active_map.add_child(clone)
	logger.get_parent().add_child(entity_player)
	logger.queue_free()
	return entity_player
