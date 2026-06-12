extends Node

var can_click : bool = true
var current_turn : int = 0

var max_workers : int = 5:
	set(value):
		max_workers = value
		%MaxWorkersLabel.text = "Max Workers: " +str(value)
var worker_list : Array = []

var unit_list : Array = []

@export var total_green : int = 0:
	set(value):
		total_green = value
		%GreenPointsLabel.text = str(total_green)
		#%UpgradeScreenGUI.disable_unafforable_techs()
		
var green_mod : int = 0

@export var total_brown : int = 0:
	set(value):
		total_brown = value
		%BrownPointsLabel.text = str(total_brown)
		#%UpgradeScreenGUI.disable_unafforable_techs()
		
var brown_mod : int = 0

@export var total_magenta : int = 0:
	set(value):
		total_magenta = value
		%MagentaPointsLabel.text = str(total_magenta)
		#%UpgradeScreenGUI.disable_unafforable_techs()
		
var magenta_mod : int = 0

@export var total_purple : int = 0:
	set(value):
		total_purple = value
		%PurplePointsLabel.text = str(total_purple)
		#%UpgradeScreenGUI.disable_unafforable_techs()
		
var purple_mod : int = 0

enum WORKERS {GUARD,REAPER,BANSHEE,SPIDER,DRAGON,AUTARCH,AVENGER,HAWK,SCORPION,SEER,WARLOCK}
enum POINTS {GREEN,BROWN,MAGENTA,PURPLE}

#How advanced your colony is
var colony_level : int = 1

#Determines how likely you are to be raided
var colony_noise : int = 0

var mass_ranger : int = 0:
	set(value):
		mass_ranger = min(value,max_workers)
		%MassRangerLabel.text = str(mass_ranger)
var mass_spider : int = 0:
	set(value):
		mass_spider = min(value,max_workers)
		%MassSpiderLabel.text = str(mass_spider)
var mass_banshee : int = 0:
	set(value):
		mass_banshee = min(value,max_workers)
		%MassBansheeLabel.text = str(mass_banshee)
var mass_scorpion : int = 0:
	set(value):
		mass_scorpion= min(value,max_workers)
		%MassScorpionLabel.text = str(mass_scorpion)
var mass_hawk : int = 0:
	set(value):
		mass_hawk = min(value,max_workers)
		%MassHawkLabel.text = str(mass_hawk)
	
	
var mass_worker_list : Array = [mass_ranger,mass_spider,mass_banshee,mass_scorpion,mass_hawk]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("question_box_gone",_on_question_box_gone)
	Events.connect("points_change",_update_points)
	Events.connect("unit_gain",_unit_gain)
	%MaxWorkersLabel.text = "Max Workers: " +str(max_workers)
	worker_list.append(%Ranger)
	worker_list.append(%Spider)
	worker_list.append(%Scorpion)
	worker_list.append(%Hawk)
	worker_list.append(%Banshee)
	worker_list.append(%Seer)
	pass
	
	
func _unit_gain(unit):
	unit_list.append(unit)

func _mass_worker_point_count():
	total_green += round(((mass_ranger*5*0.25)+(mass_scorpion*10*0.25))+(mass_hawk*5*0.25))
	total_brown += round(((mass_spider*5*0.25)+(mass_banshee*10*0.25))+(mass_hawk*5*0.25))
	total_magenta += round((mass_spider*5*0.25))
	total_purple += round((mass_spider*5*0.25))
	
#Future use
func _on_question_box_gone():
	%EndTurnButton.disabled = false

#used for round ending totals
func _worker_point_count(color : POINTS):
	var point_total : int = 0
	for worker in worker_list:
		if worker.stats.unlocked:
			match color:
				POINTS.GREEN:
					point_total += worker.stats.green
				POINTS.BROWN:
					point_total += worker.stats.brown
				POINTS.MAGENTA:
					point_total += worker.stats.magenta
				POINTS.PURPLE:
					point_total += worker.stats.purple
	return point_total

#update the numbers of mass workers
func _update_max_workers(new_max: int):
	max_workers += new_max
	
# For modifying point totals via upgrades
func _update_points(new_points: int, color : POINTS):
	match color:
			POINTS.GREEN:
				total_green += new_points
			POINTS.BROWN:
				total_brown += new_points
			POINTS.MAGENTA:
				total_magenta += new_points
			POINTS.PURPLE:
				total_purple += new_points
				

func total_points():
	total_green += _worker_point_count(POINTS.GREEN)
	total_brown += _worker_point_count(POINTS.BROWN)
	total_magenta += _worker_point_count(POINTS.MAGENTA)
	total_purple += _worker_point_count(POINTS.PURPLE)


#Process end of turn updates
func _on_end_turn_button_pressed() -> void:
	Events.end_turn.emit()
	
	total_points()

	%ArmyLabel.text = "Army Size: " + str(unit_list.size())
	
	mass_worker_list = [mass_ranger,mass_spider,mass_banshee,mass_scorpion,mass_hawk]
	
	_mass_worker_point_count()
	current_turn +=1
	#print(current_turn)
	if Events.enable_events:
		for turn in %EventSystem.trigger_turns:
			if turn == current_turn:
				Events.emit_signal("trigger_event",current_turn)
				break
			else:
				#print("false")
				pass
