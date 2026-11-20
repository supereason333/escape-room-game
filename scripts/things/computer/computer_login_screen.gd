extends Control

@export var next_scene:PackedScene
@export var password := "Arkansas"

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.strip_edges() == password:
		$"../..".change_to_packed(next_scene)
