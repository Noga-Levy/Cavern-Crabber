extends Area2D


var inside_lava = false
var burn_cd = 0.0  # cd = cooldown
var death_cd = 10.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside_lava = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside_lava = false


# Damagers --> Lavas
func destroy_lava():
	await get_tree().create_timer(10).timeout
	$lava.queue_free()
	print("lava gone")


func _process(delta: float) -> void:
	death_cd -= delta
	if death_cd <= 0:
		self.queue_free()
	
	if inside_lava:
		burn_cd -= delta
		if burn_cd <= 0.0:
			print("Ouch!")
			Global.crabHP -= 5
			burn_cd = 2.0  # reset cooldown
