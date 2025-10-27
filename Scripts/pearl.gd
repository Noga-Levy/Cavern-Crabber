extends Node2D

var selected = false

signal pause()
signal unpause()
signal down_pressed()

var frames = []

signal signal_sent()


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


func play_discussion():
	$Talk.hide()
	frames = []
	for child in $Talk.get_children(true):
		child.hide()
		frames.append(child)
		for grandchild in child.get_children():
			grandchild.hide()
			frames.append(grandchild)
	
	
	$BGmusic.play(Global.music_pos)
	$Talk.show()
	$Camera2D.make_current()
	for frame in frames:
		frame.show()
		
		if not frame.is_in_group("skippable"):
			if frame is AnimatedSprite2D:
				if not down_pressed.is_connected(signal_done) and not frame.animation_finished.is_connected(signal_done):
					frame.animation_finished.connect(signal_done)
					down_pressed.connect(signal_done)
				
				frame.play()
				
				await signal_sent
				
			else:
				await down_pressed
		
		print("next frame")
		if frame is RichTextLabel:
			frame.hide()
	
	$Talk.hide()
	Global.music_pos = $BGmusic.get_playback_position()
	$BGmusic.stop()
	emit_signal("unpause")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("arrow-down"):
		emit_signal("down_pressed")


func signal_done():
	emit_signal("signal_sent")
