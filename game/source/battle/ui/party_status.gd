extends Control

onready var list = $list

var character_status = preload("res://source/battle/ui/status/character_info.tscn")

func initialize(fighters: Array) -> void:
	for fighter in fighters:
		if fighter.party_member:
			add_status(fighter)

func add_status(fighter: Fighter) -> void:
	var info = character_status.instance()
	list.add_child(info)
	info.initialize(fighter)
