extends Control
class_name ComputerMain

@onready var drive_button:TextureButton = %DriveButton
@onready var warning:PanelContainer = %WarningPanel

func insert_drive(player:Player):
	if !player.has_drive: return
	player.has_drive = false
	drive_button.show()
	warning.queue_free()
