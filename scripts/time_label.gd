extends Label3D

func _ready() -> void:
	var elapsed := Global.elapsed_msec
	var seconds = elapsed / 1000
	var minutes = seconds / 60
	seconds = seconds % 60
	var seconds_str := "0%d" % seconds if seconds < 10 else str(seconds)
	var minutes_str := "0%d" % minutes if minutes < 10 else str(minutes)

	text = "You escaped in " + minutes_str + ":" + seconds_str
