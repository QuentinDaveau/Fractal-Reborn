extends Node2D

var CURVE: = Curve2D.new()
var _delay: float = 0.2


func _process(delta: float) -> void:
	CURVE = Curve2D.new()
	var logs = get_parent()._logs
	for i in range(0, logs.size() - 1):
		var tang = logs[i + 1][1] - logs[i - 1][1]
		var left_angle_ratio = abs(tang.tangent().angle_to(logs[i - 1][1] - logs[i][1]) / PI) / 2
		var right_angle_ratio = abs(tang.tangent().angle_to(logs[i + 1][1] - logs[i][1]) / PI) / 2
		CURVE.add_point(logs[i][1], - tang * left_angle_ratio, tang * right_angle_ratio)
	_delay -= delta
	if _delay <= 0:
		update()
		_delay = 0.2


func _draw():
	draw_polyline(CURVE.get_baked_points(), Color.green, 4.0)
