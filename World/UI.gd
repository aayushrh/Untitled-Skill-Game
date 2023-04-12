extends Control

var time_spent = 0

func _process(delta):
	if(!PManager.pause):
		$ColorRect.size.x = ((PManager.health*100)/PManager.max_health)
		time_spent += delta
		if fmod(time_spent, 60) >= 10:
			$Time.text = (str(floor(time_spent/60)) + ":" + str(floor(fmod(time_spent, 60))))
		else:
			$Time.text = (str(floor(time_spent/60)) + ":0" + str(floor(fmod(time_spent, 60))))
		$Materials.text =str(PManager.materials)
	$RespawnUI/Materials.text = str(PManager.materials)
