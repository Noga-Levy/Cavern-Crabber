extends Node2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()

# Whole sequence boils down to "detect an input --> is the input a key pressed --> ok, restart"
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Global.crabHP = 10
			Global.level = 1
			Global.crab_pos = Vector2(0, 0)
			get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
