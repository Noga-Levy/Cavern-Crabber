extends CharacterBody2D

const SPEED = 500  # pixels per second
var change_amt = 5
var crab_vector = Vector2()

func _physics_process(delta: float) -> void:
	crab_vector = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_DOWN):
		crab_vector.y += change_amt
	if Input.is_key_pressed(KEY_UP):
		crab_vector.y -= change_amt
	
	if Input.is_key_pressed(KEY_LEFT):
		crab_vector.x -= change_amt
	if Input.is_key_pressed(KEY_RIGHT):
		crab_vector.x += change_amt

	# normalize diagonal movement, scale by speed
	if crab_vector != Vector2.ZERO:
		crab_vector = crab_vector.normalized()

	velocity = crab_vector * SPEED
	move_and_slide()
	Global.crab_pos = position
