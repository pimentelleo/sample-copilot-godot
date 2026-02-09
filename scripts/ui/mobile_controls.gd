extends CanvasLayer

@onready var joystick: Control = $MobileControls/LeftSide/VirtualJoystick
@onready var shoot_button: Control = $MobileControls/RightSide/ShootButton
@onready var jump_button: Control = $MobileControls/RightSide/JumpButton
@onready var reload_button: Control = $MobileControls/RightSide/ReloadButton
@onready var dash_button: Control = $MobileControls/RightSide/DashButton

var joystick_output: Vector2 = Vector2.ZERO
var look_touch_index: int = -1
var look_start_pos: Vector2 = Vector2.ZERO
var look_sensitivity: float = 0.002

signal look_moved(delta: Vector2)

func _ready():
	# Connect joystick signal
	if joystick:
		joystick.joystick_moved.connect(_on_joystick_moved)
	
	# Hide on desktop
	if not OS.has_feature("mobile") and not OS.has_feature("web"):
		visible = false

func _input(event):
	# Handle look (right side of screen)
	if event is InputEventScreenTouch:
		var screen_center = get_viewport().get_visible_rect().size.x / 2
		
		if event.position.x > screen_center:
			if event.pressed:
				look_touch_index = event.index
				look_start_pos = event.position
			elif event.index == look_touch_index:
				look_touch_index = -1
	
	elif event is InputEventScreenDrag:
		if event.index == look_touch_index:
			var delta = (event.position - look_start_pos) * look_sensitivity
			look_start_pos = event.position
			emit_signal("look_moved", delta)

func _on_joystick_moved(direction: Vector2):
	joystick_output = direction

func get_movement_input() -> Vector2:
	return joystick_output

func is_mobile() -> bool:
	return OS.has_feature("mobile") or OS.has_feature("web")
