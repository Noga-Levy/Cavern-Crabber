extends CharacterBody2D

var bleeg_Vec = Vector2(0,0)
var SPEED = 500
var xdir = -1
var ydir = -1

func _process(delta: float) -> void:
	bleeg_Vec[0] += 1
	bleeg_Vec[1] += 1
	
	# normalize diagonal movement, scale by speed
	if bleeg_Vec != Vector2.ZERO:
		bleeg_Vec = bleeg_Vec.normalized()
	else:
		$Bleeg.stop()
	
	velocity = SPEED * bleeg_Vec
	move_and_slide()


func _on_collision_area_entered(area: Area2D) -> void:
	if area.is_in_group("border"):
		if area.is_in_group("l-border"):
			xdir = 1
			ydir = -1
		elif area.is_in_group("r-border"):
			xdir = -1
			ydir = 1
		elif area.is_in_group("b-border"):
			xdir = 1
			ydir = 1
		else:
			xdir = -1
			ydir = -1
