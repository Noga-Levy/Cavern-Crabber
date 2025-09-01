extends Node2D

func _ready() -> void:
	$AudioStreamPlayer2D.play()

# Whole sequence boils down to "detect an input --> is the input a key pressed --> ok, restart"
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		Global.crabHP = 10
		Global.level = 1
		Global.crab_pos = Vector2(0, 0)
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
