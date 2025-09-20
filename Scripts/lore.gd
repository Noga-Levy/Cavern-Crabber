extends Node2D

var frames = []
var next_frame = false
var special_frames = []
var last_frame

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("frame"):
		frames.append(str(i.name))
		var current_frame = get_node(str(i))
		current_frame.hide()
		print(i.name)
	
	special_frames = [$Text5, $Text6]
	last_frame = frames[-1]
	
	frame_sequence()


func frame_sequence():
	for j in frames:
		next_frame = false
		while next_frame == false:
			var frame_of_interest = get_node(j)
			frame_of_interest.show()
			if frame_of_interest in special_frames:
				next_frame = true
				
			elif frame_of_interest.name == last_frame:
				await get_tree().create_timer($AudioStreamPlayer2D.stream.get_length() - $AudioStreamPlayer2D.get_playback_position()).timeout
				next_frame = true
			
			else:
				await get_tree().create_timer(3).timeout
				next_frame = true
		
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
