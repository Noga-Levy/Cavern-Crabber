extends Camera2D


func _process(_delta: float) -> void:
	position.y = Global.crab_pos.y
	position.x = Global.crab_pos.x
