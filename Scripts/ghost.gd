extends CharacterBody2D


# Movement
var dir_opts = [1, -1]
var SPEED = 1000
var xdir = dir_opts[randi() % dir_opts.size()]
var ydir = dir_opts[randi() % dir_opts.size()]
var ghost_Vec = Vector2(xdir,ydir)
var crab_nearby = false


# Attack
var inside_ghost = []
var dodge = false


# Health
var health_opts = [5, 10, 15]
var health = health_opts[randi() % health_opts.size()]

var total_health = health
var damaged = Global.crab_damage
signal send_health(HP, total_HP)

func _physics_process(_delta: float) -> void:
	
	damaged = Global.crab_damage
	
	var crab_direction = (Global.crab_pos - global_position).normalized()
	
	if crab_nearby:
		ghost_Vec = crab_direction
	else:
		ghost_Vec = Vector2(xdir, ydir)
	
	# normalize diagonal movement, scale by speed
	if ghost_Vec != Vector2.ZERO:
		ghost_Vec = ghost_Vec.normalized()
	else:
		$Ghost.stop()
	
	velocity = SPEED * ghost_Vec
	move_and_slide()
	
	if inside_ghost.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= damaged
		damaged_animation()
	
	send_health.emit(health, total_health)
	
	if ghost_Vec.x < 0:
		$Ghost.play("left")
	else:
		$Ghost.play("right")


func _process(_delta: float) -> void:
	if health <= 0:
		open_death_anim()
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
	
	if xdir == -1:
		$Ghost.play("left-attack")
	else:
		$Ghost.play("right-attack")
	
	$Stab.play()
	
	await get_tree().create_timer(0.2).timeout
	
	if inside_ghost.size() > 0 and not dodge:
		Global.crabHP -= 4
	
	if xdir == -1:
		$Ghost.play("left")
	else:
		$Ghost.play("right")


func open_death_anim():
	var death_scene = preload("res://Scenes/death_animation.tscn")
	var death_instance = death_scene.instantiate()
	
	get_tree().root.get_node("level4").add_child(death_instance)
	
	death_instance.position = position
	death_instance.modulate = "ffb1b2"


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("border") or body.is_in_group("Ghost"):
		xdir *= -1
		ydir = randi_range(-1, 1)
		$GhostBody.scale.x *= -1
		$Collisions.scale.x *= -1
		
		if xdir < 0:
			$Ghost.play("left")
		else:
			$Ghost.play("right")
	
	if body.is_in_group("damager"):
		inside_ghost.append(body)
		attack()


func _on_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("damager"):
		inside_ghost.erase(body)


func _on_comfortzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		crab_nearby = true


func _on_comfortzone_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		crab_nearby = false
