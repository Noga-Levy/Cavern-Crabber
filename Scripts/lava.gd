extends Area2D


var inside_lava = false
var burn_cd = 0.0  # cd = cooldown
var death_cd = 10

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside_lava = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		inside_lava = false


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
