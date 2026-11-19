extends Node3D

@export var locked := false

var open_depth := 0.5
var initial_x := 0.0
var open := false
var moving := false

func _ready() -> void:
	initial_x = position.x

func interract(_pl:Player):
	if locked: return
	if moving: return
	if open:
		open = false
		moving = true
		create_tween().tween_property(self, "position:x", initial_x, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished.connect(move_stop)
	else:
		open = true
		moving = true
		create_tween().tween_property(self, "position:x", initial_x + open_depth, 0.2).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT).finished.connect(move_stop)

func move_stop():
	moving = false

func unlock():
	locked = false
