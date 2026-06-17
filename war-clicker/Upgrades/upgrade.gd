extends Button

@export var upgrade_name : String = "Upgrade Text Placeholder"
@export var upgrade_text : String = "Upgrade Description Placeholder"

@export var green_cost : int = 0
@export var brown_cost : int = 0
@export var magenta_cost : int = 0
@export var purple_cost : int = 0

@export var unlocked : bool = false
@export var purchased : bool = false

@export var prereq : Array[Button] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disabled = true
	text = upgrade_name
	tooltip_text = upgrade_text

func _apply_upgrade():
	pass
	
func _undo_upgrade():
	pass
