extends CharacterBody2D
class_name Enemy

@export var ACCELERATION: int = 1000
@export var MAX_SPEED: int = 1000
@export var FRICTION: int = 0.9
@export var ROTATIONSPEED: int = 10
@export var MAXHEALTH: int = 20

var can_shoot = true
var guns = []
var health = MAXHEALTH
var player = null
var index = 0
var dir = 1
var spawnPoint = Vector2.ZERO
var wanderPoint = Vector2.ZERO

var rng = RandomNumberGenerator.new()

#var velocity = Vector2.ZERO

@onready var Pistol = preload("res://Guns//Pistol.tscn")
@onready var Shotgun = preload("res://Guns//Shotgun.tscn")

func _init(array, array2, center, radius):
	spawnPoint = global_position
	wanderPoint = spawnPoint
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

func _follow(delta):
	if($Line2D.points.size() > 1):
		if($Line2D.points[index].distanceTo(global_position) <= 16):
			if(index == $Line2D.points.size() - 1 and dir == 1):
				dir = -1
			elif (index == 0 and dir == -1):
				dir = 1 
			index += dir
			
		var input_vector = $Line2D.points[index] - global_position
		input_vector = input_vector.normalized()
		if input_vector != Vector2.ZERO:
			velocity += input_vector * ACCELERATION * delta
			velocity = velocity.limit_length(MAX_SPEED)
		else:
			pass
		velocity = velocity * 0.9
	else:
		if(wanderPoint.distance_to(global_position) <= 16):
			wanderPoint = spawnPoint + Vector2(rng.randi_range(-100, 100), rng.randi_range(-100, 100))
		
		var input_vector = wanderPoint - global_position
		input_vector = input_vector.normalized()
		if input_vector != Vector2.ZERO:
			velocity += input_vector * ACCELERATION * delta * 1/4
			velocity = velocity.limit_length(MAX_SPEED * 1/4)
		else:
			pass
		velocity = velocity * 0.9
	

func _process(delta):
	var angle2 = atan2(velocity.y, velocity.x)*180/PI + 90
	$Sprite2D.rotation_degrees = angle2
	$Pivot.rotation_degrees = angle2
