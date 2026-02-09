extends Node3D

# Projectile properties
@export var speed: float = 50.0
@export var damage: int = 20
@export var lifetime: float = 5.0
@export var gravity_affected: bool = false

var direction: Vector3 = Vector3.FORWARD
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var area: Area3D = $Area3D

func _ready():
	area.body_entered.connect(_on_body_entered)
	
	# Auto-destroy after lifetime
	await get_tree().create_timer(lifetime).timeout
	queue_free()

func _physics_process(delta):
	# Move projectile
	var velocity = direction * speed
	
	# Apply gravity if needed
	if gravity_affected:
		velocity.y -= gravity * delta
	
	global_position += velocity * delta

func _on_body_entered(body: Node3D):
	# Check if we hit something
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	# Destroy projectile on impact
	queue_free()

func set_direction(new_direction: Vector3):
	direction = new_direction.normalized()
	look_at(global_position + direction, Vector3.UP)
