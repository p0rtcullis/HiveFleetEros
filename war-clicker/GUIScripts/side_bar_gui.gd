extends Control

func _on_production_screen_toggle_pressed() -> void:
	if %ProductionScreenGUI.visible == false:
		%ArchiveScreenGUI.hide()
		%UpgradeScreenGUI.hide()
		%CombatScreenGUI.hide()
		%ProductionScreenGUI.show()
		%Welcome.hide()

func _on_upgrade_screeen_toggle_pressed() -> void:
	if %UpgradeScreenGUI.visible == false:
		%ArchiveScreenGUI.hide()
		%CombatScreenGUI.hide()
		%ProductionScreenGUI.hide()
		%UpgradeScreenGUI.show()
		%Welcome.hide()
		
func _on_combat_screen_toggle_pressed() -> void:
	if %CombatScreenGUI.visible == false:
		%ArchiveScreenGUI.hide()
		%ProductionScreenGUI.hide()
		%UpgradeScreenGUI.hide()
		%CombatScreenGUI.show()
		%Welcome.hide()

func _on_archive_screen_toggle_pressed() -> void:
	if %ArchiveScreenGUI.visible == false:
		%ProductionScreenGUI.hide()
		%UpgradeScreenGUI.hide()
		%CombatScreenGUI.hide()
		%ArchiveScreenGUI.show()
		%Welcome.hide()
