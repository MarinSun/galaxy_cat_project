extends AnimatedSprite3D

onready var tween: Tween = $tween
onready var anim: AnimationPlayer = $anim
onready var position_start: Vector3

export var TWEEN_DURATION: float = 0.5

func attack():
	anim.play("attack")
	yield(anim, "animation_finished")
	idle()

func idle():
	anim.play("idle")

#func idle_stagger():
#	anim.play("idle_stagger")
#	yield(anim, "animation_finished")
#	idle()

func guard():
	anim.play("guard")
	yield(anim, "animation_finished")

#func guard_stagger():
#	anim.play("guard_stagger")
#	yield(anim, "animation_finished")
#	guard()

func stagger():
	match anim.current_animation:
		"guard":
			anim.play("guard_stagger")
		_:
			anim.play("idle_stagger")
	yield(anim, "animation_finished")

func move_start():
	anim.play("move_start")
	yield(anim, "animation_finished")

func move_finished():
	anim.play("move_finished")
	yield(anim, "animation_finished")

func recovery():
	match anim.current_animation:
		"guard_stagger":
			anim.play("guard")
		_:
			anim.play("idle")

func dead():
	anim.play("dead")
	yield(anim, "animation_finished")

func move_to(target: Fighter):
	anim.play("move")
	tween.interpolate_property(
		self,
		"global_transform",
		global_transform,
		target.attacker_position,
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, "tween_completed")

func return_to_start(starting_point: Transform):
	anim.play_backwards("move")
	tween.interpolate_property(
		self,
		"global_transform",
		global_transform,
		starting_point,
		TWEEN_DURATION,
		Tween.TRANS_QUAD,
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, "tween_completed")
	anim.play("idle")
