extends CharacterBody2D

var SPEED = Global.crab_SPEED  # pixels per second
var change_amt = 5
var crab_vector = Vector2()
var health = Global.crabHP
var original_color

func _ready():
	$"Player (Crab)".play("walking_down")
	original_color = $"Player (Crab)".modulate
	Global.crabHP = 10 + (Global.level - 1) * 5


func attack():
	var walk_to_atk = {"walking_right" : "attack_right", "walking_left" : "attack_left",
	"walking_forwards" : "attack_up", "walking_down" : "attack_down", "walking_45" : "attack45",
	"walking_315" : "attack315", "walking_225" : "attack225", "walking_135" : "attack135"}
	
	var walking_animations = ["walking_right", "walking_left", "walking_forwards", "walking_down",
	"walking_45", "walking_315", "walking_225", "walking_135"]
	
	var original_animation = $"Player (Crab)".animation
	
	if Input.is_action_pressed("attack") and original_animation in walking_animations:
		$"Player (Crab)".play(walk_to_atk[original_animation])


func _physics_process(_delta: float) -> void:
	
	if Global.crabHP != health:
		health = Global.crabHP
		$"Player (Crab)".modulate = Color(1, 1, 1, 0.7)
		await get_tree().create_timer(0.5).timeout
		$"Player (Crab)".modulate = original_color
	
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
	
	attack()
	
	# normalize diagonal movement, scale by speed
	if crab_vector != Vector2.ZERO:
		crab_vector = crab_vector.normalized()
	else:
		$"Player (Crab)".stop()

	velocity = crab_vector * SPEED
	move_and_slide()
	Global.crab_pos = position


# To show the game over scene, we need to call this outside of _physics_process
func _process(_delta: float) -> void:
	if Global.crabHP <= 0:
		self.queue_free()
		get_tree().change_scene_to_file("res://Scenes/game-over-lost.tscn")
