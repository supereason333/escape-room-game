extends Control

var dragging := false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		dragging = event.pressed
	if dragging:
		if event is InputEventMouseMotion:
			self.position = event.global_position - Vector2(32, 32)
