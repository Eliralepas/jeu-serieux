extends Node2D

const FILE_PATH := "res://save/save_game.json"

@onready var prochaine: SalleEtat = $salles/cuisine
@onready var dialog_box: Dialogue = $dialogBox

# numero tour : salle correspondante
@onready var salles : Dictionary = {
	"1" : $salles/cuisine,
	"2" : $salles/dortoir,
	"3" : $salles/salle_de_bain,
	"4" : $salles/salon
}

var numero_tour : int = 0

func _ready() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	
	if file: # Le fichier existe, on le lit
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if json != null:
			# lire on est dans quel tour
			numero_tour = json["tour"]
			
			# changer le dialogue
			if numero_tour == 0:
				var dialog : Array = [
					"Notre équipage n'attendait plus que toi.",
					"Vite, familiarise toi avec les lieux et commence ton travail !"
				]
				dialog_box.set_dialog(dialog)
				prochaine = salles["1"]
			else :
				#fermer la salle
				_lock_salle()
				
				# prochaine scene a charger
				if numero_tour < salles.size():
					prochaine = salles[str(numero_tour+1)]
				else:
					prochaine = null
				
				# récupération du dialogue
				var salle : Control = salles[str(numero_tour)]
				var nom_salle = salle.name
				var dial : String = json[nom_salle]["remarques"]
				var dialogue : Array = dial.split("\n")
				print(dialogue)
				
				# ajout du dialogue sur la saison
				var saison_num = json[nom_salle]["saison"]
				print("AA : "+str(saison_num))
				if abs(saison_num) == 0 : 
					dialog_box.set_saison(1)
					print("1 hiver: "+str(saison_num))
				else :
					dialog_box.set_saison(0)
					print("0 été: "+str(saison_num))
				
				dialog_box.set_dialog(dialogue)
			
		else:
			print("Erreur de parsing JSON")
		
		file.close()
	else: # Le fichier n'existe pas, on le crée
		# été : 0 
		# hiver : 1
		var default_data = {
		"budget": 500,
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

func _lock_salle() -> void:
	if numero_tour != 0 :
		salles[str(numero_tour)].lock()

func _on_dialog_box_on_dialog_end() -> void:
	#lock l'autre puis unlock la actuelle
	if prochaine != null :
		prochaine.unlock()
