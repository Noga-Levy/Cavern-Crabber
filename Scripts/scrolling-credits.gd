extends RichTextLabel


var current_line = 0


func _process(_delta):
	if Input.is_action_pressed("arrow-down"):
		current_line = max(current_line + 0.5, 0)
		scroll_to_line(current_line)
	elif Input.is_action_pressed("arrow-up"):
		current_line = min(current_line - 0.5, get_line_count() - 0.5)
		scroll_to_line(current_line)
