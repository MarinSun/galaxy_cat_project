extends AnimatedSprite3D

onready var tween: Tween = $tween
onready var position_start: Vector3

func attack():
	play("attack")

func idle():
	play("idle")

func idle_stagger():
	play("idle_stagger")

func guard():
	play("guard")

func guard_stagger():
	play("guard_stagger")

func dead():
	play("dead")
