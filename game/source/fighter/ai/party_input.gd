extends FighterAI

var interface: Node

func choose_action(fighter: Fighter, fighters: Array = []):
	interface.open_actions_menu(fighter)
	return yield(interface, "action_selected")

func choose_target(fighter: Fighter, action: BattleAction, fighters: Array = []):
	match action.target:
		0:
			interface.select_targets([fighter])
			return yield(interface, "targets_selected")
		_:
			interface.select_targets(fighters)
			return yield(interface, "targets_selected")

