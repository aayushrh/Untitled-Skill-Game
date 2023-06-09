extends CharacterBody2D

@export var speed := 500

var damage = 0
var direction = Vector2.ZERO
var counter = 0
var lifetime = 0

func _init():
	velocity = direction * speed
	rotation_degrees = atan2(velocity.y, velocity.x)*180/PI + 90

func _process(_delta):
	move_and_slide()
	_updateLife()
	if(counter == 1):
		$Area2D.damage = damage
	counter += 1

func _updateLife():
	if(lifetime <= 0):
		queue_free()
	lifetime -= 1

func _on_world_body_entered(body):
	queue_free()
	
func _kill():
	queue_free()
