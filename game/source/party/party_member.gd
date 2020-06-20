extends Node
class_name PartyMember

signal level_changed(new_value, old_value)

export var explorer_sprite: NodePath
export var growth: Resource

export var experience: int setget _set_experience
var stats: Resource

onready var fighter: Fighter = $fighter

func _ready():
	stats = growth.create_stats(experience)
	fighter.stats = stats

func get_fighter_copy():
	return fighter.duplicate()

func get_exploration_sprite():
	return get_node("exploration_sprite").duplicate()

func update_stats(old_stats: CharacterStatus) -> void:
	var old_level = old_stats.level
	var new_level = growth.get_level(experience)
	if old_level != new_level:
		stats = growth.create_stats(experience)
		emit_signal("level_changed", new_level, old_level)
	fighter.stats = stats

func _set_experience(value: int) -> void:
	if value == null:
		return
	experience = max(0, value)
	if stats:
		update_stats(stats)
