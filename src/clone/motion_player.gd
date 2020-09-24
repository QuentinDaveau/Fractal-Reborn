extends Node

# Follow the path given by the MotionPredictor

var _path: Curve2D
var _time_curve: Curve
var _total_time: int
var _current_time: int = 0


func setup(logs: Array) -> void:
	_total_time = logs[-1][0] / 1000.0
	print(_total_time)
	_path = $MotionPredictor.predict_path(logs)
	if not _path:
		printerr("Issue with path generation!")
	_time_curve = $TimeCurveGenerator.generate_time_curve(logs)


func _ready() -> void:
	$Tween.interpolate_method(self, "update_position", 0, 1, _total_time, Tween.TRANS_LINEAR)
	$Tween.start()


func update_position(replay_amount: float) -> void:
	print(_time_curve.interpolate(replay_amount) * _path.get_point_count())
	owner.global_position = _path.interpolatef(_time_curve.interpolate(replay_amount) * _path.get_point_count())
#	owner.global_position = _path.interpolatef(replay_amount * _path.get_point_count())
