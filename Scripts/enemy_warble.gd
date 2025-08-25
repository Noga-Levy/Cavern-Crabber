extends Area2D
	
var health = 3
var inside_warble = []

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	print("Connected enter")
	connect("body_exited", Callable(self, "_on_body_exited"))
	print("Connected exit")

func _on_Area2D_body_entered(body: Node2D):
	# 'body' is a reference to the Node2D that entered the area.
	print("A body entered the warble: " + body.name)
	
	if body.is_in_group("damager"):
		inside_warble.append(body)
		print("Added {body}".format([body], "{}"))
		
func _on_body_exited(body: Node2D):
	print("A body exited the warble: " + body.name)
	
	if body.is_in_group("damager"):
		inside_warble.erase(body)
		print("Erased {body}".format([body], "{}"))

func _process(delta: float) -> void:
	if inside_warble.size() > 0 and Input.is_action_just_pressed("attack"):
		health -= 3
		print(health)
		if health <= 0:
			self.queue_free()
			
