extends Control

func _ready():
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/test_level.tscn")

func _on_options_button_pressed():
	# TODO: Implement options menu
	pass

func _on_quit_button_pressed():
	get_tree().quit()
