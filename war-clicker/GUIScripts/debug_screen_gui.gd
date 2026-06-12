extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_toggle_events_toggled(toggled_on: bool) -> void:
	if Events.enable_events:
		Events.enable_events = false
	else:
		Events.enable_events = true
		
func _on_toggle_dev_mode_pressed() -> void:
	if Events.enable_dev_mode:
		Events.enable_dev_mode = false
	else:
		Events.enable_dev_mode = true
