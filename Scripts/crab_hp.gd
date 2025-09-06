extends RichTextLabel

var total_HP

func _ready() -> void:
	total_HP = Global.crabHP
	self.text = "HP: {0}/{1}".format([Global.crabHP, total_HP])
	position.x = -555  # Max: -575
	

func _process(_delta: float) -> void:
	self.text = "HP: {0}/{1}".format([Global.crabHP, total_HP])
	position.y = Global.crab_pos[1] - 290  # Max: -325
	
	if Global.crab_pos.x <= -480:
		position.x = Global.crab_pos.x - 555
	
	elif Global.crab_pos.x >= 470:
		position.x = Global.crab_pos.x - 555
	
	else:
		position.x = -555 
