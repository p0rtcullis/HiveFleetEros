extends Control

var active_upgrades = []

@onready var all_upgrades = [%Upgrade1,%Upgrade2,%StabberUpgrade]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func price_check(upgrade_cost,total_points):
	return upgrade_cost <= total_points


func _on_reset_upgrades_button_pressed() -> void:
	for upgrade in active_upgrades:
		upgrade.button_pressed = false
	active_upgrades.clear()
	
func disable_unafforable_techs():
	var cost_count = 0
	var cost_check = 4
	for x in all_upgrades:
		if disable_advanced_tech(x.prereq) and x not in active_upgrades:
			for y in range(4):
				var all_costs = [x.stats.green_cost,x.stats.brown_cost,x.stats.magenta_cost,x.stats.purple_cost]
				var all_points = [%ManagementScreen.total_green,%ManagementScreen.total_brown,%ManagementScreen.total_magenta,%ManagementScreen.total_purple]
				if price_check(all_costs[y],all_points[y]):
						cost_count +=1
			if cost_count < cost_check:
				x.disabled = true
			else:
				x.disabled = false
		else:
			x.disabled = true
					
func disable_advanced_tech(prerequisites):
	var all_active = prerequisites.all(func(item): return item in active_upgrades)
	return all_active

func _on_upgrade1_toggled(toggled_on: bool) -> void:
	#refactor this so that points are deducted/added for all costs dynamically, make it a function
	if toggled_on:
		%ManagementScreen.update_points(-100,%ManagementScreen.POINTS.GREEN)
		%ManagementScreen.update_max_workers(1)
		active_upgrades.append(%Upgrade1)
		%Upgrade1.disabled = true
	else:
		%ManagementScreen.update_points(100,%ManagementScreen.POINTS.GREEN)
		%ManagementScreen.update_max_workers(-1)
		%Upgrade1.disabled = false
		
func _on_upgrade_2_toggled(_toggled_on: bool) -> void:
	pass # Replace with function body.
