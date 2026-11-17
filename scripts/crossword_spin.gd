extends TextureRect

@onready var parent:Control = $".."

var spinning := false
var full_circle := false

func _gui_input(event: InputEvent) -> void:
	if spinning: return
	if event is InputEventMouseButton:
		if event.pressed:
			var next_rotation = parent.rotation + PI/2
			create_tween().tween_property(parent, "rotation", next_rotation, 0.2).set_trans(Tween.TRANS_SINE).finished.connect(spin_finished)
			spinning = true

func spin_finished():
	spinning = false
