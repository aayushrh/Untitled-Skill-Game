extends Control

signal create(thing)

var new_player_type = ""
var new_player_slots = 0
var new_player_weapons = []
var new_player_angles = []
var pistols = 0
var shotguns = 0
var events = null

@onready var Roomba = preload("res://Robots//Roomba.tscn")
@onready var Toaster = preload("res://Robots//Toaster.tscn")

func _ready():
	visible = false
	
func _input(event):
	events = event

func _process(delta):
	$PistolCount.text = str(pistols)
	$ShotgunCount.text = str(shotguns)

func _toggle_display(change):
	$Preview._update_image(new_player_type, new_player_weapons, new_player_angles)
	visible = change
	PManager.pause = change

func _create():
	if new_player_type != "" and new_player_slots != 0 and new_player_weapons != []:
		var robot = null
		match new_player_type:
			"V1":
				if PManager.materials >= 10:
					PManager.health = 100
					PManager.max_health = 100
					PManager.materials -= 10
					robot = Toaster.instantiate()
			"V2":
				if PManager.materials >= 30:
					PManager.health = 150
					PManager.max_health = 150
					PManager.materials -= 30
					robot = Roomba.instantiate()
		if robot != null:
			robot.initialize(new_player_weapons, new_player_angles)
			emit_signal("create", robot)
			new_player_type = ""
			new_player_slots = 0
			new_player_weapons = []
			new_player_angles = []
	

func _on_V2_pressed():
	new_player_type = "V2"
	new_player_slots = 2
	new_player_angles = [90, 270]
	for i in new_player_weapons:
		match i:
			"Pistol":
				pistols += 1
			"Shotgun":
				shotguns += 1
	new_player_weapons = []
	$Preview._update_image(new_player_type, new_player_weapons, new_player_angles)

func _on_V1_pressed():
	new_player_type = "V1"
	new_player_slots = 1
	new_player_angles = [0]
	for i in new_player_weapons:
		match i:
			"Pistol":
				pistols += 1
			"Shotgun":
				shotguns += 1
	new_player_weapons = []
	$Preview._update_image(new_player_type, new_player_weapons, new_player_angles)

func _on_Pistol_pressed():
	if events.button_index == 1:
		if len(new_player_weapons) + 1 <= new_player_slots:
			if pistols > 0:
				pistols -= 1
				new_player_weapons.append("Pistol")
				$Preview._update_image(new_player_type, new_player_weapons, new_player_angles)
	elif events.button_index == 2:
		print(PManager.materials)
		if PManager.materials >= 10:
			PManager.materials -= 10
			pistols += 1
			

func _on_Shotgun_pressed():
	if events.button_index == 1:
		if len(new_player_weapons) + 1 <= new_player_slots:
			if shotguns > 0:
				shotguns -= 1
				new_player_weapons.append("Shotgun")
				$Preview._update_image(new_player_type, new_player_weapons, new_player_angles)
	elif events.button_index == 2:
		if PManager.materials >= 30:
			PManager.materials -= 30
			shotguns += 1

func _on_Create_pressed():
	_create()
