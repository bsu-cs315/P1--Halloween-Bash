extends Node2D

export (PackedScene) var Player = load("res://project/src/Player.tscn")
var player
var _score
var _projectileCount : float = 3
var _boxCount : float = 2


func _ready():
	_spawn_player()


func _process(_delta):
	$ProjectileCounter/Background/Number.text = str(_projectileCount)
	$BoxCounter/Background/Number.text = str(_boxCount)
	
func _spawn_player():
	player = Player.instance()
	call_deferred("add_child", player)
	player.position = $StartPosition.position
	player.connect("player_stopped", self, "_on_player_stopped", [], CONNECT_ONESHOT)


func _on_player_stopped():
	_projectileCount -= 1
	
	if _projectileCount > 0:
		_spawn_player()


func _on_EdgeLimit_body_shape_entered(body_id, _body, _body_shape, _area_shape):
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
			_on_player_stopped()
		
