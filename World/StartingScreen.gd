extends Node2D

func _on_Button_pressed():
	PManager.Pposition = Vector2.ZERO
	PManager.pause = false
	PManager.materials = 200
	get_tree().change_scene_to_file("res://World/World.tscn")
