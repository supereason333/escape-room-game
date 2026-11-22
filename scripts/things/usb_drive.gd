extends Node3D

func _on_select_3d_triggered(player: Player) -> void:
	hide()
	player.has_drive = true
	$Select3D.queue_free()
