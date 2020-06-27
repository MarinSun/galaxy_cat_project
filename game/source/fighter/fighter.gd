extends Position3D
class_name Fighter

signal dead(fighter)

export var TARGET_OFFSET_DISTANCE: float = 120.0

export var stats: Resource
onready var skin =  $skin
onready var actions = $actions
onready var skills = $skills
onready var drops = $drops
onready var ai = $ai

onready var starting_position: Transform = $anchor.global_transform
onready var cursor_position: Transform = $cursor_position.global_transform
onready var attacker_position: Transform = $attacker_position.global_transform

var selected: bool = false setget set_selected
var selectable: bool = false setget set_selectable

export var party_member: bool = false
export var turn_icon: Texture

func _ready():
	selectable = true

func initialize():
	skin.anim.play("idle")
	actions.initialize(skills.get_children())
	stats = stats.copy()
	stats.connect("health_depleted", self, "_on_health_depleted")

func is_able_to_play():
	return stats.health > 0

func set_selected(value):
	selected = value

func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)

func take_damage(hit):
	stats.take_damage(hit)
	if stats.health > 0:
		skin.stagger()
		yield(skin.anim, "animation_finished")
		skin.recovery()

func act(cost):
	stats.act(cost)

func _on_health_depleted():
	selectable = false
	yield(skin.dead(), "completed")
	emit_signal("dead", self)
