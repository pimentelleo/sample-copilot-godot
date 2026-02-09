extends CharacterBody3D

# Player movement parameters
@export var movement_speed: float = 10.0
@export var sprint_speed: float = 15.0
@export var jump_velocity: float = 8.0
@export var dash_speed: float = 25.0
@export var dash_duration: float = 0.2

# Mouse sensitivity
@export var mouse_sensitivity: float = 0.003

# Camera references
@onready var camera: Camera3D = $Head/Camera3D
@onready var head: Node3D = $Head

# Get the gravity from the project settings
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Movement variables
var is_sprinting: bool = false
var is_dashing: bool = false
var dash_time: float = 0.0
var dash_direction: Vector3 = Vector3.ZERO

# Health and armor
@export var max_health: int = 100
@export var max_armor: int = 100
var health: int = 100
var armor: int = 100

# Reference to weapon system
var current_weapon = null

# Mobile controls reference
var mobile_controls = null
var is_mobile: bool = false

func _ready():
	# Check if on mobile
	is_mobile = OS.has_feature("mobile") or OS.has_feature("web")
	
	# Capture mouse only on desktop
	if not is_mobile:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Find mobile controls
	await get_tree().process_frame
	mobile_controls = get_tree().get_first_node_in_group("mobile_controls")
	if mobile_controls:
		mobile_controls.look_moved.connect(_on_mobile_look_moved)

func _input(event):
	# Desktop mouse look
	if not is_mobile:
		if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * mouse_sensitivity)
			head.rotate_x(-event.relative.y * mouse_sensitivity)
			head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)
		
		# Toggle mouse capture
		if event.is_action_pressed("ui_cancel"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_mobile_look_moved(delta: Vector2):
	# Mobile touch look
	rotate_y(-delta.x * 100)
	head.rotate_x(-delta.y * 100)
	head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)

func _physics_process(delta: float) -> void:
	# Handle dash
	if is_dashing:
		dash_time -= delta
		if dash_time <= 0:
			is_dashing = false
		velocity = dash_direction * dash_speed
		move_and_slide()
		return
	
	# Add the gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Handle dash
	if Input.is_action_just_pressed("dash") and is_on_floor():
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		if input_dir.length() > 0:
			var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			dash_direction = direction
			is_dashing = true
			dash_time = dash_duration
			return
	
	# Get the input direction (desktop or mobile)
	var input_dir: Vector2
	if is_mobile and mobile_controls:
		input_dir = mobile_controls.get_movement_input()
	else:
		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Determine speed (sprint or walk)
	var current_speed = sprint_speed if Input.is_action_pressed("dash") else movement_speed
	
	# Apply movement
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	move_and_slide()

func take_damage(amount: int) -> void:
	# Armor absorbs damage first
	if armor > 0:
		var damage_to_armor = min(armor, amount)
		armor -= damage_to_armor
		amount -= damage_to_armor
	
	# Remaining damage goes to health
	if amount > 0:
		health -= amount
	
	# Check if dead
	if health <= 0:
		die()

func heal(amount: int) -> void:
	health = min(health + amount, max_health)

func add_armor(amount: int) -> void:
	armor = min(armor + amount, max_armor)

func die() -> void:
	# Implement death logic
	print("Player died!")
	# TODO: Show game over screen, respawn, etc.
