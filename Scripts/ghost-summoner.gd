extends Node2D


var cd_amount_opts = [3, 4, 5]
var ghost_cd_starting_num = cd_amount_opts[randi() % cd_amount_opts.size()]
var ghost_cd = ghost_cd_starting_num


func create_evil_spirit():
	var ghost_scene = preload("res://Scenes/Ghosts/evil_spirit.tscn")
	var ghost_instance = ghost_scene.instantiate()
	
	get_tree().root.get_node("level4").add_child(ghost_instance)
	
	ghost_instance.position = self.position


func _process(delta: float) -> void:
	ghost_cd -= delta
	
	if ghost_cd <= 0:
		create_evil_spirit()
		ghost_cd = ghost_cd_starting_num
	
