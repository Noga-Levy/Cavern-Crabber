extends Node2D

var frames = []
var next_frame = false
var special_frames = []
var last_frame
var is_down_pressed = Input.is_action_just_pressed("arrow-down")
signal down_pressed()


func _ready() -> void:
	for i in get_tree().get_nodes_in_group("frame"):
		frames.append(str(i.name))
		var current_frame = get_node(str(i))
		current_frame.hide()
		print(i.name)
	
	last_frame = frames[-1]
	
	frame_sequence()


func frame_sequence():
	for j in frames:
		var frame_of_interest = get_node(j)
		frame_of_interest.show()
		await down_pressed
		
	if get_tree().current_scene.name == "basics-of-dungeoneering":
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow-down"):
		emit_signal("down_pressed", is_down_pressed)
	
