extends RichTextLabel

var current_tries_left
var num_xs = ""

func _ready() -> void:
	current_tries_left = Global.tries_left
	
	for i in current_tries_left:
		num_xs += "X"
	
	
	self.text = "TRIES LEFT: {}".format([num_xs], "{}")
	position.x = -555  # Max: -575
	

func _process(_delta: float) -> void:
	if Global.tries_left < current_tries_left:
		num_xs = num_xs.substr(0, len(num_xs) - 1)
		current_tries_left = Global.tries_left
	
	self.text = "TRIES LEFT: {}".format([num_xs], "{}")
	
	position.y = Global.crab_pos[1] - 270  # Max: -325
	
	if Global.crab_pos.x <= -480:
		position.x = Global.crab_pos.x - 555
	
	elif Global.crab_pos.x >= 470:
		position.x = Global.crab_pos.x - 555
	
	else:
		position.x = -555 
