extends CharacterBody2D

const SPEED = 500  # pixels per second
var change_amt = 5
var crab_vector = Vector2()
var health = Global.crabHP
var original_color

func _ready():
	original_color = $"Player (Crab)".modulate

func _physics_process(_delta: float) -> void:
	
	if Global.crabHP != health:
		health = Global.crabHP
		$"Player (Crab)".modulate = Color(1, 1, 1, 0.7)
		await get_tree().create_timer(0.5).timeout
		$"Player (Crab)".modulate = original_color
		
		if Global.crabHP <= 0:
			self.queue_free()
			# TODO: Add an end screen
			get_tree().quit()
	
	crab_vector = Vector2.ZERO
	
	if Input.is_key_pressed(KEY_DOWN):
		crab_vector.y += change_amt
		$"Player (Crab)".play("walking_down")
	if Input.is_key_pressed(KEY_UP):
		crab_vector.y -= change_amt
		$"Player (Crab)".play("walking_forwards")
	
	if Input.is_key_pressed(KEY_LEFT):
		crab_vector.x -= change_amt
		$"Player (Crab)".play("walking_left")
	if Input.is_key_pressed(KEY_RIGHT):
		crab_vector.x += change_amt
		$"Player (Crab)".play("walking_right")

	# normalize diagonal movement, scale by speed
	if crab_vector != Vector2.ZERO:
		crab_vector = crab_vector.normalized()
	else:
		$"Player (Crab)".stop()

	velocity = crab_vector * SPEED
	move_and_slide()
	Global.crab_pos = position
