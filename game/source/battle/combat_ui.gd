extends CanvasLayer

signal action_selected(action)
signal targets_selected(targets)

const Menu = preload("res://source/battle/ui/actions/menu.tscn")

onready var turn_order = $turn_order
onready var bars_fetcher = $bars_fetcher
onready var cursor = $cursor

func initialize(session: BattleSession, queue: TurnQueue, fighters: Array):
	turn_order.initialize(session, queue)
	bars_fetcher.initialize(fighters)
	remove_child(cursor)

func open_actions_menu(fighter: Fighter) -> void:
	var menu = Menu.instance()
	add_child(menu)
	menu.rect_position = fighter.global_position
	menu.initialize(fighter)
	menu.open()
	var selected_action: BattleAction = yield(menu, "action_selected")
	emit_signal("action_selected", selected_action)

func select_targets(selectable_fighters: Array) -> void:
	add_child(cursor)
	var targets: Array = yield(cursor.select_targets(selectable_fighters), "completed")
	emit_signal("targets_selected", targets)
	remove_child(cursor)
