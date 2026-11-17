extends Area3D
class_name Select3D

signal triggered(player:Player)

func trigger(player:Player):
	triggered.emit(player)
