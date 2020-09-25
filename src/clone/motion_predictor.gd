extends Node

# Predicts the path the clone will have to follow using a bezier curve

var _curve: Curve2D = Curve2D.new()
var _time_length_list: Array = []


func predict_path(logs: Array) -> Dictionary:
	_curve.add_point(logs[0][1])
	_time_length_list.append([logs[0][0], _curve.get_baked_length()])
	for i in range(1, logs.size() - 1):
		var tang = logs[i + 1][1] - logs[i - 1][1]
		var left_angle_ratio = abs(tang.tangent().angle_to(logs[i - 1][1] - logs[i][1]) / PI) / 4
		var right_angle_ratio = abs(tang.tangent().angle_to(logs[i + 1][1] - logs[i][1]) / PI) / 4
		_curve.add_point(logs[i][1], - tang * left_angle_ratio, tang * right_angle_ratio)
		_time_length_list.append([logs[i][0], _curve.get_baked_length()])
	_curve.add_point(logs[-1][1])
	_time_length_list.append([logs[-1][0], _curve.get_baked_length()])
		# DEBUG
	if has_node("MotionPredictorDebugger"):
		$MotionPredictorDebugger.set_path(_curve)
	return {"curve": _curve, "time_length_list": _time_length_list}
