extends Node2D

func _ready() -> void:
	$Box.play("closed")
	$"Health-potion".hide()
	
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		$Box.play("opened")
		print("opened")
		$"Health-potion".show()
		$Box/RichTextLabel.text = "You got a health potion! All HP has been restored"
		Global.crabHP = Global.level * 5 + 5
