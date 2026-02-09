extends CharacterBody3D
class_name Enemy

# Enemy stats
@export var max_health: int = 50
@export var health: int = 50
@export var damage: int = 10
@export var movement_speed: float = 5.0
@export var attack_range: float = 2.0
@export var detection_range: float = 20.0
@export var attack_cooldown: float = 1.0

# State
enum State { IDLE, PATROL, CHASE, ATTACK, DEAD }
var current_state: State = State.IDLE
var player: CharacterBody3D = null
var attack_timer: float = 0.0

# Get the gravity from the project settings
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Navigation
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

func _ready():
	# Find player
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	
	# Setup navigation agent
	if navigation_agent:
		navigation_agent.path_desired_distance = 0.5
		navigation_agent.target_desired_distance = 0.5

func _physics_process(delta: float) -> void:
	if current_state == State.DEAD:
		return
	
	# Update attack timer
	if attack_timer > 0:
		attack_timer -= delta
	
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# State machine
	match current_state:
		State.IDLE:
			idle_behavior()
		State.PATROL:
			patrol_behavior()
		State.CHASE:
			chase_behavior(delta)
		State.ATTACK:
			attack_behavior(delta)
	
	move_and_slide()

func idle_behavior():
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < detection_range:
			current_state = State.CHASE

func patrol_behavior():
	# TODO: Implement patrol waypoints
	if player:
		var distance = global_position.distance_to(player.global_position)
		if distance < detection_range:
			current_state = State.CHASE

func chase_behavior(delta: float):
	if not player:
		current_state = State.IDLE
		return
	
	var distance = global_position.distance_to(player.global_position)
	
	# Check if we're close enough to attack
	if distance < attack_range:
		current_state = State.ATTACK
		velocity = Vector3.ZERO
		return
	
	# Check if player is out of range
	if distance > detection_range * 1.5:
		current_state = State.IDLE
		velocity = Vector3.ZERO
		return
	
	# Move towards player
	if navigation_agent:
		navigation_agent.target_position = player.global_position
		
		if not navigation_agent.is_navigation_finished():
			var next_position = navigation_agent.get_next_path_position()
			var direction = (next_position - global_position).normalized()
			
			# Face the player
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
			
			velocity.x = direction.x * movement_speed
			velocity.z = direction.z * movement_speed

func attack_behavior(delta: float):
	if not player:
		current_state = State.IDLE
		return
	
	var distance = global_position.distance_to(player.global_position)
	
	# Check if player is out of range
	if distance > attack_range * 1.5:
		current_state = State.CHASE
		return
	
	# Face the player
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	# Attack when cooldown is ready
	if attack_timer <= 0:
		perform_attack()
		attack_timer = attack_cooldown

func perform_attack():
	if player and player.has_method("take_damage"):
		var distance = global_position.distance_to(player.global_position)
		if distance < attack_range:
			player.take_damage(damage)

func take_damage(amount: int):
	if current_state == State.DEAD:
		return
	
	health -= amount
	
	# Enter chase state when damaged
	if current_state == State.IDLE or current_state == State.PATROL:
		current_state = State.CHASE
	
	# Check if dead
	if health <= 0:
		die()

func die():
	current_state = State.DEAD
	collision_layer = 0
	collision_mask = 0
	
	# Play death animation or effect
	if mesh_instance:
		var tween = create_tween()
		tween.tween_property(mesh_instance, "scale", Vector3.ZERO, 0.5)
		await tween.finished
	
	queue_free()
