extends Node2D

@onready var Vbox : VBoxContainer = $Sprite2D/VBoxContainer
const FILE_PATH  = "user://save_game.json"

func _ready() -> void:
	for i in range(Vbox.get_child_count()):
		var button = Vbox.get_child(i)
		
		match i:
			0:
				button.pressed.connect(_on_jouer_pressed)
			1:
				var file = FileAccess.open(FILE_PATH, FileAccess.READ)
				if file : 
					button.disabled = false;
				else :
					button.disabled = true;
				button.pressed.connect(_on_jouer_pressed)
			2: 
				button.pressed.connect(_on_credits_pressed)
			3:
				button.pressed.connect(_on_quitter_pressed)

func _on_jouer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall.tscn")

func _on_credits_pressed() -> void:
	print("Crédits")

func _on_quitter_pressed() -> void:
	get_tree().quit()
