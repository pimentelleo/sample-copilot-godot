extends Node3D
class_name Weapon

# Weapon stats
@export var weapon_name: String = "Weapon"
@export var damage: int = 10
@export var fire_rate: float = 0.1  # Time between shots
@export var max_ammo: int = 30
@export var current_ammo: int = 30
@export var reserve_ammo: int = 120
@export var reload_time: float = 2.0
@export var automatic: bool = false
@export var projectile_speed: float = 100.0

# Weapon state
var can_shoot: bool = true
var is_reloading: bool = false
var shoot_timer: float = 0.0

# References
@onready var raycast: RayCast3D = $RayCast3D
@onready var muzzle_flash: Node3D = $MuzzleFlash
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

signal ammo_changed(current: int, reserve: int)
signal weapon_fired()
signal weapon_reloaded()

func _ready():
	if muzzle_flash:
		muzzle_flash.visible = false

func _process(delta: float) -> void:
	# Update shoot timer
	if shoot_timer > 0:
		shoot_timer -= delta
		if shoot_timer <= 0:
			can_shoot = true

func shoot() -> bool:
	if not can_shoot or is_reloading or current_ammo <= 0:
		return false
	
	# Fire the weapon
	current_ammo -= 1
	can_shoot = false
	shoot_timer = fire_rate
	
	# Show muzzle flash
	if muzzle_flash:
		muzzle_flash.visible = true
		await get_tree().create_timer(0.05).timeout
		muzzle_flash.visible = false
	
	# Play sound effect
	if audio_player:
		audio_player.play()
	
	# Perform raycast
	if raycast:
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			var hit_point = raycast.get_collision_point()
			
			# Check if we hit an enemy
			if collider.has_method("take_damage"):
				collider.take_damage(damage)
	
	emit_signal("ammo_changed", current_ammo, reserve_ammo)
	emit_signal("weapon_fired")
	
	return true

func reload() -> void:
	if is_reloading or current_ammo == max_ammo or reserve_ammo <= 0:
		return
	
	is_reloading = true
	can_shoot = false
	
	await get_tree().create_timer(reload_time).timeout
	
	var ammo_needed = max_ammo - current_ammo
	var ammo_to_reload = min(ammo_needed, reserve_ammo)
	
	current_ammo += ammo_to_reload
	reserve_ammo -= ammo_to_reload
	
	is_reloading = false
	can_shoot = true
	
	emit_signal("ammo_changed", current_ammo, reserve_ammo)
	emit_signal("weapon_reloaded")

func add_ammo(amount: int) -> void:
	reserve_ammo += amount
	emit_signal("ammo_changed", current_ammo, reserve_ammo)

func _input(event):
	if event.is_action_pressed("shoot"):
		if automatic:
			shoot()
	
	if event.is_action_pressed("reload"):
		reload()

func _physics_process(delta):
	if automatic and Input.is_action_pressed("shoot"):
		shoot()
