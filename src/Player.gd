extends RigidBody2D

export var strength : float = 300
var trajPoint = Vector2(100, -100)

func _process(delta):
	$Trajectory.set_point_position(1, trajPoint)
	trajPoint = Vector2(clamp(trajPoint.x, 0, 1090), clamp(trajPoint.y, -500, 0))
	
	if Input.is_action_just_pressed("launch"):
		var direction = trajPoint.normalized()
		var velocity = direction * strength
		apply_impulse(Vector2.ZERO, velocity)
		$Trajectory.visible = false
	
	if Input.is_action_pressed("ui_right"):
		trajPoint = trajPoint.rotated(PI/180)
	if Input.is_action_pressed("ui_left"):
		trajPoint = trajPoint.rotated(-PI/180)
	if Input.is_action_just_pressed("ui_up"):
		$Trajectory.width += 2
		strength += 50
	if Input.is_action_just_pressed("ui_down"):
		$Trajectory.width -= 2
		strength -= 50
