extends SpriteActor
class_name SpriteExplorer

onready var camera = $camera

export (int) var speed = 3
var velocity: Vector3

func _process(delta: float) -> void:
	var input_direction = get_input_direction()
	
	var x_axis: Vector3 = camera.global_transform.basis.x * input_direction.x
	var z_axis: Vector3 = camera.global_transform.basis.z * input_direction.z
	var move_direction: = x_axis + z_axis
	if move_direction.length() > 1.0:
		move_direction = move_direction.normalized()
	move_direction.y = 0

	if move_direction.x > 0:
		anim.move_right()
	elif move_direction.x < 0:
		anim.move_left()
	elif move_direction.z > 0:
		anim.move_back()
	elif move_direction.z < 0:
		anim.move_front()

	if move_direction.length() < 0.001:
		anim.idle(anim.dir)
	
	velocity = move_direction * speed * delta
	move_and_collide(velocity)

func get_input_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)
