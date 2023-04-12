extends Sprite2D

@onready var V1_image = preload("res://Robots//Toaster.png")
@onready var V2_image = preload("res://Robots//Roomba.png")

@onready var Pistol = preload("res://Guns//Pistol.tscn")
@onready var Shotgun = preload("res://Guns//Shotgun.tscn")

func _update_image(type, weapons, angles):
	var offset
	for i in get_children():
		i.queue_free()
	match type:
		"V1":
			texture = V1_image
			offset = 130
		"V2":
			texture = V2_image
			offset = 120
	for i in range(len(weapons)):
		var gun
		match weapons[i]:
			"Pistol":
				gun = Pistol.instantiate()
			"Shotgun":
				gun = Shotgun.instantiate()
		gun.position += Vector2(cos((angles[i] + 270)*(PI/180))*offset, sin((angles[i] + 270)*(PI/180))*offset)
		gun.rotation_degrees = 270
		gun.scale = Vector2(10, 10)
		add_child(gun)
			
