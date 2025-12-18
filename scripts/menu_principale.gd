extends Node2D

@onready var Vbox : VBoxContainer = $image/vBoxContainer
const FILE_PATH  = "res://save_game.json"

func _on_button_jouer_pressed() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file:
		file.close()
		DirAccess.remove_absolute(FILE_PATH)
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_reprendre_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_credits_pressed() -> void:
	print("Crédits")


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
