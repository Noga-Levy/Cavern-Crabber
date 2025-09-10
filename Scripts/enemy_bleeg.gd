extends CharacterBody2D

# Movement
var bleeg_Vec = Vector2(0,0)
var SPEED = 1000
var xdir = -1
var ydir = -1
var dodge = false

# Attack
var inside_warble = []

# Health
var health = 13
var total_health = 13
signal send_health(HP, total_HP)

func _physics_process(_delta: float) -> void:
	bleeg_Vec = Vector2(xdir, ydir)
	
	# normalize diagonal movement, scale by speed
	if bleeg_Vec != Vector2.ZERO:
		bleeg_Vec = bleeg_Vec.normalized()
	else:
		$Bleeg.stop()
	
	velocity = SPEED * bleeg_Vec
	move_and_slide()
	
	if inside_warble.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= 4
		damaged_animation()
	
	send_health.emit(health, total_health)


func _process(_delta: float) -> void:
	if health <= 0:
		self.queue_free()
		
	if Input.is_action_pressed("dodge"):
		start_dodge()


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
	
	$hiss.play()
	
	if xdir == -1:
		$Bleeg.play("left-attack")
	else:
		$Bleeg.play("right-attack")
	
	await get_tree().create_timer(0.2).timeout
	
	if inside_warble.size() > 0 and not dodge:
		Global.crabHP -= 4
	
	if xdir == -1:
		$Bleeg.play("left")
	else:
		$Bleeg.play("right")


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border") or body.is_in_group("Bleeg"):
		xdir *= -1
		ydir = randi_range(-1, 1)
		
		if xdir < 0:
			$Bleeg.play("left")
		else:
			$Bleeg.play("right")
	
	if body.is_in_group("damager"):
		inside_warble.append(body)
		attack()

func _on_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("damager"):
		inside_warble.erase(body)
