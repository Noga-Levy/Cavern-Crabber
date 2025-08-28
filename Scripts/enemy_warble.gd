extends Area2D

# Health
var health = 6
var total_health = 6
var inside_warble = []
signal send_health(HP, total_HP)  # Custpm signal

# Movement
var direction = 1
var SPEED = 5

func _ready() -> void:
	# Connecting signals to functions so that I can control what happens when I receive the signal
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	print("Connected enter")
	connect("body_exited", Callable(self, "_on_body_exited"))
	print("Connected exit")

func attack():
	await get_tree().create_timer(1.0).timeout
	if inside_warble.size() > 0:
		Global.crabHP -= 2

func _on_Area2D_body_entered(body: Node2D):
	print("A body entered the warble: " + body.name)
	
	# Getting damaged
	if body.is_in_group("damager"):
		inside_warble.append(body)
		print("Added {body} to array 'inside_warble'".format([body], "{body}"))
		attack()
	
	# Turning around
	if body.is_in_group("border"):
		direction *= -1
		
		# Animation
		if direction == -1:
			$e_warble.play("left")
		else:
			$e_warble.play("right")
		
func _on_body_exited(body: Node2D):
	print("A body exited the warble: " + body.name)
	
	if body.is_in_group("damager"):
		inside_warble.erase(body)
		print("Erased {body} from array 'inside_warble'".format([body], "{body}"))

func _process(_delta: float) -> void:
	
	if inside_warble.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= Global.crabDMG
		print(health)
		if health <= 0:
			self.queue_free()
	
	send_health.emit(health, total_health)
	
	position.x += direction * SPEED
