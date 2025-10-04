extends Area2D


func _process(_delta: float) -> void:
	if self.is_visible_in_tree():
		if Input.is_action_just_released("arrow-right") and position.x < 220:
			position = Vector2(position.x + 370, position.y)
			$"Change-button".play()
		
		elif Input.is_action_just_released("arrow-left") and position.x > -145:
			position = Vector2(position.x - 370, position.y)
			$"Change-button".play()


func _on_yep_selected() -> void:
	if Input.is_action_just_pressed("space") and self.is_visible_in_tree():
		$"Select-button".play()
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_nope_selected() -> void:
	if Input.is_action_just_pressed("space") and self.is_visible_in_tree():
		$"Select-button".play()
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/basics-of-dungeoneering.tscn")
