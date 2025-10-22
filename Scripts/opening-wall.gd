extends StaticBody2D



func _on_memories_unpause() -> void:
	if has_node("Opening-wall"):
		$"Opening-wall".queue_free()
		$White4.hide()
		$"Broken-block".show()
