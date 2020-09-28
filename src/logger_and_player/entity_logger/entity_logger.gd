extends Node
# Node dedicated to log the entity actions and movements to setup an animation
# that will be used for the replay

# DEBUG
export(String, FILE, "*.tscn") var _clone_path

var _log: Animation = Animation.new()

var _logged_properties: Array = []
var _logged_methods_sources: Array = []
var _clone: Resource
var _stop_log: bool = false


# Returns the Entity being logged
func get_entity() -> Node:
	return $Entity.get_child(0)


# Sets the entity to log
func set_entity(entity: Node, clone: Resource) -> void:
	_clone = clone
	entity.connect("tree_exiting", self, "_on_entity_free", [], CONNECT_ONESHOT)
	$MotionLogger.setup(entity)
	$Entity.add_child(entity)


# Logs a given property as an animation track. Creates the tracks if it is a new property
func log_property(source: Node, property: String, value) -> void:
	if _stop_log:
		return
	var track_id: int
	var full_path: String = $Entity.get_path_to(source) as String + ":" + property
	if not _logged_properties.has(full_path):
		_logged_properties.append(full_path)
		track_id = _log.add_track(Animation.TYPE_VALUE)
		_log.track_set_interpolation_type(track_id, Animation.INTERPOLATION_CUBIC)
		_log.track_set_path(track_id, full_path)
	else:
		track_id = _logged_properties.find(full_path)
	_log.track_insert_key(track_id, ReplayClock.get_run_time(), value)


# Logs a given method in a method track dedicated to the source
func log_method(source: Node, method: String, args: Array = [], execute: bool = false) -> void:
	if _stop_log:
		return
	var track_id := _get_method_track($Entity.get_path_to(source))
	_log.track_insert_key(track_id, ReplayClock.get_run_time(), {"method" : method , "args" : args})
	if method == "queue_free":
		$MotionLogger._take_snap()
	if execute:
		if args.size() > 0:
			source.call(method, args)
		else:
			source.call(method)


# Returns the log and set the animation duration
func get_log_data() -> Dictionary:
	if not _clone and _clone_path:
		_clone = load(_clone_path)
	_log.length = ReplayClock.get_run_time()
#	ResourceSaver.save("res://_log.tres", _log)
	return {"clone": _clone, "log": _log}


func _get_method_track(track_path: String) -> int:
	var track_id: int
	if not _logged_properties.has(track_path):
		_logged_properties.append(track_path)
		track_id = _log.add_track(Animation.TYPE_METHOD)
		_log.track_set_path(track_id, track_path)
	else:
		track_id = _logged_properties.find(track_path)
	return track_id


func _on_entity_free() -> void:
	_stop_log = true
