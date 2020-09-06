extends RigidBody2D

export var strength : float = 300
var trajPoint = Vector2(100, -100)

func _process(delta):
	$Line2D.set_point_position(1, trajPoint)
	
	if Input.is_action_just_pressed("launch"):
		var direction = trajPoint.normalized()
		var velocity = direction * strength
		apply_impulse(Vector2.ZERO, velocity)
	if Input.is_action_just_pressed("ui_right"):
		trajPoint.x += 10
		trajPoint.y += 10
	if Input.is_action_just_pressed("ui_left"):
		trajPoint.x -= 10
		trajPoint.y -= 10
