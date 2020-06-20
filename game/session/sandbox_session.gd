extends Node

const battle_session = preload("res://source/battle/battle_session.tscn")

onready var party = $party as Party
onready var bgm = $bgm

var battle: BattleSession

export (PackedScene) onready var map
export (PackedScene) onready var enemy_group

func _ready():
	var local_map = map.instance()
	add_child(local_map)
	local_map.spawn_party(party)
#	enter_battle(enemy_group.instance())

func enter_battle(group: EnemyGroup):
	
	#
	# Preparation
	#
	
	bgm.battle_1()
	
	battle = battle_session.instance()
	add_child(battle)
	
	#
	# Signal Connecting
	#
	
	battle.initialize(group, party.get_active_members())

func _battle_done():
	pass

func _battle_win():
	pass

func _battle_lose():
	pass
