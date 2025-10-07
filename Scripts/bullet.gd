extends CharacterBody2D

var speed = 3600  # It needs to be surprisingly fast


func get_input():
	velocity = transform.x * speed * (-1)  # Negative goes to the left


# Function to make the bullet actually move
func _physics_process(_delta):
	get_input()
	move_and_slide()


# Function to make the bullet deal damage and then disappear
func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.crabHP -= 3
	
	self.queue_free()
