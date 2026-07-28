extends Control

var battle_1_diff : int  = 25
var battle_2_diff : int = 50
var combat_alert_box = preload("res://Alert/alert_box.tscn")

var num_stabbers : int  = 0
var num_shooters : int = 0


func _ready() -> void:
	Events.connect("alert_created",_on_battle_button_1_pressed)
	Events.connect("alert_acknowledged",_acknowledge_event)
	
func _acknowledge_event():
	%EndTurnButton.disabled = false



#Old System
#region
func random_captive_drop():
	var captive_count = randi_range(1,3)
	var type_captured = randi_range(1,100)
	if type_captured >=50:
		if type_captured%2 == 0:
			%ManagementScreen.mass_ranger += captive_count
		else:
			%ManagementScreen.mass_scorpion += captive_count
	elif type_captured < 50 and type_captured >= 26:
		if type_captured%2 == 0:
			%ManagementScreen.mass_hawk += captive_count
		else:
			%ManagementScreen.mass_spider += captive_count
	elif type_captured <= 25 and type_captured >=5:
		%ManagementScreen.mass_banshee += captive_count
	else:
		%ManagementScreen.mass_ranger += captive_count
		#%ManagementScreen.mass_farseer += 1
		#return 1
	return captive_count
			
		
		
	

func _on_battle_button_1_pressed() -> void:
	var combat_num = randi_range(1,100)
	for units in %ManagementScreen.unit_list:
		if combat_num == 1:
			break
		else:
			combat_num -= 1
	var combat_results = combat_alert_box.instantiate()
	combat_results.alert_title = "Attempting Raid..."
	combat_results.alert_text = "Combat Score: "  + str(combat_num) + " vs. " + str(battle_1_diff)
	if combat_num <= battle_1_diff:
		var captured = random_captive_drop()
		combat_results.alert_button_text = "Success!" + " " +str(captured) + " enemies captured!"
	else:
		combat_results.alert_button_text = "Failure!"
	%EventSystem.canvas_layer.add_child(combat_results)	
	
	#endregion
