extends AudioStreamPlayer


func _on_pearl_unpause() -> void:
	$"level5-bg-music".play(Global.music_pos)


func _on_pearl_pause() -> void:
	Global.music_pos = $"level5-bg-music".get_playback_position()
