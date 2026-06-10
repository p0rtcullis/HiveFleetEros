extends Control

var upgrades_reset : bool = true
var active_upgrades = []

@onready var all_upgrades = [%WarriorUpgrade,%ShooterUpgrade,%Upgrade1,%Upgrade2,%Upgrade3,%Upgrade4,%Upgrade5,%Upgrade6]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("end_turn",_end_turn_upgrade)
	for upgrade in all_upgrades:
		upgrade.text = "Default"
		upgrade.tooltip_text = "Def"
		
func _end_turn_upgrade():
	upgrade_processing()

#add or subtract from total points for each color. set true for additon, set false for subtraction
func process_cost(upgrade,refund):
	if refund:
		Events.points_change.emit(upgrade.stats.green_cost,%ManagementScreen.POINTS.GREEN)
		Events.points_change.emit(upgrade.stats.brown_cost,%ManagementScreen.POINTS.BROWN)
		Events.points_change.emit(upgrade.stats.magenta_cost,%ManagementScreen.POINTS.MAGENTA)
		Events.points_change.emit(upgrade.stats.purple_cost,%ManagementScreen.POINTS.PURPLE)
	else:
		Events.points_change.emit(upgrade.stats.green_cost*-1,%ManagementScreen.POINTS.GREEN)
		Events.points_change.emit(upgrade.stats.brown_cost*-1,%ManagementScreen.POINTS.BROWN)
		Events.points_change.emit(upgrade.stats.magenta_cost*-1,%ManagementScreen.POINTS.MAGENTA)
		Events.points_change.emit(upgrade.stats.purple_cost*-1,%ManagementScreen.POINTS.PURPLE)

		
func is_purchased(upgrade):
	return upgrade.stats.purchased == true	
	
func is_not_purchased(upgrade):
	return upgrade.stats.purchased == false	

func is_locked(upgrade):
	return upgrade.stats.unlocked == false

func is_unlocked(upgrade):
	return upgrade.stats.unlocked == true

#check if the upgrade can be afforded with all types of points
func is_affordable(upgrade):
	var cost_count : int = 0
	var cost_check : int = 4
	if upgrade.stats.green_cost <=  %ManagementScreen.total_green:
		cost_count +=1
	if upgrade.stats.brown_cost <= %ManagementScreen.total_brown:
		cost_count +=1
	if upgrade.stats.magenta_cost <= %ManagementScreen.total_magenta:
		cost_count +=1
	if upgrade.stats.purple_cost <= %ManagementScreen.total_purple:
		cost_count +=1
	if cost_count == cost_check:
		return true
		
func is_basic(upgrade):
	if upgrade.prereq.is_empty():
		return true
		
func is_advanced(upgrade):
	if upgrade.prereq:
		return true
		
func prereq_met(upgrade):
	var unlocked_upgrades = all_upgrades.filter(is_locked)
	var _upgrades_met = upgrade.prereq.all(func(item): return unlocked_upgrades.has(item))

#all upgrade checks packaged into one, called by %ManagementScreen
func upgrade_processing():
	for upgrade in all_upgrades.filter(is_basic):
		if is_affordable(upgrade) and is_locked(upgrade):
			upgrade.stats.unlocked = true
			upgrade.disabled = false
			

func _on_reset_upgrades_button_pressed() -> void:
	if upgrades_reset == false:
		for upgrade in all_upgrades.filter(is_purchased):
			process_cost(upgrade,true)
			upgrade.disabled = true
		for upgrade in all_upgrades.filter(is_basic):
			if is_affordable(upgrade):
				upgrade.stats.unlocked = true
				upgrade.disabled = false
		upgrades_reset = true

func buy_upgrade(upgrade):
	process_cost(upgrade,false)
	upgrade.disabled = true
	upgrades_reset = false
	upgrade.stats.purchased = true
	
func _on_shooter_upgrade_pressed() -> void:
	process_cost(%ShooterUpgrade,false)
	%ShooterUpgrade.disabled = true
	Events.unit_unlocked.emit("shooter")
	
func _on_warrior_upgrade_pressed() -> void:
	pass # Replace with function body.

	
func _on_upgrade_1_pressed() -> void:
	buy_upgrade(%Upgrade1)
	
