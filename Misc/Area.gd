extends Area2D

var damage = 0
var hit = false

func _kill():
	get_parent()._kill()
