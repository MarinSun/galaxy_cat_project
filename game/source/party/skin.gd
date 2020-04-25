extends AnimatedSprite

export var TURN_START_MOVE_DISTANCE: float = 40.0
export var TWEEN_DURATION: float = 0.3

onready var tween: Tween = $tween
onready var position_start: Vector2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func guard():
	animation = "guard"

func move_to(target: Fighter):
	tween.interpolate_property(
		self,
		"global_position",
		global_position,
		target.global_position,
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, "tween_completed")

func return_to_start():
	tween.interpolate_property(
		self,
		"position",
		position,
		position_start,
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
