extends CharacterBody2D

# Movement
var warble_Vec = Vector2(0,0)
var SPEED = 500
var xdir = 1

# Attack
var inside_warble = []
var ypos
var dodge = false

# Health
var health = 6
var total_health = 6
signal send_health(HP, total_HP)

func _ready() -> void:
	$e_warble.play("right")
	ypos = position.y
	

func _physics_process(_delta: float) -> void:
	warble_Vec = Vector2(xdir, 0)
	
	# normalize diagonal movement, scale by speed
	if warble_Vec != Vector2.ZERO:
		warble_Vec = warble_Vec.normalized()
	else:
		$e_warble.stop()
	
	velocity = SPEED * warble_Vec
	move_and_slide()
	
	if inside_warble.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= 3
	
	send_health.emit(health, total_health)


func _process(_delta: float) -> void:
	if health <= 0:
		self.queue_free()
	
	if Input.is_action_pressed("dodge"):
		start_dodge()


func start_dodge():
	dodge = true
	await get_tree().create_timer(0.1).timeout  # duration of dodge window
	dodge = false


func attack():
	await get_tree().create_timer(0.6).timeout
		
	if xdir == -1:
		$e_warble.play("left-attack")
	else:
		$e_warble.play("right-attack")
	
	$attack.play()
	
	await get_tree().create_timer(0.4).timeout
	
	if inside_warble.size() > 0 and dodge == false:
		Global.crabHP -= 2
	
	if xdir == -1:
		$e_warble.play("left")
	else:
		$e_warble.play("right")


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border"):
		xdir *= -1
		
		if xdir < 0:
			$e_warble.play("left")
		else:
			$e_warble.play("right")
	
	if body.is_in_group("damager"):
		inside_warble.append(body)
		attack()

func _on_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("damager"):
		inside_warble.erase(body)
