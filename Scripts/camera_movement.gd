extends Camera2D


func _process(_delta: float) -> void:
	position.y = Global.crab_pos.y
	if Global.crab_pos.x <= -476:
		position.x = Global.crab_pos.x
	else:
		position.x = 0
