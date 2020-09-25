extends Node


var _start_time: int = 0


func reset_timer() -> void:
	_start_time = OS.get_ticks_msec()


func get_run_time() -> float:
	return float(OS.get_ticks_msec() - _start_time) / 1000.0
