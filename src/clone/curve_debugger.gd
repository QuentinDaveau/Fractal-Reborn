extends Node2D


#var _curve: Curve
#
#
#func draw_curve(curve: Curve) -> void:
#	_curve = curve
#	update()
#
#
#func _draw() -> void:
#	for i in _curve.get_point_count():
#		draw_circle(Vector2(i*5, _curve.interpolate_baked(float(i)/_curve.get_point_count())/10), 2, Color.blue)
