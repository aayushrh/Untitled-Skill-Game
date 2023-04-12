extends Node2D

@onready var Dissapear = preload("res://DissapearingText.tscn")
@onready var Remote = preload("res://RemoteTransform2D.tscn")
@onready var Roomba = preload("res://Robots//Roomba.tscn")

func _ready():
	$CanvasLayer/UI/RespawnUI.connect("create",Callable(self,"_place_player"))
	$CanvasLayer/UI/RespawnUI._toggle_display(true)

func _pdeath():
	if PManager.pointPlaced:
		$CanvasLayer/UI/RespawnUI._toggle_display(true)
		$Camera2D.target = null
	else:
		get_tree().change_scene_to_file("res://World//StartingScreen.tscn")

func _place_player(player):
	player.global_position = Vector2.ZERO
	$Camera2D.target  = player
	player.connect("pdeath",Callable(self,"_pdeath"))
	get_tree().current_scene.add_child(player)
	$CanvasLayer/UI/RespawnUI._toggle_display(false)
