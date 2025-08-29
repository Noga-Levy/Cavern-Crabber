extends CharacterBody2D

const SPEED = 500  # pixels per second
var change_amt = 5
var crab_vector = Vector2()
var health = Global.crabHP
var original_color

func _ready():
	original_color = $"Player (Crab)".modulate
	Global.crabHP = 10 + (Global.level - 1) * 5

func _physics_process(_delta: float) -> void:
	
	if Global.crabHP != health:
		health = Global.crabHP
		$"Player (Crab)".modulate = Color(1, 1, 1, 0.7)
		await get_tree().create_timer(0.5).timeout
		$"Player (Crab)".modulate = original_color
		
		if Global.crabHP <= 0:
			self.queue_free()
			# TODO: Add an end screen and level up screen
			get_tree().quit()
	
	crab_vector = Vector2.ZERO
	
	var left = Input.is_key_pressed(KEY_LEFT)
	var right = Input.is_key_pressed(KEY_RIGHT)
	var up = Input.is_key_pressed(KEY_UP)
	var down = Input.is_key_pressed(KEY_DOWN)
	var direction_array = [left, right, up, down]
	
	if direction_array.count(true) >= 2:
		if left and down:
			$"Player (Crab)".play("walking_45")
			crab_vector.x -= change_amt
			crab_vector.y += change_amt
		if right and down:
			$"Player (Crab)".play("walking_315")
			crab_vector.x += change_amt
			crab_vector.y += change_amt
		
		if left and up:
			$"Player (Crab)".play("walking_135")
			crab_vector.x -= change_amt
			crab_vector.y -= change_amt
		if right and up:
			$"Player (Crab)".play("walking_225")
			crab_vector.x += change_amt
			crab_vector.y -= change_amt	
		
	else:
		if Input.is_key_pressed(KEY_DOWN):
			crab_vector.y += change_amt
			$"Player (Crab)".play("walking_down")
		elif  Input.is_key_pressed(KEY_UP):
			crab_vector.y -= change_amt
			$"Player (Crab)".play("walking_forwards")
		
		elif  Input.is_key_pressed(KEY_LEFT):
			crab_vector.x -= change_amt
			$"Player (Crab)".play("walking_left")
		elif Input.is_key_pressed(KEY_RIGHT):
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
