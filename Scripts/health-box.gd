extends Node2D

var box_closed = true
var colliding_with_box = []
var current_level

# TODO: If you are speedy while you leave the level, you'll be extra speedy in the next. Fix it soon!

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
	Global.crab_modulate = "33cc33"
	Global.crab_SPEED = Global.crab_SPEED + 200
	await get_tree().create_timer(10).timeout
	Global.crab_SPEED = Global.crab_SPEED - 200
	Global.crab_modulate = "ffffff"


func protein_shake():
	Global.crab_modulate = "00ffff"
	Global.crab_damage = Global.crab_damage + 5
	await get_tree().create_timer(5).timeout
	Global.crab_damage = Global.crab_damage - 5
	Global.crab_modulate = "ffffff"

func _process(_delta: float) -> void:
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
