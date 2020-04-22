extends Control

signal target_selected(fighter)

onready var anim_player = $sprite/animation
onready var tween = $tween

export var MOVE_DURATION: float = 0.1

const DIR_UP = Vector2.UP
const DIR_LEFT = Vector2.LEFT
const DIR_RIGHT = Vector2.RIGHT
const DIR_DOWN = Vector2.DOWN

var targets: Array
var target_active: Fighter

func select_targets(fighters: Array) -> Array:
	visible = true
	targets = fighters
	target_active = targets[0]
#	rect_scale.x = 1.0 if target_active.party_member else -1.0
	rect_global_position = target_active.target_global_position
	anim_player.play("idle")
	grab_focus()
	var selected_target: Fighter = yield(self, "target_selected")
	hide()
	if not selected_target:
		return []
	return [selected_target]

func move_to(fighter: Fighter):
	tween.interpolate_property(
		self,
		"rect_global_position",
		rect_global_position,
		fighter.target_global_position,
		MOVE_DURATION,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT
	)
	tween.start()
