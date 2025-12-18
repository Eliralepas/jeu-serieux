extends Node2D

@onready var Vbox : VBoxContainer = $image/vBoxContainer

func _on_button_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_reprendre_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_credits_pressed() -> void:
	print("Crédits")


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
