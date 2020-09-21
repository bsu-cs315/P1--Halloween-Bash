extends Node2D


func _ready():
	$AnimationPlayer.play("Fly_In")

func _on_StartButton_pressed():
	var _ignored = get_tree().change_scene("res://project/src/Level.tscn")
