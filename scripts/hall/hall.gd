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
					"Bienvenue à Concordia !",
					"On m'a dit que t'étais THE BEST architecte !",
					"En plus de ça, notre équipage n'attendait plus que toi pour les rénovations.",
					"Vite, familiarise toi avec les lieux et commence ton travail !"
				]
				dialog_box.set_dialog(dialog)
				prochaine = salles["1"]
			elif numero_tour == 4:
				_calcul_score_total()
				
				#fermer la salle
				_lock_salle()
				
				var salle : Control = salles[str(numero_tour)]
				var nom_salle = salle.name
				var dial : String = json[nom_salle]["remarques"]
				var dialogue : Array = dial.split("\n")
				dialogue.push_back("Bon et bien, merci de nous avoir aidé.\n")
				dialog_box.set_saison(2)
				dialog_box.set_dialog(dialogue)
				
				# SCENE FINALE
				# get_tree().change_scene_to_file()
				
			elif numero_tour < 4:
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
				if abs(saison_num) == 0 : 
					dialog_box.set_saison(1)
				else :
					dialog_box.set_saison(0)
				
				dialog_box.set_dialog(dialogue)
			else :
				pass
		else:
			print("Erreur de parsing JSON")
		
		file.close()
	else: # Le fichier n'existe pas, on le crée
		print("Le fichier json n'existe pas.")
		get_tree().change_scene_to_file("res://scenes/menu_principale.tscn")

# calcul du score final (juste une adition entre les scores des salles et personnages)
func _calcul_score_total() -> void:
	var total : int = 0
	var file = FileAccess.open(FILE_PATH, FileAccess.READ_WRITE)
	if file: # Le fichier existe, on le lit
		var content = file.get_as_text()
		var json = JSON.parse_string(content)
		if json != null:
			total += json["cuisine"]["score"]
			total += json["salon"]["score"]
			total += json["dortoir"]["score"]
			total += json["salle_de_bain"]["score"]
			
			total += json["personnages"]["perso1"]
			total += json["personnages"]["perso2"]
			total += json["personnages"]["perso3"]
			total += json["personnages"]["perso4"]
			
			json["score_total"] = total
			_change_json(json)
	file.close()
	
func _change_json(json) :
	var file_write := FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file_write:
		file_write.store_string(JSON.stringify(json, "\t", true))
		file_write.close()
	else:
		push_error("Impossible d'écrire le fichier JSON.")

func _lock_salle() -> void:
	if numero_tour < 5:
		# vérouiller les salles
		for i in range(1, numero_tour+1):
			salles[str(i)].lock()

func _on_dialog_box_on_dialog_end() -> void:
	#lock l'autre puis unlock la actuelle
	if prochaine != null :
		prochaine.unlock()
