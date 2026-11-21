extends Control

@export var scene_3d:PackedScene

@onready var load_node:Node3D = %Load
@onready var cam_tilt:Node3D = %CamTilt

func _ready() -> void:
	if !scene_3d: return
	load_node.add_child(scene_3d.instantiate())

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		load_node.rotation.y += event.screen_relative.x * 0.01
		cam_tilt.rotation.x = clamp(cam_tilt.rotation.x + event.screen_relative.y * 0.01, -1.2, 1.2)
