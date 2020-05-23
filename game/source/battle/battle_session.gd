extends Spatial
class_name BattleSession

const FighterNode = preload("res://source/fighter/fighter.tscn")

onready var camera = $camera
onready var turn_queue = $turn_queue
onready var battle_ui = $battle_ui

var active: bool = false
var party: Array = []

signal battle_ends
signal battle_complete
signal battle_win
signal battle_lose

func initialize(group: EnemyGroup, party: Array):
	battle_preparation(group, party)
	
	var fighters = turn_queue.get_fighters()
	for fighter in fighters:
		fighter.initialize()
	
	battle_ui.initialize(self, turn_queue, fighters)
	turn_queue.initialize()
	
	battle_start()

func battle_preparation(group: EnemyGroup, party_members: Array) -> void:
	for member in group.get_children():
		var enemy: Fighter = member.duplicate()
		turn_queue.add_child(enemy)
		enemy.stats.reset()
	
	var party_spawn = $spawn_position/party
	for index in len(party_members):
		var party_member = party_members[index]
		var spawn_point = party_spawn.get_child(index)
		var fighter: Fighter = party_member.get_fighter_copy()
		fighter.global_transform.origin = spawn_point.global_transform.origin
		fighter.name = party_member.name
		fighter.set_meta("party_member", party_member)
	
		turn_queue.add_child(fighter)
		self.party.append(fighter)
		fighter.ai.set("interface", battle_ui)

func battle_start():
	active = true
	play_turn()

func battle_end():
	emit_signal("battle_ends")

func play_turn() -> void:
	var fighter: Fighter = get_active_fighter()
	var targets: Array
	var action: Action
	
	while not fighter.is_able_to_play():
		turn_queue.skip_turn()
		fighter = get_active_fighter()
	
	fighter.selected = true
	fighter.skin.idle()
	var enemies: Array = get_targets()
	if not enemies:
		battle_end()
		return
	
	action = yield(fighter.ai.choose_action(fighter, enemies), "completed")
	targets = yield(fighter.ai.choose_target(fighter, action, enemies), "completed")
	fighter.selected = false
	
	if targets != []:
		yield(turn_queue.play_turn(action, targets), "completed")
	if active:
		play_turn()

func get_active_fighter() -> Fighter:
	return turn_queue.active_fighter

func get_targets():
	if get_active_fighter().party_member:
		return turn_queue.get_enemies()
	else:
		return turn_queue.get_party()
