extends Node

# onready var map = $sandbox_map
onready var party = $party as Party
onready var battle = $battle_session

export (PackedScene) onready var enemy_group

func _ready():
	battle.initialize(enemy_group.instance(), party.get_active_members())
