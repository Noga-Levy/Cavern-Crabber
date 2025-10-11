extends CharacterBody2D


var relu_Vec = Vector2(0, 0)
var SPEED = 1000
var xdir = -1
var ydir = -1
var move = false


var shoot = true
var interval_between_shots = 2

var shoot_cd = 2

var angles = ["45", "90", "135", "180", "225", "270", "315", "360"]


func create_bullet(degrees_of_rotation):
	var bullet = preload("res://Scenes/bullet.tscn")
	var bullet_instance = bullet.instantiate()
	
	get_tree().root.get_node("level4").add_child(bullet_instance)
	
	bullet_instance.rotation = degrees_of_rotation
	
	bullet_instance.position = self.position


func shoot_bullet():
	move = false
	if interval_between_shots > 0.03:
		interval_between_shots *= 0.5
		print(interval_between_shots)
		
	
	for a in angles:
		create_bullet(deg_to_rad(int(a)))
		$"relu-sprite".play(a)
		print(a)
		await get_tree().create_timer(interval_between_shots).timeout
	
	move = true

func _process(delta: float) -> void:
	if shoot_cd > 0:
		shoot_cd -= delta
		if shoot_cd <= 0:
			shoot_bullet()
			shoot_cd = interval_between_shots * 18


func get_direction_name(direction: Vector2) -> String:

	var degrees = rad_to_deg(direction.angle())
	
	if degrees < 0:
		degrees += 360

	if degrees < 22.5 or degrees >= 337.5:
		return "180"
	elif degrees < 67.5:
		return "225"
	elif degrees < 112.5:
		return "270"
	elif degrees < 157.5:
		return "315"
	elif degrees < 202.5:
		return "360"
	elif degrees < 247.5:
		return "45"
	elif degrees < 292.5:
		return "90"
	else:
		return "135"


func _physics_process(delta: float) -> void:
	Global.crab_SPEED = 1000
	if move == true:
		
		var direction = (Global.crab_pos - global_position).normalized()
		
		velocity = direction * (SPEED * 15) * delta
		
		move_and_slide()
		
		var direction_animation = get_direction_name(direction)
		$"relu-sprite".play(direction_animation)
		
	else:
		velocity = Vector2.ZERO
		move_and_slide()
	
