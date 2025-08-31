extends CharacterBody2D

# Movement
var bleeg_Vec = Vector2(0,0)
var SPEED = 500
var xdir = -1
var ydir = -1

# Attack
var inside_warble = []

# Health
var health = 13
var total_health = 13
signal send_health(HP, total_HP)

func _physics_process(delta: float) -> void:
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
	
	send_health.emit(health, total_health)


func _process(delta: float) -> void:
	if health <= 0:
		self.queue_free()


func attack():
	await get_tree().create_timer(0.3).timeout
	
	if xdir == -1:
		$Bleeg.play("left-attack")
	else:
		$Bleeg.play("right-attack")
	
	await get_tree().create_timer(0.2).timeout
	
	if inside_warble.size() > 0:
		Global.crabHP -= 4
	
	if xdir == -1:
		$Bleeg.play("left")
	else:
		$Bleeg.play("right")


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border"):
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
