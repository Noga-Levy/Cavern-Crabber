extends AudioStreamPlayer2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_D):
		play()
		# Somehow, this section makes the snap sound better
		if Input.is_key_pressed(KEY_D):
			stop()
			play()
