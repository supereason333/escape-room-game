extends Node3D

signal updated(value:int)
signal turned_on
signal turned_off

@export var target_value := 0
@export var levers:Array[Node3D]
@export var selecters:Array[Select3D]

var lever_switch_dist := -0.05 / 100

var values := [0, 0, 0]
var on := false

func _ready() -> void:
	if selecters.size() != levers.size():
		printerr("Levers and selectors arr size different")
		return
	values.resize(levers.size())
	values.fill(1)
	for i in selecters.size():
		selecters[i].triggered.connect(switch.bind(i))

func switch(_p, lever:int):
	values[lever] = wrapi(values[lever] + 1, 0, 3)
	var pos:float = (values[lever] - 1) * lever_switch_dist
	create_tween().tween_property(levers[lever], "position:z", pos, 0.2)

	var total := 0
	for i in values.size():
		total += values[i] * pow(3, i)

	if total == target_value:
		turned_on.emit()
		on = true
	elif on:
		turned_off.emit()

	updated.emit(total)
