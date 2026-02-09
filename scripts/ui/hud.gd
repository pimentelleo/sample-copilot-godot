extends Control

# HUD elements
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var armor_label: Label = $MarginContainer/VBoxContainer/ArmorLabel
@onready var ammo_label: Label = $MarginContainer/VBoxContainer2/AmmoLabel
@onready var weapon_label: Label = $MarginContainer/VBoxContainer2/WeaponLabel
@onready var crosshair: Control = $Crosshair

var player: CharacterBody3D = null

func _ready():
	# Find player
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	
	# Adjust HUD size for mobile
	if OS.has_feature("mobile") or OS.has_feature("web"):
		_adjust_for_mobile()
	
	if player:
		# Connect to player signals (if they exist)
		update_hud()

func _adjust_for_mobile():
	# Make HUD text smaller on mobile
	if health_label:
		health_label.add_theme_font_size_override("font_size", 18)
	if armor_label:
		armor_label.add_theme_font_size_override("font_size", 18)
	if weapon_label:
		weapon_label.add_theme_font_size_override("font_size", 16)
	if ammo_label:
		ammo_label.add_theme_font_size_override("font_size", 24)

func _process(delta):
	if player:
		update_hud()

func update_hud():
	# Update health and armor
	if player.has("health"):
		health_label.text = "HEALTH: %d" % player.health
	
	if player.has("armor"):
		armor_label.text = "ARMOR: %d" % player.armor
	
	# Update weapon and ammo info
	if player.has("current_weapon") and player.current_weapon:
		var weapon = player.current_weapon
		weapon_label.text = "WEAPON: %s" % weapon.weapon_name
		ammo_label.text = "AMMO: %d / %d" % [weapon.current_ammo, weapon.reserve_ammo]

func show_damage_indicator():
	# TODO: Implement damage flash effect
	pass

func show_message(text: String, duration: float = 2.0):
	# TODO: Implement message display
	pass
