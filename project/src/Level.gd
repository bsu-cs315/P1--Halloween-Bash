extends Node2D

export (PackedScene) var Player = load("res://project/src/Player.tscn")
var player
onready var target = get_node("Target")
onready var target2 = get_node("Target2")

var _projectile_count := 3
onready var _projectile_counter = get_node("ProjectileCounter/Background/Number")
var _box_count := 2
onready var _box_counter = get_node("BoxCounter/Background/Number")

var score := 0
onready var _score_label = get_node("GameOverHUD/ScoreLabel")
onready var _game_over_label = get_node("GameOverHUD/GameOverLabel")
onready var _main_menu_button = get_node("GameOverHUD/MainMenuButton")

var title_scene_path = "res://project/src/TitleScreen.tscn"


func _ready():
	_spawn_player()
	_update_hud()
	_update_gameover_hud()


func _update_hud():
		_projectile_counter.text = str(_projectile_count)
		_box_counter.text = str(_box_count)

func _update_gameover_hud():
	_score_label.text = "Score: " + str(score)
	
	if _projectile_count > 0:
		_game_over_label.visible = false
		_score_label.visible = false
		_main_menu_button.visible = false
	else:
		_game_over_label.visible = true
		_score_label.visible = true
		_main_menu_button.visible = true


func _on_MainMenuButton_pressed():
	get_tree().change_scene(title_scene_path)


func _spawn_player():
	player = Player.instance()
	call_deferred("add_child", player)
	player.position = $StartPosition.position
	player.connect("player_stopped", self, "_on_player_stopped", [], CONNECT_ONESHOT)


func _on_player_stopped():
	_projectile_count -= 1
	_update_hud()
	
	if _projectile_count > 0:
		_spawn_player()
	else:
		_update_gameover_hud()


func _on_EdgeLimit_body_shape_entered(body_id, _body, _body_shape, _area_shape):
	if target:
		if body_id == target.get_instance_id():
			target.queue_free()
			_box_count -= 1
			score += 10
			_update_hud()
	if target2:
		if body_id == target2.get_instance_id():
			target2.queue_free()
			_box_count -= 1
			score += 10
			_update_hud()
	if player:
		if body_id == player.get_instance_id():
			_on_player_stopped()
