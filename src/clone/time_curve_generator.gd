extends Node


var _time_curve: Curve = Curve.new()


func generate_time_curve(time_length_list: Array) -> Curve:
	var total_time: float = time_length_list[-1][0]
	_time_curve.max_value = time_length_list[-1][1]
	for l in time_length_list:
		_time_curve.add_point(Vector2(float(l[0])/total_time, l[1]))
	# DEBUG
	if has_node("CurveDebugger"):
		$CurveDebugger.draw_curve(_time_curve)
	return _time_curve
