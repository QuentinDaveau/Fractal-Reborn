extends Node
# Node dedicated to log the entity actions and movements to setup an animation
# that will be used for the replay

var _log: Animation = Animation.new()

var _logged_properties: Array = []
var _logged_methods_sources: Array = []


# Returns the Entity being logged
func get_entity() -> Node:
	return $Entity.get_child(0)


# Sets the entity to log
func set_entity(entity: Node) -> void:
	$Entity.add_child(entity)


# Logs a given property as an animation track. Creates the tracks if it is a new property
func log_property(source: Node, property: String, value) -> void:
	var track_id: int
	var full_path: String = get_path_to(source) as String + ":" + property
	if not _logged_properties.has(full_path):
		_logged_properties.append(full_path)
		track_id = _log.add_track(Animation.TYPE_VALUE)
		_log.track_set_interpolation_type(track_id, Animation.INTERPOLATION_CUBIC)
		_log.track_set_path(track_id, full_path)
	else:
		track_id = _logged_properties.find(full_path)
	_log.track_insert_key(track_id, ReplayClock.get_run_time(), value)


# Logs a given method in a method track dedicated to the source
func log_method(source: String, method: String, params: Array = [], execute: bool = false) -> void:
	pass


# Returns the log and set the animation duration
func get_log() -> Animation:
	_log.length = ReplayClock.get_run_time()
#	ResourceSaver.save("res://_log.tres", _log)
	return _log
