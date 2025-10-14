extends Node2D


var ghost_list = [1, 2]
var ghost_cd_starting_num = 5
var ghost_cd = ghost_cd_starting_num


func create_ghost1():
	var ghost_scene = preload("res://Scenes/Ghosts/ghost_1.tscn")
	var ghost_instance = ghost_scene.instantiate()
	
	get_tree().root.get_node("level4").add_child(ghost_instance)
	
	ghost_instance.position = self.position
	

func create_ghost2():
	var ghost_scene = preload("res://Scenes/Ghosts/ghost_2.tscn")
	var ghost_instance = ghost_scene.instantiate()
	
	get_tree().root.get_node("level4").add_child(ghost_instance)
	
	ghost_instance.position = self.position


func _process(delta: float) -> void:
	ghost_cd -= delta
	
	if ghost_cd <= 0:
		var chosen_ghost = ghost_list[randi() % ghost_list.size()]
		if chosen_ghost == 1:
			create_ghost1()
		elif chosen_ghost == 2:
			create_ghost2()
		else:
			print("Error: chosen_ghost " + str(chosen_ghost) + " does not exist")
		
		ghost_cd = ghost_cd_starting_num
	
