extends Control

@export var dead_zone: float = 5.0
@export var max_distance: float = 100.0
@export var return_speed: float = 15.0

@onready var base: Control = $Base
@onready var tip: Control = $Base/Tip

var is_pressed: bool = false
var output: Vector2 = Vector2.ZERO
var touch_index: int = -1
var tip_position: Vector2 = Vector2.ZERO

signal joystick_moved(direction: Vector2)

func _ready():
	# Make sure we can receive input
	set_process_input(true)
	set_process(true)

func _process(delta):
	# Smoothly return joystick to center when not pressed
	if not is_pressed:
		tip_position = tip_position.move_toward(Vector2.ZERO, return_speed * max_distance * delta)
		tip.position = tip_position
		
		if tip_position.length() < dead_zone:
			output = Vector2.ZERO
		else:
			output = tip_position / max_distance
		
		if output != Vector2.ZERO:
			emit_signal("joystick_moved", output)

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
	tip_position = direction
	tip.position = tip_position
	
	# Calculate output (normalized)
	if distance > dead_zone:
		output = direction / max_distance
	else:
		output = Vector2.ZERO
	
	emit_signal("joystick_moved", output)

func _reset_joystick():
	# Don't instantly reset, let _process handle smooth return
	is_pressed = false
	touch_index = -1

func get_output() -> Vector2:
	return output
