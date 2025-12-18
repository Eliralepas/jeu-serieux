extends Node2D

@onready var Vbox : VBoxContainer = $image/vBoxContainer
const FILE_PATH := "res://save/save_game.json"
@onready var credit: Control = $credit

func _on_button_jouer_pressed() -> void:
	if FileAccess.file_exists(FILE_PATH):
		# Supprime le fichier existant
		var dir := DirAccess.open("res://save")
		if dir:
			dir.remove(FILE_PATH)
	
	var default_data = {
		"budget": 1100,
		  "cuisine": {
			"nom": "cuisine",
			"remarques": "",
			"saison": 0,
			"score": 0
		  },
		  "dortoir": {
			"nom": "dortoir",
			"remarques": "",
			"saison": 1,
			"score": 0
		  },
		  "salle_de_bain": {
			"nom": "salle_de_bain",
			"remarques": "",
			"saison": 0,
			"score": 0
		  },
		  "salon": {
			"nom": "salon",
			"remarques": "",
			"saison": 1,
			"score": 0
		  },
		  "personnages": {
			"perso1" : 4,
			"perso2" : 4,
			"perso3" : 4,
			"perso4" : 4
		  },
		  "tour": 0,
		"score_total": 0
		}
	var json_string = JSON.stringify(default_data)
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_string(json_string)
	file.close()
	print("Fichier créé avec contenu par défaut :", default_data)
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_reprendre_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")


func _on_button_credits_pressed() -> void:
	credit.visible = true


func _on_button_quitter_pressed() -> void:
	get_tree().quit()
