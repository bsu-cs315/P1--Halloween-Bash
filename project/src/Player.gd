extends RigidBody2D

export var strength : float = 300
var trajPoint = Vector2(100, -100)
var isFired : bool = false

func _process(delta):
	$Trajectory.set_point_position(1, trajPoint)
	trajPoint = Vector2(clamp(trajPoint.x, 0, 1090), clamp(trajPoint.y, -500, 0))
	strength = clamp(strength, 300, 800)
	$Trajectory.width = clamp($Trajectory.width, 2, 52)
	
	if Input.is_action_just_pressed("launch") and isFired == false:
		var direction = trajPoint.normalized()
		var velocity = direction * strength
		apply_impulse(Vector2.ZERO, velocity)
		$Trajectory.visible = false
		isFired = true
	
	if Input.is_action_pressed("ui_right"):
		trajPoint = trajPoint.rotated(PI/180)
	if Input.is_action_pressed("ui_left"):
		trajPoint = trajPoint.rotated(-PI/180)
	if Input.is_action_just_pressed("ui_up"):
		$Trajectory.width += 5
		strength += 50
	if Input.is_action_just_pressed("ui_down"):
		$Trajectory.width -= 5
		strength -= 50
