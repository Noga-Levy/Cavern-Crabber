extends Area2D

# Health
var health = 13
var total_health = 13
var inside_bleeg = []
signal send_health(health, total_health)  # Custom signal

# Movement
var direction = 1  # x direction
var SPEED = 7
var rng = RandomNumberGenerator.new()  # To generate the y direction
var random_integer  # To save the y direction

func _ready() -> void:
	# Connecting signals to functions so that I can control what happens when I receive the signal
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	print("Connected enter")
	connect("body_exited", Callable(self, "_on_body_exited"))
	print("Connected exit")
	send_health.emit(health, total_health)

func attack():
	await get_tree().create_timer(0.7).timeout
	if inside_bleeg.size() > 0:
		Global.crabHP -= 3

func _on_Area2D_body_entered(body: Node2D):
	print("A body entered the warble: " + body.name)
	
	# Getting damaged
	if body.is_in_group("damager"):
		inside_bleeg.append(body)
		print("Added {body} to array 'inside_bleeg'".format([body], "{body}"))
		attack()
	
	# Turning around
	if body.is_in_group("border"):
		direction *= -1
		random_integer = rng.randi_range(1, 2)  # 1 is true, 2 is false
		
		# Animation
		if direction == -1:
			$Bleeg.play("left")
		else:
			$Bleeg.play("right")
		
func _on_body_exited(body: Node2D):
	print("A body exited the bleeg: " + body.name)
	
	if body.is_in_group("damager"):
		inside_bleeg.erase(body)
		print("Erased {body} from array 'inside_bleeg'".format([body], "{body}"))

func _process(_delta: float) -> void:
	
	if inside_bleeg.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= 4
		print(health)
		if health <= 0:
			self.queue_free()
	
	send_health.emit(health, total_health)
	
	position.x += direction * SPEED
	if random_integer == 1:
		position.y += direction * SPEED/2
	else:
		position.y -= direction * SPEED/2
	
	if direction == -1:
		$Bleeg.play("left")
	else:
		$Bleeg.play("right")
