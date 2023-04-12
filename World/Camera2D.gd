extends Camera2D

var target = null
	
func _process(delta):
	if target != null:
		transform = target.transform
