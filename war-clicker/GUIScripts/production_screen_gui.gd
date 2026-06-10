extends Control

@onready var shooter_template = preload("res://Unit/shooter_unit.tscn")
@onready var stabber_template = preload("res://Unit/stabber_unit.tscn")
@onready var warrior_template = preload("res://Unit/warrior_unit.tscn")
@onready var stalker_template
@onready var ripple_template
@onready var psy_template

@onready var selected_worker = %Ranger

var prod_mod : int = 0
@onready var unlocked_units :Array = [stabber_template]
@onready var unit_types : Dictionary = {"shooter":shooter_template,"warrior":warrior_template,"stalker":stalker_template,"ripple":ripple_template,"psy":psy_template}

func _ready() -> void:
	Events.connect("end_turn",_end_turn_production)
	Events.connect("unit_unlocked",_unit_unlocked)

func _end_turn_production():
	_worker_production()
	_production_update()
	
func _unit_unlocked(unit):
	unlocked_units.append(unit_types[unit])

func _worker_production():
	for worker in %ManagementScreen.mass_worker_list:
		for x in range(0,worker):
			var prod_chance = randi_range(1,100)
			if prod_chance <= 10 + prod_mod:
				Events.unit_gain.emit(unlocked_units.pick_random())


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
				Events.unit_gain.emit(worker.production_queue.pop_front())
				#print(%ManagementScreen.unit_list)

func _on_ranger_prodction_button_pressed() -> void:
	selected_worker = %Ranger
	
func _on_spider_production_button_pressed() -> void:
	selected_worker = %Spider

#Shooter
func _on_shooter_production_button_pressed() -> void:
	if shooter_template not in unlocked_units:
		print("Upgrade not unlocked!")
	else:
		var unit = shooter_template.instantiate()
		selected_worker.production_queue.append(unit)

#Stabber
func _on_stabber_production_button_pressed() -> void:
	if stabber_template not in unlocked_units:
		print("Upgrade not unlocked!")
	else:
		var unit = stabber_template.instantiate()
		selected_worker.production_queue.append(unit)


func _on_warrior_production_button_pressed() -> void:
	if warrior_template not in unlocked_units:
		print("Upgrade not unlocked!")
	else:
		var unit = warrior_template.instantiate()
