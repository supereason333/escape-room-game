extends Control

@export var code: String
@export var next_scene: PackedScene

@onready var lineedit:LineEdit = %LineEdit
@onready var textedit:TextEdit = %TextEdit

var unlocked := false

func _ready() -> void:
	push_text("booting...")
	await get_tree().create_timer(1).timeout
	push_text("enter hex key: __ __ __ __")

	lineedit.grab_focus()

func push_text(text:String):
	textedit.text += "\n > " + text
	var l := textedit.text.split("\n")
	var remove := l.size() - 16
	if remove > 0:
		for i in remove:
			l.remove_at(0)
	textedit.text = "\n".join(l)

func _on_line_edit_text_submitted(new_text: String) -> void:
	if unlocked: return
	if new_text.to_upper() == code.to_upper():
		unlocked = true
		push_text("correct")
		await get_tree().create_timer(1).timeout
		push_text("creating desktop...")
		await get_tree().create_timer(1).timeout
		push_text("done")
		await get_tree().create_timer(1).timeout

		$"../..".change_to_packed(next_scene)

	else:
		push_text("incorrect, enter hex key: __ __ __ __")
