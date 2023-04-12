extends CharacterBody2D
class_name Player

@export var ACCELERATION: int = 1000
@export var MAX_SPEED: int = 1000
@export var FRICTION: int = 0.9
@export var ROTATIONSPEED: int = 10

var firing1 = false
var firing2 = false
var can_shoot = true
var guns = []
var gunsString = []
var offset = 0
var enemies = []

signal pdeath
signal stashed(things)

#var velocity = Vector2.ZERO

@onready var Pistol = preload("res://Guns//Pistol.tscn")
@onready var Shotgun = preload("res://Guns//Shotgun.tscn")

func _initialize(array, array2, center, radius):
	$Marker2D.position = center
	gunsString = array
	for i in range(len(array)):
		var gun = null
		match array[i]:
			"Pistol":
				gun = load("res://Guns//Pistol.tscn").instantiate()
			"Shotgun":
				gun = load("res://Guns//Shotgun.tscn").instantiate()
		if gun != null:
			gun.position += Vector2(cos(array2[i]*(PI/180))*radius, sin(array2[i]*(PI/180))*radius)
			guns.append(gun)
			$Marker2D.add_child(gun)
	
func _process(delta):
	var angle2 = atan2(velocity.y, velocity.x)*180/PI + 90
	$Sprite2D.rotation_degrees = angle2
	#rotateToAngle($Sprite2D, angle2, delta)
	var mouse_pos = get_global_mouse_position()
	var angle = atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x)
	$Marker2D.rotation_degrees = fmod((angle * 180/PI + offset), 360.0)
	#rotateToAngle($Marker2D, angle, delta)
	for i in guns:
		var angleg = atan2(mouse_pos.y - i.global_position.y, mouse_pos.x - i.global_position.x) * 180/PI - $Marker2D.rotation_degrees
		i.rotation_degrees = angleg
		
	if Input.is_action_just_pressed("shoot_1"):
		firing1 = true
	elif Input.is_action_just_released("shoot_1"):
		firing1 = false
	if firing1 and can_shoot:
		guns[0].shoot_over($Marker2D.rotation_degrees + guns[0].rotation_degrees)
		can_shoot = false
		$Timer2.start(0.3)
		
	if Input.is_action_just_pressed("shoot_2"):
		firing2 = true
	elif Input.is_action_just_released("shoot_2"):
		firing2 = false
	if firing2 and can_shoot and guns.size() > 1:
		guns[1].shoot_over($Marker2D.rotation_degrees + guns[1].rotation_degrees)
		can_shoot = false
		$Timer2.start(0.3)
		
	PManager.Pposition = global_position
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("game_right") - Input.get_action_strength("game_left")
	input_vector.y = Input.get_action_strength("game_down") - Input.get_action_strength("game_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED)
	else:
		pass
	velocity = velocity * 0.9
	if(!PManager.pause):
		set_velocity(velocity)
		move_and_slide()
		velocity = velocity

func rotateToAngle(thing, target, delta):
	if(abs(thing.rotation_degrees - target) > 1):
		thing.rotate(sign(target) * min(delta * ROTATIONSPEED, abs(target)))

func rotateToTarget(thing, target, delta):
	var direction = (target - thing.global_position)
	var angleTo = 0
	angleTo = thing.transform.x.angle_to(direction)
	thing.rotate(sign(angleTo) * min(delta * ROTATIONSPEED, abs(angleTo)))

func _on_Hurtbox_area_entered(area):
	area._kill()
	PManager.health -= area.damage
	if PManager.health <= 0 :
		emit_signal("pdeath")
		queue_free()

func _on_Timer2_timeout():
	can_shoot = true

func _on_EnemyDetection_body_entered(body):
	enemies.append(body)

func _on_EnemyDetection_body_exited(body):
	enemies.remove(body)
