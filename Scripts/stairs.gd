extends Node2D

var enemies
var current_level = Global.level
var proceed_to_next_level = true

func _ready() -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	

func _process(_delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	if enemies == 0:
		$BrownStairs.show()
		$LockedStairs.hide()
		
		if Global.level == 3:
			$warning.hide()
			$msg_from_dev.show()
		else:
			$warning.text = "LEVEL UP! DMG + 1, HP + 5, SPEED + 100"
		
			if proceed_to_next_level:
				Global.level += 1
				proceed_to_next_level = false
		
	else:
		$LockedStairs.show()
		$BrownStairs.hide()
		$warning.show()
		

func switch_levels():
	if Global.level == 2:
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")


func _on_body_entered(_body: Node2D) -> void:
	print("body entered")
	if Global.level > current_level:
		
		call_deferred("switch_levels")
