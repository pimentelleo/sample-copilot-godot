extends Weapon

func _ready():
	super._ready()
	weapon_name = "Boltgun"
	damage = 35
	fire_rate = 0.15
	max_ammo = 24
	current_ammo = 24
	reserve_ammo = 96
	reload_time = 2.2
	automatic = false
	projectile_speed = 150.0
