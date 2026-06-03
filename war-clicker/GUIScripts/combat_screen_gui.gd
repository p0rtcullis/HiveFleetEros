extends Control

var battle_1_diff : int  = 25
var battle_2_diff : int = 50


func _on_battle_button_1_pressed() -> void:
	var combat_num = randi_range(1,100)
	for units in %ManagementScreen.unit_list:
		if combat_num == 1:
			break
		else:
			combat_num -= 1
	print("Attempting Raid...")
	print("Combat Score: "  + str(combat_num) + " vs. " + str(battle_1_diff))
	if combat_num <= battle_1_diff:
		print("Raid Successful!")
		var captured = randi_range(1,3)
		%ManagementScreen.mass_ranger += captured
		print(str(captured) + " enemies captured!")
	else:
		print("Failure!")
