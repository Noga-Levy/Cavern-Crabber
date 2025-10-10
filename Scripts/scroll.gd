extends Node2D

var level_done = ""
var previous_text = ""
var stream_text_finished = false
var all_info_shown = false
var info


func _ready() -> void:
	Global.level += 1
	
	var level_colors = {1 : "ffffff", 2 : "95ffff", 3 : "fda9a6", 4 : "ffff50"}
	$"Ground-in-between-levels".modulate = level_colors[Global.level]
	
	$Level_complete.text = level_done
	info = [$HP, $DMG, $SPEED, $Next_Enemy]
	
	$HP.text = "[font_size=40][color=darkgreen]HP[/color][/font_size]\n[color=darkgreen][font_size=20]" + str(Global.level * 5) + " -> " + str(Global.level * 5 + 5) + "[/font_size][/color]"
	
	$DMG.text = "[font_size=40][color=darkred]DMG[/color][/font_size]\n[color=darkred][font_size=20]" + str(Global.level + 1) + " -> " + str(Global.level + 2) + "[/font_size][/color]"
	Global.crab_damage = Global.level + 2
	
	
	$SPEED.text = "[font_size=40][color=orange]SPEED[/color][/font_size]\n[color=orange][font_size=20]" + str(500 + (Global.level - 2) * 100) + " -> " + str(500 + (Global.level - 1) * 100) + "[/font_size][/color]"
	Global.crab_SPEED = 500 + (Global.level - 1) * 100
	Global.crab_modulate = "ffffff"
	
	var enemies = ["Warbles", "Bleegs", "Limmis", "Relu"]
	$Next_Enemy.text = "[font_size=25][color=black]NEXT UP: " + enemies[Global.level - 1] + "[/color][/font_size]\n[color=black]Press space to continue[/color]"
	
	
	for i in info:
		i.hide()

func stream_level_done():
	for i in "Level complete":
		level_done = "[font_size=30][color=black]" + previous_text + i + "[/color][/font_size]"
		await get_tree().create_timer(0.05).timeout
		$Level_complete.text = level_done
		previous_text += i

func show_all_info():
	for i in info:
		await get_tree().create_timer(0.5).timeout
		i.show()

func _process(_delta: float) -> void:
	if not stream_text_finished:
		stream_level_done()
		stream_text_finished = true
	
	elif not all_info_shown:
		await get_tree().create_timer(0.5).timeout
		show_all_info()
	

func _input(_event):
	if Input.is_action_just_released("space"):
		if Global.level == 4:
			get_tree().change_scene_to_file("res://Scenes/level_4.tscn")
		elif Global.level == 3:
			get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
