extends Node2D

var CURVE: Curve2D = Curve2D.new()
var _logs: Array = []


func add_point(point: Vector2) -> void:
	return
	_logs.append(point)
	CURVE.clear_points()
	for i in range(1, _logs.size() - 1):
		var tang = _logs[i + 1] - _logs[i - 1]
		var left_angle_ratio = abs(tang.tangent().angle_to(_logs[i - 1] - _logs[i]) / PI) / 4
		var right_angle_ratio = abs(tang.tangent().angle_to(_logs[i + 1] - _logs[i]) / PI) / 4
		CURVE.add_point(_logs[i], - tang * left_angle_ratio, tang * right_angle_ratio)
	update()


func _draw():
	if CURVE.get_baked_length() < 2:
		return
	draw_polyline(CURVE.get_baked_points(), Color.green, 4.0)
