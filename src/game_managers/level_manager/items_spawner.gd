extends Node

const MIN_DELAY: float = 4.0
const MAX_DELAY: float = 8.0

export(NodePath) var _spawn_manager_path: NodePath

onready var _spawn_manager: Node = get_node(_spawn_manager_path)


func start_spawn() -> void:
	$Timer.start(rand_range(MIN_DELAY, MAX_DELAY))


func stop_spawn() -> void:
	$Timer.stop()


func _on_Timer_timeout() -> void:
	_spawn_manager.find_spawn_position()
	var _spawn_position = yield(_spawn_manager, "spawn_position_found")
	var gun_resource: Resource = Warehouse.get_resource("Gun")
	var gun: Replayable = gun_resource.instance()
	gun.position = _spawn_position
	gun.prepare_and_spawn(owner._actif_level, gun_resource)
	$Timer.start(rand_range(MIN_DELAY, MAX_DELAY))
