extends Node2D

var level_done = ""
var previous_text = ""
var stream_text_finished = false
var all_info_shown = false
var info

func _ready() -> void:
	$Level_complete.text = level_done
	info = [$HP, $DMG, $SPEED, $Special_Abilities, $Next_Enemy]
	
	$HP.text = "[font_size=25][color=darkgreen]HP[/color][/font_size]\n[color=darkgreen]" + str(Global.level * 5 + 5) + " -> " + str(Global.level * 5 + 10) + "[/color]"
	
	$DMG.text = "[font_size=25][color=darkred]DMG[/color][/font_size]\n[color=darkred]" + str(Global.level + 2) + " -> " + str(Global.level + 3) + "[/color]"
	
	$SPEED.text = "[font_size=25][color=orange]SPEED[/color][/font_size]\n[color=orange]" + str(500 + (Global.level - 1) * 100) + " -> " + str(500 + Global.level * 100) +"[/color]"
	Global.crab_SPEED = 500 + Global.level * 100
	
	$Special_Abilities.text = "[font_size=25][color=blue]SPECIALS/NEW[/color][/font_size]\n[color=blue]" + Global.special_abilities + "[/color]"
	
	var enemies = ["Warbles", "Bleegs"]
	$Next_Enemy.text = "[font_size=25][color=black]NEXT UP: " + enemies[Global.level - 1] + "[/color][/font_size]\n[color=black]Press any key to continue[/color]"
	
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

func _process(delta: float) -> void:
	if not stream_text_finished:
		stream_level_done()
		stream_text_finished = true
	
	elif not all_info_shown:
		await get_tree().create_timer(0.5).timeout
		show_all_info()
	

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if Global.level == 2:
				get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
