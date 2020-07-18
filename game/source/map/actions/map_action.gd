extends Node
class_name MapAction

signal finished

var map
var active: bool = true

func _ready() -> void:
	add_to_group("map_action")

func initialize(_map):
	map = _map

func interact() -> void:
	print("Method isn't overridden.")
	emit_signal("finished")
