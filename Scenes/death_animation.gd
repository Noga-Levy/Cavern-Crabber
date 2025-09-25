extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_animation_looped() -> void:
	if $AnimatedSprite2D.animation_finished:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.hide()
