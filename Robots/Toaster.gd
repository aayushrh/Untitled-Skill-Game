extends Player

func initialize(array, array2):
	#for i in range(-360, 360, 5):
		#array.append("Shotgun")
		#array2.append(i)
	super._initialize(array, array2, Vector2(0, 0), 17)
	
func _on_Hurtbox_area_entered(area):
	area._kill()
	PManager.health -= area.damage
	if PManager.health <= 0 :
		emit_signal("pdeath")
		queue_free()
	
func _on_Timer2_timeout():
	can_shoot = true

func _on_EnemyDetection_body_entered(body):
	print("add")
	enemies.append(body)

func _on_EnemyDetection_body_exited(body):
	enemies.remove(enemies.find(body))
