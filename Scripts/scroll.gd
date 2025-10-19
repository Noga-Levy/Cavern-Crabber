extends Node2D

var level_done = ""
var previous_text = ""
var stream_text_finished = false
var all_info_shown = false
var info

var darkness_increase_amt = 0.01
var blink_increments = 101


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
	
	var enemies = ["Warbles", "Bleegs", "Limmis", "Relu and Sosts"]
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


func begin_blink():
	for i in range(blink_increments):
		if is_inside_tree():
			$Darkness.modulate[3] += darkness_increase_amt
			await get_tree().create_timer(darkness_increase_amt).timeout



func _input(_event):
	if Input.is_action_just_released("space"):
		
		begin_blink()
		
		await get_tree().create_timer(2).timeout
		
		Global.music_pos = $"Elevator music by Cisco".get_playback_position()
		
		get_tree().change_scene_to_file("res://Scenes/scroll_enemy_info.tscn")
