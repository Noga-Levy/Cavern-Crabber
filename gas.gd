extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("{body} is in the gas".format([body], "{body}"))
	if body.is_in_group("Player"):
		Global.crabHP -= 5
