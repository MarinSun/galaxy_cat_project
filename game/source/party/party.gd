extends Node2D
class_name Party

export var PARTY_SIZE: int = 4

func get_active_members():
	var active = []
	var available = get_unlocked_characters()
	for i in range(min(len(available), PARTY_SIZE)):
		active.append(available[i])
	return active

func get_unlocked_characters():
	var has_unlocked = []
	for member in get_children():
		if member.visible:
			has_unlocked.append(member)
	return has_unlocked
