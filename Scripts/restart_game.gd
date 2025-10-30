extends Node2D

var levels


func _ready() -> void:
	levels = {1 : "res://Scenes/level_1.tscn",
	 2 : "res://Scenes/level_2.tscn",
	 3 : "res://Scenes/level_3.tscn",
	 4 : "res://Scenes/level_4.tscn",
	 5 : "res://Scenes/level_5.tscn"}
	
	var length = $AudioStreamPlayer2D.stream.get_length()
	
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(length).timeout
	
	$AudioStreamPlayer2D.stream = load("res://Audio/bg-music/game_lost_song.mp3")
	$AudioStreamPlayer2D.play()

# Whole sequence boils down to "detect an input --> is the input a key pressed --> ok, restart"
func _process(_delta: float) -> void:
	if Input.is_action_pressed("space"):
		Global.crabHP = Global.level * 5 + 5
		Global.crab_damage = Global.level + 2
		Global.crab_SPEED = 500 + (Global.level - 1) * 100
		Global.crab_modulate = "ffffff"
		Global.crab_pos = Vector2(0, 0)
		get_tree().change_scene_to_file(levels[Global.level])
