extends Area2D

signal send_pos(pos)
signal selected()
var selected_opt = false

func _ready() -> void:
	send_pos.emit(position)
	self.area_entered.connect(self._on_area_entered)
	self.area_exited.connect(self._on_area_exited)


func _process(_delta: float) -> void:
	if selected_opt:
		selected.emit()


func _on_area_entered(_area2d: Area2D):
	print("selected")
	selected_opt = true
	self.modulate = "95ffff"


func _on_area_exited(_area2d: Area2D):
	print("deselected")
	selected_opt = false
	self.modulate = "ffffff"
