extends Action

func execute(targets):
	actor.skin.guard()
	yield(actor.skin, "animation_finished")
	return true
