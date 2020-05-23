extends Label

func display(value: int, max_value: int) -> void:
	text = "%s/%s" % [value, max_value]
