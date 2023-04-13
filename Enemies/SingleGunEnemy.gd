extends Enemy

@export var startingGuns := ["Shotgun"]

func _init():
	pass
	
func _initialize():
	super._init(startingGuns, [0], Vector2(0, 0), 17)

func _process(delta):
	super._process(delta)
	if(player != null):
		var input_vector = player.global_position - global_position
		input_vector = input_vector.normalized()
		if input_vector != Vector2.ZERO:
			velocity += input_vector * ACCELERATION * delta
			velocity = velocity.limit_length(MAX_SPEED)
		else:
			pass
		velocity = velocity * 0.9
		$Marker2D.rotation_degrees = atan2(velocity.y, velocity.x)*180/PI
		if(can_shoot):
			guns[0].shoot_over($Marker2D.rotation_degrees, false)
			can_shoot = false
			$Timer.start(0.5)
	else:
		super._follow(delta)
		
	move_and_slide()

func _on_timer_timeout():
	can_shoot = true

func _on_hurtbox_area_entered(area):
	area._kill()
	health -= area.damage
	print(str(health) + " health")
	if health <= 0:
		queue_free()

func _on_player_detection_body_entered(body):
	player = body

func _on_vision_body_exited(body):
	player = null
