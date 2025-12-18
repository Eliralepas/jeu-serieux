extends Node2D

const FILE_PATH := "user://save_game.json"

@onready var cuisine: Control = $salles/salon

func _ready() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	
	if file: # Le fichier existe, on le lit
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if json != null:
			for key in json.keys():
				var value = json[key]
				print("Clé :", key, "\tValeur :", value, "\n")
		else:
			print("Erreur de parsing JSON")
		
		file.close()
	else: # Le fichier n'existe pas, on le crée
		var default_data = {
		"budget": 0,
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
		  "tour": 0
		}
		var json_string = JSON.stringify(default_data)
		file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		file.store_string(json_string)
		file.close()
		print("Fichier créé avec contenu par défaut :", default_data)


func _on_dialog_box_on_dialog_end() -> void:
	cuisine.unlock()
