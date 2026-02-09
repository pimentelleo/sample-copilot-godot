extends Control

@export var action_name: String = ""
@export var button_text: String = "BTN"

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label

var is_pressed: bool = false
var touch_index: int = -1

signal button_pressed()
signal button_released()

func _ready():
	label.text = button_text
	set_process_input(true)

func _input(event):
	var rect = get_global_rect()
	
	if event is InputEventScreenTouch:
		if event.pressed and rect.has_point(event.position):
			if not is_pressed:
				is_pressed = true
				touch_index = event.index
				_on_press()
		elif event.index == touch_index:
			if is_pressed:
				is_pressed = false
				touch_index = -1
				_on_release()
	
	elif event is InputEventScreenDrag:
		if event.index == touch_index:
			# Check if still in bounds
			if not rect.has_point(event.position) and is_pressed:
				is_pressed = false
				touch_index = -1
				_on_release()

func _on_press():
	color_rect.color = Color(0.8, 0.8, 0.8, 0.7)
	emit_signal("button_pressed")
	
	# Simulate action press
	if action_name != "":
		Input.action_press(action_name)

func _on_release():
	color_rect.color = Color(0.3, 0.3, 0.3, 0.5)
	emit_signal("button_released")
	
	# Simulate action release
	if action_name != "":
		Input.action_release(action_name)

func is_button_pressed() -> bool:
	return is_pressed
