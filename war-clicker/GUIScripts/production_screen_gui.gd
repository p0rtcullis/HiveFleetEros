extends Control

@onready var shooter_template = preload("res://Unit/shooter_unit.tscn")
@onready var stabber_template = preload("res://Unit/stabber_unit.tscn")
@onready var warrior_template = preload("res://Unit/warrior_unit.tscn")
@onready var stalker_template
@onready var ripple_template
@onready var psy_template

@onready var selected_worker = %Ranger:
	set(value):
		selected_worker = value
		%SelectedWorkerLabel.text = "Selected Worker: " + selected_worker.stats.worker_name
		

var prod_mod : int = 0
@onready var unlocked_units :Array = [stabber_template]
@onready var unit_types : Dictionary = {"shooter":shooter_template,"warrior":warrior_template,"stalker":stalker_template,"ripple":ripple_template,"psy":psy_template}

func _ready() -> void:
	Events.connect("end_turn",_end_turn_production)
	Events.connect("unit_unlocked",_unit_unlocked)

func _end_turn_production():
	_worker_production()
	_production_update()
	_display_queue(selected_worker)
	
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
			continue
		else:
			if worker.stats.production_timer < worker.production_queue[0].stats.cook_time-1:
				worker.stats.production_timer +=1
			else:
				worker.stats.production_timer = 0
				Events.unit_gain.emit(worker.production_queue.pop_front())
				
func _create_unit(template):
	if template not in unlocked_units:
		print("Upgrade not unlocked!")
	else:
		var new_unit = template.instantiate()
		selected_worker.production_queue.append(new_unit)
		_display_queue(selected_worker)

func _display_queue(worker):
	%ProductionQueue.clear()
	var index = 0
	for unit in worker.production_queue:
		if index == 0:
			%ProductionQueue.add_item(unit.stats.unit_name + " turns remaining: " + str(unit.stats.cook_time-worker.stats.production_timer))
		else:
			%ProductionQueue.add_item(unit.stats.unit_name + " turns remaining: " + str(unit.stats.cook_time+unit.stats.cook_time-worker.stats.production_timer+index-1))
		index +=1
		
func _on_production_queue_item_activated(index: int) -> void:
	selected_worker.production_queue.pop_at(index)
	_display_queue(selected_worker)

func _on_ranger_prodction_button_pressed() -> void:
	selected_worker = %Ranger
	_display_queue(%Ranger)
	
func _on_spider_production_button_pressed() -> void:
	selected_worker = %Spider
	_display_queue(%Spider)
#Shooter
func _on_shooter_production_button_pressed() -> void:
	_create_unit(shooter_template)

#Stabber
func _on_stabber_production_button_pressed() -> void:
	_create_unit(stabber_template)


func _on_warrior_production_button_pressed() -> void:
	_create_unit(warrior_template)
