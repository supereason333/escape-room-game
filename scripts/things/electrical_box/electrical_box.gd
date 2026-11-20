extends MeshInstance3D

signal power_on

@export var lights:Array[MeshInstance3D]
@export var selecters:Array[Select3D]

func _ready() -> void:
	for light in lights:
		light.visibility_changed.connect(update)

func update():
	for light in lights:
		if !light.visible: return
	power_on.emit()
	for selecter in selecters:
		selecter.queue_free()
