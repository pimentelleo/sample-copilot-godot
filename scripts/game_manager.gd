extends Node

# Game state
var current_level: String = ""
var score: int = 0
var kills: int = 0
var secrets_found: int = 0
var total_secrets: int = 0

# Player stats persistence
var player_health: int = 100
var player_armor: int = 100
var player_weapons: Array = []
var player_ammo: Dictionary = {}

signal score_changed(new_score: int)
signal kill_counted(total_kills: int)
signal secret_found(current: int, total: int)

func _ready():
	pass

func reset_game():
	score = 0
	kills = 0
	secrets_found = 0
	total_secrets = 0
	player_health = 100
	player_armor = 100
	player_weapons.clear()
	player_ammo.clear()

func add_score(points: int):
	score += points
	emit_signal("score_changed", score)

func add_kill():
	kills += 1
	emit_signal("kill_counted", kills)

func find_secret():
	if secrets_found < total_secrets:
		secrets_found += 1
		emit_signal("secret_found", secrets_found, total_secrets)

func load_level(level_path: String):
	current_level = level_path
	get_tree().change_scene_to_file(level_path)

func save_game():
	# TODO: Implement save system
	pass

func load_game():
	# TODO: Implement load system
	pass
