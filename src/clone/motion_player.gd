extends Node

# Follow the path given by the MotionPredictor

var _path: Curve2D
var _time_curve: Curve
var _total_time: float
var _current_time: int = 0

var _enabled: bool = false


func setup(logs: Array) -> void:
	if not logs:
		return
	_total_time = float(logs[-1][0]) / 1000.0
	var path_data = $MotionPredictor.predict_path(logs)
	_path = path_data["curve"]
	if not _path:
		printerr("Issue with path generation!")
	_time_curve = $TimeCurveGenerator.generate_time_curve(path_data["time_length_list"])
	_enabled = true


func _ready() -> void:
	if not _enabled:
		return
	$Tween.interpolate_method(self, "update_position", 0, 1, _total_time, Tween.TRANS_LINEAR)
	$Tween.start()


func update_position(replay_amount: float) -> void:
	owner.global_position = _path.interpolate_baked(_time_curve.interpolate_baked(replay_amount), true)
#	owner.global_position = _path.interpolatef(replay_amount * _path.get_point_count())
