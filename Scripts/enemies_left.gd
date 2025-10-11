extends RichTextLabel

var enemies_total
var enemies

func _ready() -> void:
	if Global.level != 4:
		enemies_total = get_tree().get_nodes_in_group("Enemy").size()
		enemies = enemies_total
		self.text = "ENEMIES LEFT: {0}/{1}".format([str(enemies), str(enemies_total)])
	
	else:
		$Timer.start()
		self.text = "TIME LEFT: " + str(snapped($Timer.time_left, 0.1))
	
	position.x = -555  # Max: -575
	

func _process(_delta: float) -> void:
	if Global.level != 4:
		enemies = get_tree().get_nodes_in_group("enemy-of-level").size()
		self.text = "ENEMIES LEFT: {0}/{1}".format([str(enemies), str(enemies_total)])
	else:
		self.text = "TIME LEFT: " + str(snapped($Timer.time_left, 0.1))
	
	position.y = Global.crab_pos[1] - 310  # Max: -325
	position.x = Global.crab_pos.x - 555


func _on_timer_timeout() -> void:
	Global.is_timer_zero = true
