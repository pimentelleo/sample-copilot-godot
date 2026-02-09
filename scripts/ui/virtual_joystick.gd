extends Control

@export var dead_zone: float = 10.0
@export var max_distance: float = 80.0

@onready var base: Control = $Base
@onready var tip: Control = $Base/Tip

var is_pressed: bool = false
var output: Vector2 = Vector2.ZERO
var touch_index: int = -1

signal joystick_moved(direction: Vector2)

func _ready():
	# Make sure we can receive input
	set_process_input(true)

func _input(event):
	# Handle touch events
	if event is InputEventScreenTouch:
		if event.pressed:
			# Check if touch is in our area
			var touch_pos = event.position
			var rect = get_global_rect()
			if rect.has_point(touch_pos):
				is_pressed = true
				touch_index = event.index
				_update_joystick(touch_pos)
		elif event.index == touch_index:
			# Release
			is_pressed = false
			touch_index = -1
			_reset_joystick()
	
	elif event is InputEventScreenDrag and event.index == touch_index:
		if is_pressed:
			_update_joystick(event.position)

func _update_joystick(touch_pos: Vector2):
	var base_center = base.global_position + base.size / 2
	var direction = touch_pos - base_center
	var distance = direction.length()
	
	# Clamp to max distance
	if distance > max_distance:
		direction = direction.normalized() * max_distance
		distance = max_distance
	
	# Update tip position
	tip.position = direction
	
	# Calculate output (normalized)
	if distance > dead_zone:
		output = direction / max_distance
	else:
		output = Vector2.ZERO
	
	emit_signal("joystick_moved", output)

func _reset_joystick():
	tip.position = Vector2.ZERO
	output = Vector2.ZERO
	emit_signal("joystick_moved", Vector2.ZERO)

func get_output() -> Vector2:
	return output
