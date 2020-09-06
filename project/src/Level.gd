extends Node2D


var score

	
func update_score():
	$ScoreLabel.text = "Target Hit!"


func _on_Player_body_shape_entered(body_id, body, body_shape, local_shape):
	if body_id == 1262 or body_id == 1259:
		update_score()
