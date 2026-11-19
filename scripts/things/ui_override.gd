extends Node

signal override_with(scene:Control)

@export var ui_scene:PackedScene

var player:Player

func _ready() -> void:
	set_process_unhandled_input(false)

func override(pl:Player):
	player = pl
	player.camera_override = true

	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	var node = ui_scene.instantiate()
	player.override_ui_base.add_child(node)

	set_process_unhandled_input(true)

	override_with.emit(node)

func release():
	set_process_unhandled_input(false)

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	for child in player.override_ui_base.get_children():
		child.queue_free()

	player.camera_override = false
	player = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_view"):
		release()
		get_viewport().set_input_as_handled()
