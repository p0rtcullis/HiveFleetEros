extends Control

var trigger_turns : Array = [5]
@onready var canvas_layer : CanvasLayer = %CanvasLayer
var current_event = 0

var event_lookup_table : Dictionary = {5:_scout_encounter}
var event_results_table : Dictionary = {5:_scout_results}
	
func _ready():
	Events.connect("trigger_event",_on_event_triggered)
	Events.connect("choice_made",_log_choice)
#Look-Up Number is the needed value to trigger an event. 
#Events 1-100 are reserved for turn-based events.
#Events 101-200 are reserved for random rolls.
#subject to change.
func _on_event_triggered(lookup_number):
	#print(lookup_number)
	%EndTurnButton.disabled = true
	current_event = lookup_number
	event_lookup_table[current_event].call(lookup_number)
	#print("Looked Up Event")
	
func _log_choice(choice):
	event_results_table[current_event].call(choice)
	pass
	
func _scout_encounter(choice):
	var question_box = preload("res://question_box.tscn")
	var question = question_box.instantiate()
	
	question.event_text = "Enemy Scouts have been spotted in the vicinity of the base. What shall we do?"
	question.button1_text = "Dispatch a raiding party, fall on them with the utmost fury!"
	question.button2_text = "A silent approach is best. With luck, we may recieve captives without tipping our hand."
	
	canvas_layer.add_child(question)
	#put the requirements for the buttons here
	#question.button1.disabled = true
	
	#print("box Created")
	#print("scout"+str(choice))
	
func _scout_results(choice):
	if choice < 2:
		print("Our forces sweep the enemy from the field. Our victory is great, but we have alerted the enemy to our presence.")
	else:
		print("We have captured the intruders, but their disappearance will undoubedly draw more.")
