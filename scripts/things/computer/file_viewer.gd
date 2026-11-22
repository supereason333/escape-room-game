extends Window

func show_window():
	if visible:
		position = Vector2i.ONE * 32
	show()

func close_window():
	hide()
