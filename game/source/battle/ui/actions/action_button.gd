extends TextureButton

onready var anim_player: AnimationPlayer = $animation_player

var target_position: Vector2
var unfocused_scale: Vector2

func initialize(action: Action) -> void:
	
	self.texture_normal = action.icon
	disabled = not action.can_use()
	if disabled:
		modulate = Color("#484848")
	
	connect("mouse_entered", self, "enter_focus")
	connect("mouse_exited", self, "exit_focus")
	connect("focus_entered", self, "enter_focus")
	connect("focus_exited", self, "exit_focus")

func enter_focus():
	#raise()
	anim_player.play("focus_enter")

func exit_focus():
	anim_player.play("focus_exit")
