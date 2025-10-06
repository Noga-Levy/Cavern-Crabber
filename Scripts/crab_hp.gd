extends RichTextLabel

var total_HP

func _ready() -> void:
	total_HP = Global.crabHP
	self.text = "HP: {0}/{1}".format([Global.crabHP, total_HP])
	position.x = Global.crab_pos.x - 555  # Max: -575
	position.y = Global.crab_pos.y - 290  # Max: -325
	

func _process(_delta: float) -> void:
	self.text = "HP: {0}/{1}".format([Global.crabHP, total_HP])
	position.y = Global.crab_pos.y - 290  # Max: -325
	position.x = Global.crab_pos.x - 555
