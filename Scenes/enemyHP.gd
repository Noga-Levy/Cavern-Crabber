extends RichTextLabel

var health = null
var total_health = null

func _ready() -> void:
	self.text = "HP: {0}/{1}".format([health, total_health])

func _on_enemy_warble_send_health(HP: Variant, total_HP: Variant) -> void:
	health = HP
	total_health = total_HP
	self.text = "HP: {0}/{1}".format([health, total_health])
