extends CenterContainer

#var event_data = BinaryEvent.new()

var event_text : String = "Placeholder"
var button1_text : String = "Placeholder"
var button2_text : String = "Placeholder"
@onready var button1 = %Button

func _ready() -> void:
	%Label.text = event_text
	%Button.text = button1_text
	%Button2.text = button2_text
	

func _on_button_pressed() -> void:
	Events.choice_made.emit(1)
	Events.question_box_gone.emit()
	queue_free()

func _on_button_2_pressed() -> void:
	Events.choice_made.emit(2)
	Events.question_box_gone.emit()
	queue_free()
	
