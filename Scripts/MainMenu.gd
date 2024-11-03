extends Control


func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/GameScreen.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()
