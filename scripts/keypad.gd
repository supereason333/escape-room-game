extends MeshInstance3D

signal unlocked

@export var code := "1234"

var _unlocked := false

func on_unlocked():
	_unlocked = true
	unlocked.emit()

func _on_override_with(scene: Control) -> void:
	if _unlocked:
		scene.set_unlocked()
	else:
		scene.unlocked.connect(on_unlocked)
		scene.code = code
