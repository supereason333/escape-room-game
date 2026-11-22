extends Window

@export var target_dir:StringName

@onready var path_label:Label = %PathLabel
@onready var file_disp:GridContainer = %Files
@onready var file_viewer:Window = %FileViewer

var path:StringName

func show_window():
	if visible:
		position = Vector2i.ONE * 32
	reset_files()
	show()

func close_window():
	hide()

func reset_files():
	path = ""
	update()

func up_one():
	if path.length() > 0:
		path = path.left(-1)
		update()

func update():
	path_label.text = "/" + "/".join(path.split(""))
	for child in file_disp.get_children(): child.queue_free()
	var is_targ := path == target_dir.left(target_dir.length() - 1)
	var last := target_dir.right(1)
	for i in 10:
		var btn := Button.new()
		btn.custom_minimum_size = Vector2i.ONE * 64
		if is_targ and str(i) == last:
			btn.text = str(i) + ".png"
			btn.pressed.connect(file_viewer.show_window)
			file_disp.add_child(btn)
			continue
		btn.text = "/" + str(i)
		btn.pressed.connect(down_one.bind(str(i)))
		file_disp.add_child(btn)

func down_one(dir:StringName):
	path += dir.left(1)
	update()
