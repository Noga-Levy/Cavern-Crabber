extends AudioStreamPlayer


func _on_pearl_unpause() -> void:
	self.play(Global.music_pos)


func _process(_delta: float) -> void:
	Global.music_pos = self.get_playback_position()
