extends Area2D

var start_pos = Vector2(0, 0)


func _on_start_send_pos(pos: Variant) -> void:
	start_pos = pos


func _ready() -> void:
	position = start_pos


func _process(_delta: float) -> void:
	if Input.is_action_just_released("arrow-down") and position.y < 70:
		position = Vector2(position.x, position.y + 90)
	
	elif Input.is_action_just_released("arrow-up") and position.y > -20:
		position = Vector2(position.x, position.y - 90)


func _on_start_selected() -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")


func _on_credits_selected() -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
