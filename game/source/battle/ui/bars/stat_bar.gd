extends Control
class_name StatBar

onready var bar = $column/bar
onready var bar_value = $column/value

var max_value: int = 0 setget set_max_value
var value: int = 0 setget set_value

export var LABEL_ABOVE: bool
export var HIDE_ON_DEPLETED: bool

func _ready() -> void:
	if LABEL_ABOVE:
		bar_value.raise()

func initialize(fighter: Fighter) -> void:
	_connect_value_signals(fighter)

func set_max_value(new_value) -> void:
	max_value = new_value
	bar.max_value = new_value
	bar_value.display(value, new_value)

func set_value(new_value) -> void:
	value = new_value
	bar.value = new_value
	bar_value.display(value, new_value)

func _connect_value_signals(fighter: Fighter) -> void:
	print("Signal not connected in: " + name)

func _on_value_changed(new_value, old_value) -> void:
	self.value = new_value

func _on_value_depleted() -> void:
	if HIDE_ON_DEPLETED:
		hide()
