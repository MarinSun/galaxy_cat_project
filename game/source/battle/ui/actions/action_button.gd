extends Button

onready var btn_icon: = $icon as TextureRect

var target_position: Vector2
var unfocused_scale: Vector2

func initialize(action: BattleAction, target_position: Vector2) -> void:
	unfocused_scale = rect_scale
	rect_scale = Vector2()
	self.target_position = target_position
	
	btn_icon.texture = action.icon
	disabled = not action.can_use()
	if disabled:
		modulate = Color("#555555")

func enter_focus():
	pass

func exit_focus():
	pass
