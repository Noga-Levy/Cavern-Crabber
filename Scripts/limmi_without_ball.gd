extends CharacterBody2D

# Movement
var limmi_Vec = Vector2(0,0)
var SPEED = 1000
var xdir = -1
var ydir = -1

# Attack
var inside_limmi = []
var damaged = Global.crab_damage
var dodge = false

# Health
var health = 7
var total_health = 7
signal send_health(HP, total_HP)


# PROCESSES
func _physics_process(_delta: float) -> void:
	
	damaged = Global.crab_damage
	
	limmi_Vec = Vector2(xdir, ydir)
	
	# normalize diagonal movement, scale by speed
	if limmi_Vec != Vector2.ZERO:
		limmi_Vec = limmi_Vec.normalized()
	else:
		$limmi.stop()
	
	velocity = SPEED * limmi_Vec
	move_and_slide()
	
	if inside_limmi.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= damaged
		damaged_animation()
	
	send_health.emit(health, total_health)


func _process(_delta: float) -> void:
	if health <= 0:
		self.queue_free()
	
	if Input.is_action_pressed("dodge"):
		start_dodge()


# DAMAGE WHATNOT
func damaged_animation():
	$damaged.show()
	$damaged.play("default")
	await get_tree().create_timer(0.5).timeout
	$damaged.hide()


func start_dodge():
	dodge = true
	await get_tree().create_timer(1.5).timeout  # duration of dodge window
	dodge = false


func attack():
	await get_tree().create_timer(0.3).timeout
	
	$chomp.play()
	
	"""if xdir == -1:
		$limmi.play("left-attack")
	else:
		$limmi.play("right-attack")"""
	
	await get_tree().create_timer(0.2).timeout
	
	if inside_limmi.size() > 0 and not dodge:
		Global.crabHP -= 5
	
	if xdir == -1:
		$limmi.play("left")
	else:
		$limmi.play("right")


# COLLISION
func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border") or body.is_in_group("limmi"):
		xdir *= -1
		ydir = randi_range(-1, 1)
		
		if xdir < 0:
			$limmi.play("left")
		else:
			$limmi.play("right")
	
	if body.is_in_group("damager"):
		inside_limmi.append(body)
		attack()

func _on_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("damager"):
		inside_limmi.erase(body)
