extends Node2D

var selected = false

signal pause()
signal unpause()
signal down_pressed()

var frames = []


func _ready() -> void:
	$Talk.hide()
	for child in $Talk.get_children(true):
		child.hide()
		frames.append(child)
		for grandchild in child.get_children():
			grandchild.hide()
			frames.append(grandchild)


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
		emit_signal("pause")
		play_discussion()


func play_discussion():
	for frame in frames:
		frame.show()
		if frame is AnimatedSprite2D:
			frame.play()
		


func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("arrow-down"):
		emit_signal("down_pressed")
