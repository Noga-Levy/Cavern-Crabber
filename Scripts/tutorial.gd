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
		
		var text_node_path = "{}/RichTextLabel".format([frame_of_interest.name], "{}")
		var frame_text = get_node(text_node_path)
		var original_text = frame_text.text.substr(14, frame_text.text.length() - 12 - 14)
		var original_text_with_bbcode = frame_text.text
		frame_text.text = frame_text.text.substr(0, 14) + frame_text.text.substr(frame_text.text.length() - 12, frame_text.text.length())
		
		frame_of_interest.show()
		
		for letter in original_text:
			print(letter)
			frame_text.text = frame_text.text.substr(0, frame_text.text.length() - 12) + letter + frame_text.text.substr(frame_text.text.length() - 12, frame_text.text.length())
			await get_tree().create_timer(0.05).timeout
				
			
		await down_pressed
		
	if get_tree().current_scene.name == "basics-of-dungeoneering":
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("arrow-down"):
		emit_signal("down_pressed", is_down_pressed)
	
