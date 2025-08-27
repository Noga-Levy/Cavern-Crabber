extends RichTextLabel

var enemies_total
var enemies

func _ready() -> void:
	enemies_total = get_tree().get_nodes_in_group("Enemy").size()
	enemies = enemies_total
	self.text = "ENEMIES LEFT: {0}/{1}".format([str(enemies), str(enemies_total)])
	position.x = -555  # Max: -575
	

func _process(_delta: float) -> void:
	enemies = get_tree().get_nodes_in_group("enemy-of-level").size()
	self.text = "ENEMIES LEFT: {0}/{1}".format([str(enemies), str(enemies_total)])
	position.y = Global.crab_pos[1] - 310  # Max: -325
