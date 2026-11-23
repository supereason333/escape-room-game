extends Control

@export var next_scene:PackedScene
@export var password := "Arkansas"

@onready var wrong_label:Label = %WrongLabel
@onready var incorrect_timer:Timer = $Timer

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.strip_edges() == password:
		$"../..".change_to_packed(next_scene)
	else:
		wrong_label.modulate.a = 1
		incorrect_timer.start()


func _on_timer_timeout() -> void:
	wrong_label.modulate.a = 0
