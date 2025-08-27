extends Node2D

var enemies

func _ready() -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	

func _process(_delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("Enemy").size()
	if enemies == 0:
		$BrownStairs.show()
		$LockedStairs.hide()
		$warning.hide()
		Global.move_to_next_level = true
	else:
		$LockedStairs.show()
		$BrownStairs.hide()
		$warning.show()
		
