extends Node2D

const FILE_PATH := "user://save_game.json"

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
		  "cuisine": {
			"nom": "cuisine",
			"score": 0,
			"budget": 0,
			"remarques": ""
		  },
		  "dortoir": {
			"nom": "dortoir",
			"score": 0,
			"budget": 0,
			"remarques": ""
		  },
		  "salle_de_bain": {
			"nom": "salle_de_bain",
			"score": 0,
			"budget": 0,
			"remarques": ""
		  },
		  "salon": {
			"nom": "salon",
			"score": 0,
			"budget": 0,
			"remarques": ""
		  },
		  "score_total": 0,
		  "tour": 0
		}
		var json_string = JSON.stringify(default_data)
		file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		file.store_string(json_string)
		file.close()
		print("Fichier créé avec contenu par défaut :", default_data)
