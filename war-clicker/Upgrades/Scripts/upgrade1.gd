extends Upgrade

func _apply_upgrade():
	%ManagementScreen._update_max_workers(5)
	
func _undo_upgrade():
	%ManagementScreen._update_max_workers(-5)
