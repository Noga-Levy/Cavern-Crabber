extends Node2D

var frames = []
var next_frame = false
var special_frames = []
signal down_pressed()

signal pause()
signal unpause()
var touching_player
var cutscene_in_progress = false

var memories = []
var memories_to_levels
var memory_of_interest

var mushroom


func _ready() -> void:
	if Global.level == 2:
		mushroom = get_node("Half-eaten-mushroom")
		$Mushroom.hide()
		$"Half-eaten-mushroom".show()
	else:
		mushroom = get_node("Mushroom")
		$Mushroom.show()
		$"Half-eaten-mushroom".hide()
	
	$RichTextLabel.hide()
	$AudioStreamPlayer.stop()
	
	for i in get_tree().get_nodes_in_group("memory"):
		i.hide()
		memories.append(i)
		print("Hidden: ", i)
	
	memories_to_levels = {1 : memories[0], 2 : memories[1], 3 : memories[2], 4 : memories[3]}
	
	memory_of_interest = memories_to_levels[Global.level]
	
	for j in get_tree().get_nodes_in_group("frame"):
		if j in memory_of_interest.get_children():
			frames.append(j)
			j.hide()
			print(j.name)


func frame_sequence():
	cutscene_in_progress = true
	emit_signal("pause")
	
	$Camera2D.make_current()
	
	$RichTextLabel.show()
	$AudioStreamPlayer.play()
	
	memory_of_interest.show()
	
	for k in frames:
		k.show()
		print(k)
		
		await down_pressed
	
	$RichTextLabel.hide()
	$AudioStreamPlayer.stop()
	
	for k in frames:
		k.hide()
	
	emit_signal("unpause")
	cutscene_in_progress = false


func memory4_sequence():
	cutscene_in_progress = true
	emit_signal("pause")
	
	$Camera2D.make_current()
	
	$RichTextLabel.text = "This memory will auto-play"
	$RichTextLabel.show()
	$AudioStreamPlayer.play()
	
	memory_of_interest.show()
	
	var counter = 1
	
	for k in frames:
		k.show()
		print(k)
		
		if counter <= 2:
			await get_tree().create_timer(1.8).timeout
		elif counter <= 4:
			await get_tree().create_timer(0.7).timeout
		else:
			await get_tree().create_timer(7).timeout
		
		counter += 1
	
	$RichTextLabel.hide()
	$AudioStreamPlayer.stop()
	
	for k in frames:
		k.hide()
	
	emit_signal("unpause")
	cutscene_in_progress = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		mushroom.play("highlight")
		touching_player = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		mushroom.play("default")
		touching_player = false


func _process(_delta: float) -> void:
	if Input.is_action_just_released("arrow-down") and touching_player:
		emit_signal("down_pressed")
		print("down is pressed")

func _input(_event: InputEvent) -> void:
	if touching_player and Input.is_action_just_released("space") and not cutscene_in_progress:
		if memory_of_interest != memories[3]:
			frame_sequence()
		else:
			memory4_sequence()
