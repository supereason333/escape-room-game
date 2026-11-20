extends SubViewport
class_name ComputerViewport

@onready var control:Control = $ComputerUI

func _ready() -> void:
	control.hide()

func start():
	control.show()

func change_to_packed(scene:PackedScene):
	for child in control.get_children(): child.queue_free()
	control.add_child(scene.instantiate())
