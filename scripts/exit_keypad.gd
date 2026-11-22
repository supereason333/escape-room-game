extends Control

@export var key:String

@onready var line_edit:LineEdit = %LineEdit
@onready var bottom_button:Button = %BottomButton
@onready var label:Label = %Label
@onready var enter_button:Button = %EnterButton
@onready var color_rect:ColorRect = %ColorRect

var is_final := false
var unlocked := false
var state := 0

var wrong_texts := [
	"WRONG!!!!",
	"wrong",
	"thats, not correct",
	"Congrats, you got it wrong",
	"you really thought it was that easy?",
	"incorrect",
	"loud incorrect buzzer",
	"not right",
	"pro tip: don't try that again",
	"hmm somethings not up, try thinking about it"
]

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == key:
		correct()
	else:
		wrong()

func _on_enter_button_pressed() -> void:
	if line_edit.text == key:
		correct()
	else:
		wrong()

func wrong():
	label.text = wrong_texts[randi_range(0, wrong_texts.size() - 1)]
	label.modulate = Color.RED

func correct():
	label.text = "Finally, you got it"
	label.modulate = Color.GREEN
	line_edit.editable = false
	enter_button.disabled = true
	await get_tree().create_timer(1).timeout
	unlocked = true
	bottom_button.text = "So...."

func _on_bottom_button_pressed() -> void:
	if !unlocked: return
	match state:
		0:
			bottom_button.text = "You really think youve done it"
		1:
			bottom_button.text = "Are you sure thats correct"
		2:
			bottom_button.text = "It just seems a bit simple..."
		3:
			bottom_button.text = "Answer to everything..."
		4:
			bottom_button.text = "Is just that"
		5:
			bottom_button.text = "Well, if youre sure then continue"
		6:
			bottom_button.text = "I wont hold you here anymore"
		_:
			final()
	state += 1

func final():
	if is_final: return
	is_final = true
	color_rect.show()
	await create_tween().tween_property(color_rect, "color:a", 1, 2).finished
	get_tree().change_scene_to_file("uid://cwg6mfrvh2te2")

func _unhandled_input(_event: InputEvent) -> void:
	if unlocked: get_viewport().set_input_as_handled()
