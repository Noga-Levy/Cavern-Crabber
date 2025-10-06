extends CharacterBody2D

var speed = 3600

func get_input():
	velocity = transform.x * speed * (-1)

func _physics_process(_delta):
	get_input()
	move_and_slide()


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.crabHP -= 3
	
	self.queue_free()
