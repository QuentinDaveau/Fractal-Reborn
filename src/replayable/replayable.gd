extends KinematicBody2D
class_name Replayable

var LOGGER: Node

var _is_replay: bool = false


func _ready() -> void:
	if _is_replay:
		set_physics_process(false)


func prepare_and_spawn(node_to_child: Node, clone_pack: Resource) -> void:
	LOGGER = Warehouse.get_resource("Logger").instance()
	LOGGER.set_entity(self, clone_pack)
	node_to_child.add_child(LOGGER)


func enable_replay() -> void:
	_is_replay = true
	set_sync_to_physics(true)
	collision_layer = 16
	collision_mask = 0


func log_and_free() -> void:
	LOGGER.log_method(self, "queue_free", [], true)
	queue_free()
