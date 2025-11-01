extends Area2D

var start_pos = Vector2(0, 0)


func _on_start_send_pos(pos: Variant) -> void:
	start_pos = pos


func _ready() -> void:
	position = start_pos
	if not Global.is_en_at_the_beginning:
		TranslationServer.set_locale("en")
		Global.is_en_at_the_beginning = true


func _process(_delta: float) -> void:
	if Input.is_action_just_released("arrow-down") and position.y < 120:
		position = Vector2(position.x, position.y + 70)
		$"Change-button".play()
	
	elif Input.is_action_just_released("arrow-up") and position.y > -20:
		position = Vector2(position.x, position.y - 70)
		$"Change-button".play()


func _on_start_selected() -> void:
	if Input.is_action_just_pressed("space"):
		$"Select-button".play()
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")
		Global.music_pos = 0


func _on_credits_selected() -> void:
	if Input.is_action_just_pressed("space"):
		$"Select-button".play()
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_switch_lang_selected() -> void:
	if Input.is_action_just_pressed("space"):
		var switch_lang_button = get_parent().get_node("SwitchLang/RichTextLabel")
		
		$"Select-button".play()
		if TranslationServer.get_locale() == "en":
			TranslationServer.set_locale("jp")
			switch_lang_button.text = "[color=black][font_size=30]英語/English[/font_size][/color]"
		else:
			TranslationServer.set_locale("en")
			switch_lang_button.text = "[color=black][font_size=30]Japanese/日本語[/font_size][/color]"
