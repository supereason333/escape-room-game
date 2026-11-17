extends Control

@onready var viewport:SubViewport = %SubViewport

func _ready() -> void:
	set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	var mouse_event := false
	if event is InputEventMouse:
		mouse_event = true

	if mouse_event:
		handle_mouse(event)
	else:
		viewport.push_input(event, true)

func handle_mouse(event:InputEventMouse):


	event.position -= position
	event.position /= size
	event.position *= Vector2(640, 480)
	event.global_position -= position
	event.global_position /= size
	event.global_position *= Vector2(640, 480)

	viewport.push_input(event, false)

func _on_camera_override_changed(state: bool) -> void:
	set_process_unhandled_input(state)
	if state:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
