extends Node2D


var score

	
func update_score():
	$ScoreLabel.text = "Target Hit!"


func _on_Player_body_shape_entered(body_id, body, body_shape, local_shape):
	if body_id == $Target.get_instance_id() or body_id == $Target2.get_instance_id():
		update_score()
