extends RigidBody2D

export var _strength : float = 300
# var trajPoint = Vector2(100, -100)
var _angle : float = 0
var _angleIncrement : float = PI/180
var _powerLength : float = 100
var _isFired : bool = false

func _process(delta):
	# $Trajectory.set_point_position(1, trajPoint)
	# trajPoint = Vector2(clamp(trajPoint.x, 0, 1090), clamp(trajPoint.y, -500, 0))
	_angle = clamp(_angle, -PI/2, 0)
	print(_angle)
	_strength = clamp(_strength, 300, 800)
	_powerLength = clamp(_powerLength, 100, 200)
	# $Trajectory.width = clamp($Trajectory.width, 2, 52)
	
	if Input.is_action_just_pressed("launch") and _isFired == false:
		var direction = Vector2(1, 0).rotated(_angle)
		var velocity = direction * _strength
		apply_impulse(Vector2.ZERO, velocity)
		$Trajectory.visible = false
		_isFired = true
	
	if Input.is_action_pressed("ui_right"):
		_angle += _angleIncrement
	if Input.is_action_pressed("ui_left"):
		_angle -= _angleIncrement
	if Input.is_action_just_pressed("ui_up"):
		_powerLength += 10
		_strength += 50
	if Input.is_action_just_pressed("ui_down"):
		_powerLength -= 10
		_strength -= 50
		
	update()
	
func _draw():
	draw_line(Vector2.ZERO, Vector2(_powerLength, 0).rotated(_angle), Color.gray, 2)
