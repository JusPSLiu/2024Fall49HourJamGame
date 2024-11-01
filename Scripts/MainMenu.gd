extends Control

func _ready() -> void:
	$AnimationPlayer.play('fish_spin')


func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()
