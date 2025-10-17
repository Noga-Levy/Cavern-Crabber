extends AudioStreamPlayer2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_action_pressed("dodge"):
		play()
		# Somehow, this section makes the snap sound better
		if Input.is_action_pressed("dodge"):
			stop()
			play()
