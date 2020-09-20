extends Node2D

export (PackedScene) var Player = load("res://project/src/Player.tscn")
var player
onready var target = get_node("Target")
onready var target2 = get_node("Target2")

var _projectileCount : float = 3
onready var _projectileCounter = get_node("ProjectileCounter/Background/Number")
var _boxCount : float = 2
onready var _boxCounter = get_node("BoxCounter/Background/Number")

var title_scene_path = "res://project/src/TitleScreen.tscn"


func _ready():
	_spawn_player()
	_update_hud()
	
	
func _process(_delta):
	if _projectileCount <= 0:
		get_tree().change_scene(title_scene_path)


func _update_hud():
	_projectileCounter.text = str(_projectileCount)
	_boxCounter.text = str(_boxCount)


func _spawn_player():
	player = Player.instance()
	call_deferred("add_child", player)
	player.position = $StartPosition.position
	player.connect("player_stopped", self, "_on_player_stopped", [], CONNECT_ONESHOT)


func _on_player_stopped():
	_projectileCount -= 1
	_update_hud()
	
	if _projectileCount > 0:
		_spawn_player()


func _on_EdgeLimit_body_shape_entered(body_id, _body, _body_shape, _area_shape):
	if target != null:
		if body_id == target.get_instance_id():
			target.queue_free()
			_boxCount -= 1
			_update_hud()
	if target2 != null:
		if body_id == target2.get_instance_id():
			target2.queue_free()
			_boxCount -= 1
			_update_hud()
	if player != null:
		if body_id == player.get_instance_id():
			_on_player_stopped()
		
