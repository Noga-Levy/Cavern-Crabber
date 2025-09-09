extends AudioStreamPlayer2D

func _ready() -> void:
	self.play(Global.music_pos)

func _process(_delta: float) -> void:
	Global.music_pos = self.get_playback_position()
