extends Node

# Predicts the path the clone will have to follow using a bezier curve

var _curve: Curve2D = Curve2D.new()


func predict_path(logs: Array) -> Curve2D:
	for i in range(1, logs.size() - 1):
		var tang = logs[i + 1][1] - logs[i - 1][1]
		var left_angle_ratio = abs(tang.tangent().angle_to(logs[i - 1][1] - logs[i][1]) / PI) / 4
		var right_angle_ratio = abs(tang.tangent().angle_to(logs[i + 1][1] - logs[i][1]) / PI) / 4
		_curve.add_point(logs[i][1], - tang * left_angle_ratio, tang * right_angle_ratio)
	# DEBUG
	if has_node("MotionPredictorDebugger"):
		$MotionPredictorDebugger.set_path(_curve)
	return _curve
