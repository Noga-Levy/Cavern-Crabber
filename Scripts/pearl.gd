extends Node2D

var selected = false

signal pause()
signal unpause()
signal down_pressed()

var frames = []

var animation_complete = false
var down_arrow_pressed = false


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
			connect("animation_finished", turn_animation_true())
			connect("down_pressed", turn_down_arrow_true())
			frame.play()
			await (animation_complete or down_arrow_pressed)
		
		await get_tree().create_timer(1).timeout
		print("next frame")
		if frame is RichTextLabel:
			frame.hide()
	
	$Talk.hide()
	emit_signal("unpause")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("arrow-down"):
		emit_signal("down_pressed")


func turn_animation_true():
	animation_complete = true


func turn_down_arrow_true():
	down_arrow_pressed = true
