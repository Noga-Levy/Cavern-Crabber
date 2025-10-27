extends Sprite2D


func _process(_delta: float) -> void:
	position.y = Global.crab_pos.y
	position.x = Global.crab_pos.x
	Global.music_pos = $"level5-bg-music".get_playback_position()
