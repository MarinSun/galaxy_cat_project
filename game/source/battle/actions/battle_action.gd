extends Node
class_name BattleAction

var initialized = false

onready var actor: Fighter = get_parent().get_owner()

export (Texture) var icon = load("res://assets/combat/action_frame.png")
export (String) var description = "Action"

func initialize(fighter: Fighter) -> void:
	actor = fighter
	initialized = true

func execute(targets: Array):
	assert(initialized)
	print("%s missing overwrite of the execute method" % name)
	return false

func can_use() -> bool:
	return true
