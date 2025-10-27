extends Node2D

var selected = false

signal pause()
signal unpause()
signal down_pressed()

var frames = []


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Pearl.play("highlight")
		selected = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Pearl.play("default")
		selected = false


func _process(_delta: float) -> void:
	if selected and Input.is_action_just_released("space"):
		print("play pearl")
		emit_signal("pause")
		play_discussion()
	
	if $"Talk/Animation-for-text".is_visible_in_tree():
		$"Talk/Animation-for-text".play("default")


func play_discussion():
	$Talk.hide()
	for child in $Talk.get_children(true):
		child.hide()
		frames.append(child)
		for grandchild in child.get_children():
			grandchild.hide()
			frames.append(grandchild)
	
	$Talk.show()
	$Camera2D.make_current()
	for frame in frames:
		frame.show()
		
		if frame is AnimatedSprite2D:
			frame.play()
			await down_pressed # or animation complete, but I'll add that later
		else:
			await down_pressed
		
		print("next frame")
		if frame is RichTextLabel:
			frame.hide()
	
	$Talk.hide()
	emit_signal("unpause")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("arrow-down"):
		emit_signal("down_pressed")
