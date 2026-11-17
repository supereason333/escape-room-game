extends Node3D

signal override_changed(state: bool)

@export var camera:Camera3D

var target_transform:Transform3D

var player:Player

func _ready() -> void:
	target_transform = camera.global_transform
	set_process_unhandled_input(false)

func override(pl:Player):
	if !camera: return
	player = pl
	player.camera_override = true
	camera.global_transform = player.camera.global_transform
	camera.fov = player.camera.fov

	camera.current = true

	create_tween().tween_property(camera, "global_transform", target_transform, 0.2)
	await create_tween().tween_property(camera, "fov", 75, 0.2).finished
	override_changed.emit(true)
	set_process_unhandled_input(true)


func return_camera():
	if !player: return
	override_changed.emit(false)
	set_process_unhandled_input(false)
	create_tween().tween_property(camera, "global_transform", player.camera.global_transform, 0.2)
	await create_tween().tween_property(camera, "fov", player.camera.fov, 0.2).finished

	player.camera.current = true

	camera.global_transform = target_transform
	player.camera_override = false
	player = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit_view"):
		return_camera()
