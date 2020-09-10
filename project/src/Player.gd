extends RigidBody2D

export var strength : float = 300
# var trajPoint = Vector2(100, -100)
var _angle : float = 0
var _angleIncrement : float = PI/180
var isFired : bool = false

func _process(delta):
	# $Trajectory.set_point_position(1, trajPoint)
	# trajPoint = Vector2(clamp(trajPoint.x, 0, 1090), clamp(trajPoint.y, -500, 0))
	_angle = clamp(_angle, -PI/2, 0)
	print(_angle)
	strength = clamp(strength, 300, 800)
	$Trajectory.width = clamp($Trajectory.width, 2, 52)
	
	if Input.is_action_just_pressed("launch") and isFired == false:
		var direction = Vector2(1, 0).rotated(_angle)
		var velocity = direction * strength
		apply_impulse(Vector2.ZERO, velocity)
		$Trajectory.visible = false
		isFired = true
	
	if Input.is_action_pressed("ui_right"):
		_angle += _angleIncrement
	if Input.is_action_pressed("ui_left"):
		_angle -= _angleIncrement
	if Input.is_action_just_pressed("ui_up"):
		$Trajectory.width += 5
		strength += 50
	if Input.is_action_just_pressed("ui_down"):
		$Trajectory.width -= 5
		strength -= 50
