extends Node2D


func _on_mush_pause() -> void:
	get_tree().paused = true


func _on_mush_unpause() -> void:
	get_tree().paused = false
	$Camera2D.make_current()
