extends RigidBody2D

signal player_stopped

var _angle : float = 0
var _angle_increment : float = PI/180
var _power : float = 300
var _power_length : float = 100
var _power_length_increment : float = 5
var _is_fired : bool = false

const MIN_POWER : float = 300.0
const MAX_POWER : float = 800.0
const MIN_POWER_LENGTH : float = 100.0
const MAX_POWER_LENGTH : float = 200.0


func _process(_delta):
	$AnimatedSprite.play()
	if _is_fired:
		return
	
	_angle = clamp(_angle, -PI/2, 0)
	_power = clamp(_power, MIN_POWER, MAX_POWER)
	_power_length = range_lerp(_power, MIN_POWER, MAX_POWER, MIN_POWER_LENGTH, MAX_POWER_LENGTH)
	
	if Input.is_action_just_pressed("launch"):
		mode = MODE_RIGID
		var direction = Vector2(1, 0).rotated(_angle)
		var velocity = direction * _power
		apply_impulse(Vector2.ZERO, velocity)
		gravity_scale = 3
		$AnimatedSprite.animation = "launched"
		_is_fired = true
		$AudioStreamPlayer.play()
	
	if Input.is_action_pressed("ui_right"):
		_angle += _angle_increment
	if Input.is_action_pressed("ui_left"):
		_angle -= _angle_increment
	if Input.is_action_pressed("ui_up"):
		_power_length += _power_length_increment
		_power += 25
	if Input.is_action_pressed("ui_down"):
		_power_length -= _power_length_increment
		_power -= 25
		
	update()
	
func _draw():
	if not _is_fired:
		draw_line(Vector2.ZERO, Vector2(_power_length, 0).rotated(_angle), Color.gray, 2)

func _on_Player_body_entered(_body):
	if _is_fired:
		$AnimatedSprite.animation = "hit"


func _on_Player_sleeping_state_changed():
	if _is_fired and sleeping:
		emit_signal("player_stopped")
		queue_free()
