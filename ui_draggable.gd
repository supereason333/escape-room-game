extends Control

var dragging := false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		dragging = event.pressed
	if dragging:
		if event is InputEventMouseMotion:
			self.position = event.global_position - Vector2(32, 32)
			self.position.x = clampf(self.position.x, 0, 1920 - 64)
			self.position.y = clampf(self.position.y, 0, 1080 - 64)
