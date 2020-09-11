extends RigidBody2D

export var strength : float = 300
var _angle : float = 0
var _angleIncrement : float = PI/180
var powerLength : float = 100
var _isFired : bool = false

func _ready():
	gravity_scale = 0

func _process(delta):
	if _isFired:
		return
	
	_angle = clamp(_angle, -PI/2, 0)
	strength = clamp(strength, 300, 800)
	powerLength = clamp(powerLength, 100, 200)
	
	if Input.is_action_just_pressed("launch"):
		var direction = Vector2(1, 0).rotated(_angle)
		var velocity = direction * strength
		apply_impulse(Vector2.ZERO, velocity)
		gravity_scale = 3
		_isFired = true
	
	if Input.is_action_pressed("ui_right"):
		_angle += _angleIncrement
	if Input.is_action_pressed("ui_left"):
		_angle -= _angleIncrement
	if Input.is_action_just_pressed("ui_up"):
		powerLength += 10
		strength += 50
	if Input.is_action_just_pressed("ui_down"):
		powerLength -= 10
		strength -= 50
		
	update()
	
func _draw():
	if not _isFired:
		draw_line(Vector2.ZERO, Vector2(powerLength, 0).rotated(_angle), Color.gray, 2)
