extends Label

var start_msec:int
var timer_running

func start_timer():
	start_msec = Time.get_ticks_msec()
	timer_running = true
	show()

func _process(delta: float) -> void:
	if !timer_running: return
	var elapsed := Time.get_ticks_msec() - start_msec
	var seconds = elapsed / 1000
	var minutes = seconds / 60
	seconds = seconds % 60
	var seconds_str := "0%d" % seconds if seconds < 10 else str(seconds)
	var minutes_str := "0%d" % minutes if minutes < 10 else str(minutes)

	text = minutes_str + ":" + seconds_str
	Global.elapsed_msec = elapsed
