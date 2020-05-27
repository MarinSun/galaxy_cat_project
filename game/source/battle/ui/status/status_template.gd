extends Control
class_name StatusTemplate

onready var portrait = $info/portrait
onready var hp_bar = $info/bars/health
onready var hp_text = $info/bars/health/hp_text
onready var sp_bar = $info/bars/stamina
onready var sp_text = $info/bars/stamina/sp_text

var hp_value: int = 0 setget set_hp_value
var hp_max: int = 0 setget set_hp_max
var sp_value: int = 0 setget set_sp_value
var sp_max: int = 0 setget set_sp_max

func initialize(fighter: Fighter) -> void:
	_connect_value_signals(fighter)

func set_hp_value(new_value: int) -> void:
	hp_value = new_value
	hp_bar.value = new_value
	hp_text.display(hp_value, hp_max)

func set_hp_max(new_value: int) -> void:
	hp_max = new_value
	hp_bar.max_value = new_value
	hp_text.display(hp_max, new_value)

func set_sp_value(new_value: int) -> void:
	sp_value = new_value
	sp_bar.value = new_value
	sp_text.display(sp_value, sp_max)

func set_sp_max(new_value: int) -> void:
	sp_max = new_value
	sp_bar.max_value = new_value
	sp_text.display(sp_max, new_value)

func _on_hp_changed(new_value, old_value) -> void:
	self.hp_value = new_value

func _on_sp_changed(new_value, old_value) -> void:
	self.sp_value = new_value

func _connect_value_signals(fighter: Fighter) -> void:
	return
