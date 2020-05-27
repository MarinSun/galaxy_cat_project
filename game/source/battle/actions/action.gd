extends Node
class_name Action

var initialized = false
onready var actor: Fighter = get_parent().get_owner()

export (int) var cost = 1
export (Texture) var icon = load("res://assets/battle_ui/icons/core_attack.png")
export (String) var description = "This is a description of a skill."
export (int, "Self", "Single Enemy", "All Enemies", "Single Ally", "All Allies") var target = 1

func initialize(fighter: Fighter) -> void:
	actor = fighter
	initialized = true

func execute(targets: Array):
	assert(initialized)
	print("%s execute is not overridden" % name)
	return false

func return_to_start_position():
	yield(actor.skin.return_to_start(actor.starting_position), "completed")

func can_use() -> bool:
	return true
