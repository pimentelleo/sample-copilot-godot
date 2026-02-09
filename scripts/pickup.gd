extends Area3D
class_name Pickup

enum PickupType { HEALTH, ARMOR, AMMO }

@export var pickup_type: PickupType = PickupType.HEALTH
@export var value: int = 25
@export var rotate_speed: float = 2.0

@onready var mesh: MeshInstance3D = $MeshInstance3D

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	# Rotate the pickup
	if mesh:
		mesh.rotate_y(rotate_speed * delta)

func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		apply_pickup(body)
		queue_free()

func apply_pickup(player: CharacterBody3D):
	match pickup_type:
		PickupType.HEALTH:
			if player.has_method("heal"):
				player.heal(value)
		PickupType.ARMOR:
			if player.has_method("add_armor"):
				player.add_armor(value)
		PickupType.AMMO:
			if player.has("current_weapon") and player.current_weapon:
				player.current_weapon.add_ammo(value)
