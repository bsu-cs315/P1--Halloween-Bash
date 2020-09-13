extends Node2D

export (PackedScene) var Player = load("res://project/src/Player.tscn")
var player = Player.instance()
var _score
var _projectileCount : float = 3
var _boxCount : float = 2


func _ready():
	add_child(player)
	player.position = $StartPosition.position


func _process(delta):
	$ProjectileCounter/Background/Number.text = str(_projectileCount)
	$BoxCounter/Background/Number.text = str(_boxCount)
	if player.sleeping:
		_on_Player_sleeping_state_changed()
	
func update_score():
	$ScoreLabel.text = "Target Hit!"


func _on_Player_body_shape_entered(body_id, body, body_shape, local_shape):
	if body_id == $Target.get_instance_id() or \
	body_id == $Target2.get_instance_id():
		update_score()


func _on_Player_sleeping_state_changed():
	player.queue_free()
	player = Player.instance()
	add_child(player)
	player.position = $StartPosition.position
	_projectileCount -= 1
