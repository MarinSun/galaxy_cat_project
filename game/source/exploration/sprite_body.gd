extends Position3D
class_name SpriteBody

onready var body = $root/body

enum DIR { FRONT, BACK, LEFT, RIGHT }
var dir = DIR.FRONT

func _ready():
	body.playing = true
	idle(dir)

func move_front():
	body.play("walk_front")
	dir = DIR.FRONT

func move_back():
	body.play("walk_back")
	dir = DIR.BACK

func move_right():
	body.play("walk_right")
	dir = DIR.RIGHT

func move_left():
	body.play("walk_left")
	dir = DIR.LEFT

func idle(direction):
	match direction:
		DIR.FRONT:
			body.play("idle_front")
		DIR.BACK:
			body.play("idle_back")
		DIR.LEFT:
			body.play("idle_left")
		DIR.RIGHT:
			body.play("idle_right")
