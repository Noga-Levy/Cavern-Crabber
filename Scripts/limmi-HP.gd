extends RichTextLabel

var health = null
var total_health = null

func _ready() -> void:
	self.text = "[font_size=30]HP: {0}/{1}[/font_size]".format([health, total_health])

func _process(_delta: float) -> void:
	self.text = "[font_size=30]HP: {0}/{1}[/font_size]".format([health, total_health])

func _on_limmi_send_health(HP: Variant, total_HP: Variant) -> void:
	health = HP
	total_health = total_HP
	self.text = "[font_size=30]HP: {0}/{1}[/font_size]".format([health, total_health])
