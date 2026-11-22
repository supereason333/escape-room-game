extends SubViewport
class_name ComputerViewport

@onready var control:Control = $ComputerUI

var main_disp:ComputerMain

func _ready() -> void:
	control.hide()

func start():
	control.show()

func change_to_packed(scene:PackedScene):
	for child in control.get_children(): child.queue_free()
	var node = scene.instantiate()
	if node is ComputerMain:
		main_disp = node
	control.add_child(node)


func interacted(player: Player) -> void:
	if main_disp:
		main_disp.insert_drive(player)
