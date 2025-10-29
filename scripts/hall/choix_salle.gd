extends Node2D
@onready var liste_salles: Array[Node] = get_children()

func _ready() -> void:
	for button in liste_salles:
		if button is Button:
			# Connecte le signal en passant le nom du bouton comme argument
			button.pressed.connect(_on_button_pressed.bind(button.name))

func _on_button_pressed(button_name: String) -> void:
	var scene_path = "res://scenes/" + button_name.to_lower() + ".tscn"

	if FileAccess.file_exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("⚠️ La scène n'existe pas : " + scene_path)
