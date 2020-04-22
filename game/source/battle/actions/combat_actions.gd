extends Node

const skill_action = preload("res://source/battle/actions/skill_action.tscn")

func initialize(skills: Array) -> void:
	for skill in skills:
		var new_skill = skill_action.instance()
		new_skill.skill = skill
		add_child(new_skill)

func get_actions():
	return get_children()
