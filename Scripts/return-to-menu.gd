extends Area2D


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		$"Select-button".play()
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
