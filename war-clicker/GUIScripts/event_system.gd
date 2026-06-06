extends Control

var trigger_turns : Array = [1,5]
@onready var canvas_layer : CanvasLayer = %CanvasLayer
var current_event = 0
var alert_box = preload("res://alert_box.tscn")

var event_lookup_table : Dictionary = {1:_first_event,5:_scout_encounter}
var event_results_table : Dictionary = {5:_scout_results}
	
func _ready():
	Events.connect("trigger_event",_on_event_triggered)
	Events.connect("choice_made",_log_choice)
	Events.connect("alert_created",_first_event)
	Events.connect("alert_acknowledged",_acknowledge_event)
#Look-Up Number is the needed value to trigger an event. 
#Events 1-100 are reserved for turn-based events.
#Events 101-200 are reserved for random rolls.
#subject to change.
func _on_event_triggered(lookup_number):
	#print(lookup_number)
	%EndTurnButton.disabled = true
	current_event = lookup_number
	event_lookup_table[current_event].call()
	#print("Looked Up Event")
	
func _log_choice(choice):
	if current_event in event_results_table:
		event_results_table[current_event].call(choice)
	pass

func _acknowledge_event():
	%EndTurnButton.disabled = false
	
func _first_event():
	var alert = alert_box.instantiate()
	alert.alert_title = "ALERT"
	alert.alert_text = "This is the first event you'll encounter. For now, events only trigger on turn 5, but eventually they will trigger based on more complex inputs like upgrade unlocks, army growth and even how aggressive you are!"
	alert.alert_button_text = "I understand."
	canvas_layer.add_child(alert)
	
		
func _scout_encounter():
	var question_box = preload("res://question_box.tscn")
	var question = question_box.instantiate()
	question.event_title = "Scouting Party"
	question.event_text = "Enemy Scouts have been spotted in the vicinity of the base. What shall we do?"
	question.button1_text = "Dispatch a raiding party, fall on them with the utmost fury!"
	question.button2_text = "A silent approach is best. With luck, we may recieve captives without tipping our hand."
	
	canvas_layer.add_child(question)
	#put the requirements for the buttons here
	#question.button1.disabled = true
	
	#print("box Created")
	#print("scout"+str(choice))
	
func _scout_results(choice):
	var alert = alert_box.instantiate()
	if choice < 2:
		%ManagementScreen.mass_ranger += 5
		alert.alert_title = "AGGRESSIVE ACTION"
		alert.alert_text = "Our forces sweep the enemy from the field. Our victory is great, but we have alerted the enemy to our presence."
		alert.alert_button_text = "Let them come."
	else:
		%ManagementScreen.mass_ranger += 5
		%ManagementScreen.mass_scorpions += 2
		alert.alert_title = "STEALTH ACTION"
		alert.alert_text = "We have captured the intruders, but their disappearance will undoubedly draw more."
		alert.alert_button_text = "More for the broodchambers..."
	canvas_layer.add_child(alert)
