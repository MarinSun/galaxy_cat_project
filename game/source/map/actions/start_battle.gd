extends MapAction
class_name MapActionBattle

export var group: PackedScene

func interact() -> void:
	get_tree().paused = false
	map.start_encounter(group)
	emit_signal("finished")
