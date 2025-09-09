extends Area2D

signal send_pos(pos)
signal selected()
var selected_opt = false

func _ready() -> void:
	send_pos.emit(position)


func _process(_delta: float) -> void:
	if selected_opt:
		selected.emit()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("select-button"):
		print("selected")
		selected_opt = true
		self.modulate = "95ffff"


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("select-button"):
		print("deselected")
		selected_opt = false
		self.modulate = "ffffff"
