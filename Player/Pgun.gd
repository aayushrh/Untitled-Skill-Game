extends Node2D
class_name PGun

const Bullet = preload("res://Player/PBullet.tscn")
const Pbulletimage = preload("res://Player/Pbullet.png")

var reload_time
var clip
var shot = 0
var can_shoot

func _initialize(nclip, nreload):
	clip = nclip - 1
	reload_time = nreload
	can_shoot = true

func _process(delta):
	if !can_shoot:
		$ColorRect.size.x = (($Timer.time_left)/reload_time) * 30

func shoot(angle, final, long = true):
	if can_shoot:
		$ColorRect.size.x = 0
		if final:
			shot += 1
		var b = Bullet.instantiate()
		if !long:
			b.lifetime = 15
		b.damage = randi()
		var world = get_tree().current_scene
		world.add_child(b)
		b.direction = Vector2(cos(angle * PI/180), sin(angle * PI/180))
		#b.rotation_degrees = angle
		b.global_position = $firepoint.global_position
		b._init()
		if final:
			if shot > clip:
				$Timer.start(reload_time)
				can_shoot = false
				shot = 0

func _on_Timer_timeout():
	can_shoot = true
