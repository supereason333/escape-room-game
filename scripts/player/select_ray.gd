extends RayCast3D

@export var color:Color

@onready var crosshair:Control = %Crosshair

var selectable := false:
	set(value):
		if selectable != value:
			selectable = value
			update_color()

func _physics_process(_delta: float) -> void:
	if get_collider() is Select3D:
		selectable = true
	else:
		selectable = false

func update_color():
	if selectable:
		create_tween().tween_property(crosshair, "modulate", color, 0.1)
	else:
		create_tween().tween_property(crosshair, "modulate", Color.WHITE, 0.1)
