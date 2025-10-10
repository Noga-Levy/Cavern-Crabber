extends Node2D

var enemies
var current_level = Global.level
var change_level = current_level
var proceed_to_next_level = true
var unreachable_level = 5


func _ready() -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	

func _process(_delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	if enemies == 0:
		$BrownStairs.show()
		$LockedStairs.hide()
		
		if change_level == unreachable_level:
			$warning.hide()
			$msg_from_dev.show()
		else:
			$warning.text = "Next level unlocked"
		
			if proceed_to_next_level:
				change_level += 1
				proceed_to_next_level = false
		
	else:
		$LockedStairs.show()
		$BrownStairs.hide()
		$warning.show()
		

func switch_levels():
	if change_level < unreachable_level:
		get_tree().change_scene_to_file("res://Scenes/scroll.tscn")


func _on_body_entered(_body: Node2D) -> void:
	print("body entered")
	if change_level > current_level:
		
		call_deferred("switch_levels")
