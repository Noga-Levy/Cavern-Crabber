extends AnimatedSprite2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		$"snap-sound".play()
		# Somehow, this section makes the snap sound better
		if Input.is_key_pressed(KEY_A):
			$"snap-sound".stop()
			$"snap-sound".play()
	
	if Input.is_key_pressed(KEY_D):
		$dodge_whoosh.play()
		if Input.is_key_pressed(KEY_D):
			$dodge_whoosh.play()
			$dodge_whoosh.stop()
