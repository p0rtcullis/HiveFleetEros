extends Control

@onready var shooter_template = preload("res://Unit/shooter_unit.tscn")
@onready var stabber_template = preload("res://Unit/stabber_unit.tscn")
@onready var warrior_template = preload("res://Unit/warrior_unit.tscn")
@onready var stalker_template
@onready var ripple_template
@onready var psy_template

@onready var selected_worker = %Ranger


func _production_update() -> void:
	for worker in %ManagementScreen.worker_list:
		if worker.production_queue.is_empty():
			#print("Nothing to Produce!")
			continue
		else:
			if worker.stats.production_timer < worker.production_queue[0].stats.cook_time:
				#print("Turns Remaining: " + str(worker.production_queue[0].stats.cook_time - worker.stats.production_timer))
				worker.stats.production_timer +=1
			else:
				#print("Unit Produced")
				worker.stats.production_timer = 0
				%ManagementScreen.unit_list.append(worker.production_queue.pop_front())
				#print(%ManagementScreen.unit_list)

func _on_ranger_prodction_button_pressed() -> void:
	selected_worker = %Ranger
	
func _on_spider_production_button_pressed() -> void:
	selected_worker = %Spider

#Shooter
func _on_shooter_production_button_pressed() -> void:
	if %ShooterUpgrade not in %UpgradeScreenGUI.all_upgrades:
		print("Upgrade not unlocked!")
	else:
		var unit = shooter_template.instantiate()
		selected_worker.production_queue.append(unit)
		#print(selected_worker.production_queue)

#Stabber
func _on_stabber_production_button_pressed() -> void:
	if %StabberUpgrade not in %UpgradeScreenGUI.all_upgrades:
		print("Upgrade not unlocked!")
	else:
		var unit = stabber_template.instantiate()
		selected_worker.production_queue.append(unit)
		#print(selected_worker.production_queue)


func _on_warrior_production_button_pressed() -> void:
	if %WarriorUpgrade not in %UpgradeScreenGUI.all_upgrades:
		print("Upgrade not unlocked!")
	else:
		var unit = warrior_template.instantiate()
		selected_worker.production_queue.append(unit)
		#print(selected_worker.production_queue)
