extends AnimatedSprite

export var TURN_START_MOVE_DISTANCE: float = 40.0
#export var TWEEN_DURATION: float = 0.3

#onready var tween
onready var position_start: Vector2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func guard():
	animation = "guard"
