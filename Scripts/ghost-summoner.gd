extends Node2D


var cd_amount_opts = [3, 4, 5]
var ghost_cd_starting_num = cd_amount_opts[randi() % cd_amount_opts.size()]
var ghost_cd = ghost_cd_starting_num


func _ready() -> void:
	$Portal.play("default")


func create_evil_spirit():
	$Portal.play("activating")
	await get_tree().create_timer(0.3).timeout
	
	var ghost_scene = preload("res://Scenes/Ghosts/evil_spirit.tscn")
	var ghost_instance = ghost_scene.instantiate()
	
	var root_node = get_tree().current_scene
	get_tree().root.get_node(NodePath(root_node.name)).add_child(ghost_instance)
	
	ghost_instance.position = self.position
	
	$Portal.play_backwards("activating")
	await get_tree().create_timer(0.3).timeout
	$Portal.play("default")

func _process(delta: float) -> void:
	ghost_cd -= delta
	
	if ghost_cd <= 0:
		create_evil_spirit()
		ghost_cd = ghost_cd_starting_num
	
