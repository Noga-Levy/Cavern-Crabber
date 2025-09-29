extends Node2D

var frames = []
var next_frame = false
var special_frames = []
var last_frame
signal down_pressed()

var memories = []
var memories_to_levels
var memory_of_interest



func _ready() -> void:
	for i in get_tree().get_nodes_in_group("memory"):
		i.hide()
		memories.append(i)
		print("Hidden: ", i)
	
	memories_to_levels = {2 : memories[0], 3 : memories[0]}
	
	memory_of_interest = memories_to_levels[Global.level]
	
	for j in get_tree().get_nodes_in_group("frame"):
		if j in memory_of_interest.get_children():
			frames.append(j)
			j.hide()
			print(j.name)
	
	last_frame = frames[-1]
	
	frame_sequence()


func frame_sequence():
	memory_of_interest.show()
	
	for k in frames:
		k.show()
		print(k)
		
		await down_pressed
		
	if Global.level == 2:
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow-down"):
		emit_signal("down_pressed")
