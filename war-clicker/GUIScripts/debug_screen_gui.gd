extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_toggle_guard_toggled(_toggled_on: bool) -> void:
	if %Guard.stats.unlocked == false:
		%Guard.stats.unlocked = true
		%GuardProdctionButton.show()
	else:
		%Guard.stats.unlocked = false
		%GuardProdctionButton.hide()
	print("Guard Unlocked: " + str(%Guard.stats.unlocked ))

func _on_toggle_spider_toggled(_toggled_on: bool) -> void:
	if %Spider.stats.unlocked == false:
		%Spider.stats.unlocked = true
		%SpiderProductionButton.show()
	else:
		%Spider.stats.unlocked = false
		%SpiderProductionButton.hide()
	print("Spider Unlocked: " + str(%Spider.stats.unlocked ))


func _on_toggle_events_toggled(toggled_on: bool) -> void:
	if Events.enable_events:
		Events.enable_events = false
	else:
		Events.enable_events = true
