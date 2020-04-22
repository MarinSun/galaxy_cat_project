extends FighterAI

var interface: Node

func choose_action(fighter: Fighter, fighters: Array = []):
	interface.open_actions_menu(fighter)
	return yield(interface, "action_selected")

func choose_target(fighter: Fighter, action: BattleAction, fighters: Array = []):
	interface.select_targets(fighters)
	return yield(interface, "target_selected")

