extends Area2D


var touching_player = false
signal pause()
signal unpause()
var get_out = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Mushroom.play("highlight")
		touching_player = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Mushroom.play("default")
		touching_player = false
		


func _process(_delta: float) -> void:
	if touching_player == true and Input.is_action_just_released("space") and get_out == true:
		print("entering")
		emit_signal("pause")
		$"Crab-talk".show()
		$"bg-music".play()
		get_out = false
	
	elif get_out == false and Input.is_action_just_released("space"):
		print("leaving")
		emit_signal("unpause")
		$"Crab-talk".hide()
		$"bg-music".stop()
		get_out = true
