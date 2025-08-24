extends Sprite2D

var e_warble
var camera2D

func _ready() -> void:
	print(position)
	position.x = 0
	position.y = 0
	print(position)
	e_warble = get_node("/root/Level_1/e_warble")
	camera2D = get_node("/root/Level_1/Camera2D")
	
func _process(delta: float) -> void:
	
	# MOVEMENT
	if Input.is_key_pressed(KEY_DOWN):
		position.y += 5
	if Input.is_key_pressed(KEY_UP):
		position.y -= 5
	
	if Input.is_key_pressed(KEY_LEFT):
		position.x -= 5
	if Input.is_key_pressed(KEY_RIGHT):
		position.x += 5
	
	# ABILITIES
	if Input.is_key_pressed(KEY_A) and abs(position.x - e_warble.position.x) < 10.0 and abs(position.y - e_warble.position.y) < 10:
		e_warble.hide()
		print("It's a warble! Sound the alarms!")
