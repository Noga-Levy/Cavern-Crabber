extends CharacterBody2D

# Movement
var limmi_Vec = Vector2(0,0)
var SPEED = 1000
var xdir = -1
var ydir = -1
var dodge = false

# Attack
var inside_limmi = []

# Health
var health = 20
var total_health = 20
signal send_health(HP, total_HP)

func _physics_process(_delta: float) -> void:
	limmi_Vec = Vector2(xdir, ydir)
	
	# normalize diagonal movement, scale by speed
	if limmi_Vec != Vector2.ZERO:
		limmi_Vec = limmi_Vec.normalized()
	else:
		$limmi.stop()
	
	velocity = SPEED * limmi_Vec
	move_and_slide()
	
	if inside_limmi.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= 5
	
	send_health.emit(health, total_health)


func _process(_delta: float) -> void:
	if health <= 0:
		self.queue_free()
		
	if Input.is_action_pressed("dodge"):
		start_dodge()


func start_dodge():
	dodge = true
	await get_tree().create_timer(0.5).timeout  # duration of dodge window
	dodge = false


func attack():
	await get_tree().create_timer(0.3).timeout
	
	if inside_limmi.size() > 0 and not dodge:
		Global.crabHP -= 6
	
	if xdir == -1:
		$limmi.play("left")
	else:
		$limmi.play("right")


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border") or body.is_in_group("Bleeg"):
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
