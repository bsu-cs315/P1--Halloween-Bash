extends Node2D


var _score
var _projectileCount : float = 3


func _process(delta):
	$ProjectileCount.text = "Inventory: " + str(_projectileCount)
	
func update_score():
	$ScoreLabel.text = "Target Hit!"


func _on_Player_body_shape_entered(body_id, body, body_shape, local_shape):
	if body_id == $Target.get_instance_id() or body_id == $Target2.get_instance_id():
		update_score()


func _on_Player_launched():
	_projectileCount -= 1
