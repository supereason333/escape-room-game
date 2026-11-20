extends Node3D

@export var default_scene:PackedScene
@export var viewport:ComputerViewport

var powered := false
var started := false

func power():
	powered = true


func _on_triggered(player: Player) -> void:
	if !powered: return
	if started: return
	started = true
	viewport.change_to_packed(default_scene)
	viewport.start()
