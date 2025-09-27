extends CharacterBody2D

# Movement
var limmi_Vec = Vector2(0,0)
var SPEED = 1000
var xdir = -1
var ydir = -1

# Attack
var inside_limmi = []
var damaged = Global.crab_damage

# Health
var health = 25
var total_health = 25
signal send_health(HP, total_HP)

# Lava
var time = 0


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
	
	time += _delta
	if time > 4:
		create_lava()
		time = 0


func _process(_delta: float) -> void:
	if health <= 0:
		create_new_limmi()
		self.queue_free()


# DAMAGE WHATNOT
func damaged_animation():
	$damaged.show()
	$damaged.play("default")
	await get_tree().create_timer(0.5).timeout
	$damaged.hide()
	

func create_lava():
	var lava_scene = preload("res://Scenes/lava.tscn")
	var lava_instance = lava_scene.instantiate()
	
	get_tree().root.get_node("level3").add_child(lava_instance)
	
	lava_instance.position = position
	lava_instance.scale = Vector2(1.5, 1.5)


func create_new_limmi():
	var limmi_scene = preload("res://Scenes/limmis/limmi_without_ball.tscn")
	var limmi_instance = limmi_scene.instantiate()
	
	get_tree().root.get_node("level3").add_child(limmi_instance)
	limmi_instance.position = position
	if $limmi.animation == "left":
		limmi_instance.get_node("limmi").play("left")
	else:
		limmi_instance.get_node("limmi").play("right")
	
	limmi_instance.modulate = "f200ea"
	limmi_instance.scale = Vector2(1.5, 1.5)


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

func _on_collision_body_exited(body: Node2D) -> void:
	if body.is_in_group("damager"):
		inside_limmi.erase(body)
