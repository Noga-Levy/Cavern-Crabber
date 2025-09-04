extends Camera2D


func _process(_delta: float) -> void:
	position.y = Global.crab_pos.y
	
	if Global.crab_pos.x <= -480:
		position.x = Global.crab_pos.x
		
	elif Global.crab_pos.x >= 470:
		position.x = Global.crab_pos.x
		
	else:
		position.x = 0
