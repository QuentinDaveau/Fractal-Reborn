extends Node


onready var _logger = load("res://src/logger_and_player/entity_logger/EntityLogger.tscn")

func get_logger() -> Resource:
	return _logger
