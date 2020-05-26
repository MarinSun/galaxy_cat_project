extends AnimatedSprite3D

onready var tween: Tween = $tween
onready var anim: AnimationPlayer = $anim

onready var position_start: Vector3

func attack():
	anim.play("attack")

func idle():
	anim.play("idle")

func idle_stagger():
	anim.play("idle_stagger")

func guard():
	anim.play("guard")
	yield(anim, "animation_finished")

func guard_stagger():
	anim.play("guard_stagger")

func dead():
	anim.play("dead")
