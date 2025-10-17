extends Node2D

var enemy_info = ""
var previous_text = ""
var stream_text_finished = false
var all_info_shown = false
var info

var darkness_increase_amt = 0.01
var blink_increments = 101


func _ready() -> void:
	
	$Darkness.modulate[3] = 1
	
	$"Elevator music by Cisco".play(Global.music_pos)
	
	end_blink()
	
	var level_colors = {1 : "ffffff", 2 : "95ffff", 3 : "fda9a6", 4 : "ffff50"}
	$"Ground-in-between-levels".modulate = level_colors[Global.level - 1]
	
	$Enemy_info.text = enemy_info
	info = [$Name, $DMG, $DMG_Method]
	
	var enemies_names = {1: "Warbles", 2 : "Bleegs", 3 : "Limmis", 4 : "The Relu"}
	$Name.text = "[font_size=23][color=darkblue]Name\n" + enemies_names[Global.level - 1] + "[/color][/font_size]"
	
	var damage_amts = {1 : "2", 2 : "4", 3 : "1", 4 : "Relus 3, Sost 4"}
	$DMG.text = "[font_size=23][color=red]DMG\n" + damage_amts[Global.level - 1] + "[/color][/font_size]"
	
	var dmg_method = {1 : "Their tail springs out, cutting all nearby creatures",
	2 : "They produce the level's gas, choking nearby creatures",
	3 : "They summon lava that burns those in contact. The bigger ones bite once they lose their ball",
	4 : "The relu shoots bullets.\nThe sosts stab with their spears"}
	$DMG_Method.text = "[font_size=20][color=darkred]DMG method\n" + dmg_method[Global.level - 1] + "[/color][/font_size]"
	
	
	for i in info:
		i.hide()
		print(info)

func stream_level_done():
	for i in "Enemy Info":
		enemy_info = "[font_size=30][color=black]" + previous_text + i + "[/color][/font_size]"
		await get_tree().create_timer(0.05).timeout
		$Enemy_info.text = enemy_info
		previous_text += i

func show_all_info():
	info = [$Name, $DMG, $DMG_Method]
	for i in info:
		if is_inside_tree():
			await get_tree().create_timer(0.5).timeout
			i.show()
		else:
			pass


func _process(_delta: float) -> void:
	if not stream_text_finished:
		stream_level_done()
		stream_text_finished = true
	
	elif not all_info_shown:
		await get_tree().create_timer(0.5).timeout
		show_all_info()
		all_info_shown = true


func end_blink():
	for i in range(blink_increments):
		$Darkness.modulate[3] -= darkness_increase_amt
		await get_tree().create_timer(darkness_increase_amt).timeout



func _input(_event):
	if Input.is_action_just_released("space"):
		
		if Global.level == 4:
			get_tree().change_scene_to_file("res://Scenes/level_4.tscn")
		elif Global.level == 3:
			get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
