extends Node2D


var shoot = true
var interval_between_shots = 2
var health = 10

var shoot_cd = 2

func create_bullet(degrees_of_rotation):
	var bullet = preload("res://Scenes/bullet.tscn")
	var bullet_instance = bullet.instantiate()
	
	get_tree().root.get_node("level4").add_child(bullet_instance)
	
	bullet_instance.rotation = degrees_of_rotation
	bullet_instance.position = self.position


func shoot_bullet():
	if health > 0:
		if interval_between_shots > 0.03:
			interval_between_shots *= 0.5
			print(interval_between_shots)
			
		for i in range(0, 360, 20):
			create_bullet(i)
			await get_tree().create_timer(interval_between_shots).timeout

func _process(delta: float) -> void:
	if shoot_cd > 0:
		shoot_cd -= delta
		if shoot_cd <= 0:
			shoot_bullet()
			shoot_cd = interval_between_shots * 18
	
	if health <= 0:
		self.queue_free()
