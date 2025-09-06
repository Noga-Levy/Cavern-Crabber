extends Node2D

var box_closed = true
var colliding_with_box = []
var current_level

func _ready() -> void:
	current_level = Global.level
	$Box.play("closed")
	$"Health-potion".hide()

func _on_body_entered(body: Node2D) -> void:
	colliding_with_box.append(body.name)

func _on_body_exited(body: Node2D) -> void:
	colliding_with_box.erase(body.name)


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) and box_closed and "Player" in colliding_with_box:
		$Box.play("opened")
		print("opened")
		$"Health-potion".show()
		
		$Box/RichTextLabel.text = "You got a health potion! All HP has been restored"
		if Global.level == current_level:
			Global.crabHP = Global.level * 5 + 5
		else:
			Global.crabHP = (Global.level - 1) * 5 + 5
		
		box_closed = false
