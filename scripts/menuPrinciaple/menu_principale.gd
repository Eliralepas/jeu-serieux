extends Node2D

@onready var Vbox : VBoxContainer = $Sprite2D/VBoxContainer
const FILE_PATH  = "res://save_game.json"

@onready var button : Button = $Sprite2D/VBoxContainer/ButtonReprendre

func _ready() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file:
		button.disabled = false
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	else :
		button.disabled = true
		button.mouse_default_cursor_shape = Control.CURSOR_ARROW

func _on_button_jouer_pressed() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	if file:
		file.close()
		DirAccess.remove_absolute(FILE_PATH)
	get_tree().change_scene_to_file("res://scenes/hall.tscn")


func _on_button_reprendre_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall.tscn")


func _on_button_credits_pressed() -> void:
	print("Crédits")


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
