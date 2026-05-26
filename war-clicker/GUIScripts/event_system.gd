extends Control

var trigger_turns : Array = [2,5,8,10]
@onready var canvas_layer : CanvasLayer = %CanvasLayer

var event_lookup_table : Dictionary = {2:_scout_encounter}
	
func _ready():
	Events.connect("trigger_event",_on_event_triggered)
	
#Look-Up Number is the needed value to trigger an event. 
#Events 1-100 are reserved for turn-based events.
#Events 101-200 are reserved for random rolls.
#subject to change.
func _on_event_triggered(lookup_number):
	print(lookup_number)
	#event_lookup_table[lookup_number].call()
	var question_box = preload("res://question_box.tscn")
	var question = question_box.instantiate()
	canvas_layer.add_child(question)
	
	
func _scout_encounter():
	print("Scouts looking for their missing comrade are dangerously close to base. A show of force could lead to the capture of the entire squad, at risk of raising an alarm. Alternatively, they could be redirected by sacrificing a few lesser bioforms.")
