extends Upgrade

func _apply_upgrade():
	%ManagementScreen._update_max_workers(10)
	
func _undo_upgrade():
	%ManagementScreen._update_max_workers(-10)
