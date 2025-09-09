extends Area2D

var start_pos = Vector2(0, 0)
var credits_pos = Vector2(0, 0)


func _on_start_send_pos(pos: Variant) -> void:
	start_pos = pos


func _on_credits_send_pos(pos: Variant) -> void:
	print(credits_pos, pos)
	credits_pos = pos


func _ready() -> void:
	position = start_pos


func _process(_delta: float) -> void:
	if position == start_pos and Input.is_key_pressed(KEY_DOWN):
		position = credits_pos
	
	elif position == credits_pos and Input.is_key_pressed(KEY_UP):
		position = start_pos


func _on_start_selected() -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_credits_selected() -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
