extends Node
class_name Action

var initialized = false
onready var actor: Fighter = get_parent().get_owner()

export (Texture) var icon = load("res://assets/battle_ui/icons/core_attack.png")
export (String) var description = "This is a description of a skill."
export (int, "Self", "Single", "Multiple") var target = 1

func initialize(fighter: Fighter) -> void:
	actor = fighter
	initialized = true

func execute(targets: Array):
	assert(initialized)
	print("%s execute is not overridden" % name)
	return false

func return_to_start_position():
	pass

func can_use() -> bool:
	return true
