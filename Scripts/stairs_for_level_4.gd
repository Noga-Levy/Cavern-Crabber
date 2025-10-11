extends Node2D


func _process(_delta: float) -> void:
	if Global.is_timer_zero:  # if timer is out
		$BrownStairs.show()
		$LockedStairs.hide()
		
		if 1 == 1:  # if end-whatnot made ready (it's not yet)
			$warning.hide()
			$msg_from_dev.show()
		else:
			$warning.text = "Next level unlocked"
		
	else:
		$LockedStairs.show()
		$BrownStairs.hide()
		$warning.show()
		

func switch_levels():
	get_tree().change_scene_to_file("res://Scenes/scroll.tscn")


func _on_body_entered(_body: Node2D) -> void:
	print("body entered")
	
	if Global.is_timer_zero:  # if timer == 0
		call_deferred("switch_levels")
