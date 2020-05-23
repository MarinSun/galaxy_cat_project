extends Node
class_name PartyMember

export var explorer_sprite: NodePath
export var growth: Resource
export var experience: int

var stats: Resource

onready var fighter: Fighter = $fighter

func _ready():
	stats = growth.create_stats(experience)
	fighter.stats = stats

func get_fighter_copy():
	return fighter.duplicate()
