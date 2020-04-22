extends KinematicBody

export var max_speed: float = 100.0
export var move_speed: float = 300.0

var velocity: Vector3 = Vector3.ZERO

onready var camera: Camera = $camera

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var input_direction = get_input_direction()
	
	var x_axis: Vector3 = -camera.global_transform.basis.x * input_direction.x
	var z_axis: Vector3 = -camera.global_transform.basis.z * input_direction.z
	var move_direction: Vector3 = x_axis + z_axis
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0
	
	velocity = move_and_slide(move_direction, Vector3.UP)

static func get_input_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
		0,
		Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	)
