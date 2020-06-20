extends Control
class_name FighterIcon

onready var fighter: Fighter
onready var icon: TextureRect = $icon

func initialize(fighter: Fighter) -> void:
	self.fighter = fighter
	icon.texture = fighter.turn_icon
