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
	if _projectileCount > 0 and player.sleeping:
		_on_Player_stopped()


func _on_Player_stopped():
	player.queue_free()
	_projectileCount -= 1
	
	if _projectileCount > 0:
		player = Player.instance()
		add_child(player)
		player.position = $StartPosition.position


func _on_EdgeLimit_body_shape_entered(body_id, body, body_shape, area_shape):
	if $Target != null:
		if body_id == $Target.get_instance_id():
			$Target.queue_free()
			_boxCount -= 1
	if $Target2 != null:
		if body_id == $Target2.get_instance_id():
			$Target2.queue_free()
			_boxCount -= 1
	if player != null:
		if body_id == player.get_instance_id():
			_on_Player_stopped()
		
