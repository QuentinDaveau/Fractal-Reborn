extends Node


var _time_curve: Curve = Curve.new()


func generate_time_curve(logs: Array) -> Curve:
	var total_time: float = logs[-1][0]
	var points_count = logs.size()
	_time_curve.min_value = 0
	_time_curve.max_value = total_time
	var i := 1.0
	for l in logs:
		print(Vector2(i/points_count, l[0]/total_time), "   ", Vector2(i/points_count, l[0]/total_time).reflect(Vector2(-1, -1).normalized()))
		_time_curve.add_point(Vector2(i/points_count, (2 * (i/points_count)) - (l[0]/total_time)))
		i += 1
	_time_curve.bake()
	# DEBUG
	$CurveDebugger.draw_curve(_time_curve)
	return _time_curve
