extends Node2D

var box_closed = true
var colliding_with_box = []
var current_level
var speed_modulate_timer = 0
var damage_modulate_timer = 0


func _ready() -> void:
	current_level = Global.level
	$Box.play("closed")
	$"Health-potion".hide()
	$"Speed-potion".hide()

func _on_body_entered(body: Node2D) -> void:
	colliding_with_box.append(body.name)

func _on_body_exited(body: Node2D) -> void:
	colliding_with_box.erase(body.name)


func speedy_gonzales():
	speed_modulate_timer += 10
	Global.crab_SPEED = Global.crab_SPEED + 200


func protein_shake():
	damage_modulate_timer += 5
	Global.crab_damage = Global.crab_damage + 5

func _process(delta: float) -> void:
	if speed_modulate_timer > 0:
		Global.crab_modulate = "33cc33"
		speed_modulate_timer -= delta
		if speed_modulate_timer <= 0:
			Global.crab_SPEED = Global.crab_SPEED - 200
			Global.crab_modulate = "ffffff"
	
	if damage_modulate_timer > 0:
		Global.crab_modulate = "00ffff"
		damage_modulate_timer -= delta
		if damage_modulate_timer <= 0:
			Global.crab_damage = Global.crab_damage - 5
			if not speed_modulate_timer > 0:  # To avoid the split second of regular color
				Global.crab_modulate = "ffffff"
	
	if Input.is_key_pressed(KEY_SPACE) and box_closed and "Player" in colliding_with_box:
		$Box.play("opened")
		print("opened")
		
		var rng = RandomNumberGenerator.new()
		var random_integer = rng.randi_range(1, 3)
		
		if random_integer == 1:
			$"Health-potion".show()
		
			$Box/RichTextLabel.text = "You got a health potion! All HP has been restored"
			if Global.level == current_level:
				Global.crabHP = Global.level * 5 + 5
			else:
				Global.crabHP = (Global.level - 1) * 5 + 5
		
		elif random_integer == 2:
			$"Speed-potion".show()
			$Box/RichTextLabel.text = "You got a speed potion! +200 to speed for the next 10 seconds"
			print(Global.crab_SPEED)
			speedy_gonzales()
		
		else:
			$"Strength-potion".show()
			$Box/RichTextLabel.text = "You got a strength potion! +5 to DMG for the next 5 seconds"
			print(Global.crab_damage)
			protein_shake()
			print(Global.crab_damage)
		
		box_closed = false
		
