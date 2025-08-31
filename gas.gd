extends Area2D


func _ready() -> void:
	print("Gas is monitoring:", monitoring, " monitorable:", monitorable)


func _on_body_entered(body: Node2D) -> void:
	print("{body} is in the gas".format([body.name], "{body}"))
	if body.is_in_group("Player"):
		Global.crabHP -= 5
