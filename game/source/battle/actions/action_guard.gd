extends Action

func execute(targets):
	actor.skin.guard()
	yield(actor.skin.anim, "animation_finished")
	return true
