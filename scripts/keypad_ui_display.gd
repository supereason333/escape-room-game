extends Control

signal unlocked

@export var code:String = "1234"

@onready var line_edit:LineEdit = %LineEdit
@onready var grid_container:GridContainer = %GridContainer

var _unlocked := false

func _ready() -> void:
	if _unlocked:
		set_unlocked()
		return
	for btn in grid_container.get_children():
		if btn.name == "Clear":
			btn.pressed.connect(clear)
		elif btn.name == "Enter":
			btn.pressed.connect(enter)
		else:
			btn.pressed.connect(add.bind(btn.name))

func add(text:String):
	if _unlocked: return
	line_edit.text = line_edit.text + text

func clear():
	if _unlocked: return
	line_edit.text = ""

func enter():
	if _unlocked: return
	if line_edit.text == code:
		unlocked.emit()
		set_unlocked()
	else:
		clear()

func set_unlocked():
	_unlocked = true
	line_edit.text = "CORRECT"
