extends LineEdit

@onready var textedit:TextEdit = %TextEdit

var max_lines := 16
var lines := 0

func _on_text_submitted(new_text: String) -> void:
	text = ""
	textedit.text += "\n > " + new_text
	lines = 0
	var l := textedit.text.split("\n")
	var remove := l.size() - max_lines
	if remove > 0:
		for i in remove:
			l.remove_at(0)
	textedit.text = "\n".join(l)
