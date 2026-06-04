extends CenterContainer

var alert_title : String = "Placeholder"
var alert_text : String = "Placeholder"
var alert_button_text : String = "Placeholder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%AlertTitle.text = alert_title
	%AlertBody.text = alert_text
	%AlertButton.text = alert_button_text

func _on_alert_button_pressed() -> void:
	Events.alert_acknowledged.emit()
	queue_free()
