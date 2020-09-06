extends Node2D

var trajAngle : Vector2


# Called when the node enters the scene tree for the first time.
func _draw():
	draw_line(position, trajAngle, Color.black, 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2(1,-1)
	var length = 150
	trajAngle = direction * length
	if Input.is_action_just_pressed("ui_right"):
		direction += Vector2(1,-1)
	update()
