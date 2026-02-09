extends Node3D

# Weapon management
var weapons: Array = []
var current_weapon_index: int = 0
@onready var weapon_position: Node3D = get_parent()

func _ready():
	# Load available weapons
	load_weapons()

func load_weapons():
	# Add weapons to the array
	var boltgun = preload("res://scenes/weapons/boltgun.tscn").instantiate()
	add_weapon(boltgun)

func add_weapon(weapon: Node3D):
	weapons.append(weapon)
	weapon_position.add_child(weapon)
	
	# Hide all weapons except the first one
	if weapons.size() > 1:
		weapon.visible = false
	else:
		weapon.visible = true

func switch_weapon(index: int):
	if index < 0 or index >= weapons.size():
		return
	
	# Hide current weapon
	if current_weapon_index < weapons.size():
		weapons[current_weapon_index].visible = false
	
	# Show new weapon
	current_weapon_index = index
	weapons[current_weapon_index].visible = true

func next_weapon():
	var next_index = (current_weapon_index + 1) % weapons.size()
	switch_weapon(next_index)

func previous_weapon():
	var prev_index = (current_weapon_index - 1) if current_weapon_index > 0 else weapons.size() - 1
	switch_weapon(prev_index)

func get_current_weapon() -> Weapon:
	if weapons.size() > 0 and current_weapon_index < weapons.size():
		return weapons[current_weapon_index]
	return null

func _input(event):
	if event.is_action_pressed("weapon_next"):
		next_weapon()
	elif event.is_action_pressed("weapon_prev"):
		previous_weapon()
