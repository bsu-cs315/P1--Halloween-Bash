extends RigidBody2D


var _angle : float = 0
var _angleIncrement : float = PI/180
var _power : float = 300
var _powerLength : float = 100
var _powerLengthIncrement : float = 5
var _isFired : bool = false

const MIN_POWER : float = 300.0
const MAX_POWER : float = 800.0
const MIN_POWER_LENGTH : float = 100.0
const MAX_POWER_LENGTH : float = 200.0


func _process(delta):
	$AnimatedSprite.play()
	if _isFired:
		return
	
	_angle = clamp(_angle, -PI/2, 0)
	_power = clamp(_power, MIN_POWER, MAX_POWER)
	_powerLength = range_lerp(_power, MIN_POWER, MAX_POWER, MIN_POWER_LENGTH, MAX_POWER_LENGTH)
	
	if Input.is_action_just_pressed("launch"):
		mode = MODE_RIGID
		var direction = Vector2(1, 0).rotated(_angle)
		var velocity = direction * _power
		apply_impulse(Vector2.ZERO, velocity)
		gravity_scale = 3
		$AnimatedSprite.animation = "launched"
		_isFired = true
		$AudioStreamPlayer.play()
	
	if Input.is_action_pressed("ui_right"):
		_angle += _angleIncrement
	if Input.is_action_pressed("ui_left"):
		_angle -= _angleIncrement
	if Input.is_action_pressed("ui_up"):
		_powerLength += _powerLengthIncrement
		_power += 25
	if Input.is_action_pressed("ui_down"):
		_powerLength -= _powerLengthIncrement
		_power -= 25
		
	update()
	
func _draw():
	if not _isFired:
		draw_line(Vector2.ZERO, Vector2(_powerLength, 0).rotated(_angle), Color.gray, 2)

func _on_Player_body_entered(body):
	if _isFired:
		$AnimatedSprite.animation = "hit"
