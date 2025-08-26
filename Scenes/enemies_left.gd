extends RichTextLabel


func _ready() -> void:
	var enemies = get_tree().get_nodes_in_group("warble").size()
	self.text = "ENEMIES LEFT: " + str(enemies)
	position.x = -555  # Max: -575
	

func _process(delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("warble").size()
	self.text = "ENEMIES LEFT: " + str(enemies)
	position.y = Global.crab_pos[1] - 310  # Max: -325
