extends Node2D


var score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_score():
	$ScoreLabel.text = "Target Hit!"



func _on_Player_body_shape_entered(body_id, body, body_shape, local_shape):
	if body_shape == 0:
		update_score()
