## @class_doc
## @description Manages the logic for the "Hall" scene, acting as a central hub.
## Handles loading game state, locking/unlocking rooms based on turns, calculating total scores, and managing the dialogue flow.
## @tags game_logic, hub, level_management

## @depends SalleEtat: manages Controls the state (lock/unlock) of connected rooms.
## @depends Dialogue: manages Controls the introductory or summary dialogue box.
extends Node2D

const FILE_PATH := "res://save/save_game.json"

@onready var prochaine: SalleEtat = $salles/cuisine
@onready var dialog_box: Dialogue = $dialogBox

## @onready_doc
## @description Dictionary mapping turn numbers (as strings) to room nodes.
## @tags data, configuration
@onready var salles : Dictionary = {
	"1" : $salles/cuisine,
	"2" : $salles/dortoir,
	"3" : $salles/salle_de_bain,
	"4" : $salles/salon
}

var numero_tour : int = 0

## @func_doc
## @description Initializes the hall scene.
## Reads the save file to determine the current turn, sets up the appropriate dialogue, and configures room locks.
## @tags life_cycle, initialization, file_io
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
				
				 # connecter le signal pour lancer la scène finale après le dernier dialogue
				dialog_box.connect("on_dialog_end", Callable(self, "_on_dialogues_fin"))

				
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

## @func_doc
## @description Calculates the final total score by aggregating scores from all rooms and characters.
## Updates the save file with the calculated total.
## @tags logic, scoring, file_ios)
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

## @func_doc
## @description Writes the provided dictionary to the JSON save file.
## @param json: Dictionary The data to write.
## @tags file_io, helper
func _change_json(json) :
	var file_write := FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file_write:
		file_write.store_string(JSON.stringify(json, "\t", true))
		file_write.close()
	else:
		push_error("Impossible d'écrire le fichier JSON.")

## @func_doc
## @description Locks all rooms up to the current turn number.
## Ensures previous rooms cannot be re-entered.
## @tags state, logic
func _lock_salle() -> void:
	if numero_tour < 5:
		# vérouiller les salles
		for i in range(1, numero_tour+1):
			salles[str(i)].lock()

## @func_doc
## @description Handler for the dialogue end signal. Unlocks the next room if applicable.
## @tags event_handler, logic
func _on_dialog_box_on_dialog_end() -> void:
	#lock l'autre puis unlock la actuelle
	if prochaine != null :
		prochaine.unlock()

## @func_doc
## @description Handler for the dialogue end signal specifically for the final turn.
## Transitions to the ending scene.
## @tags event_handler, scene_transition
func _on_dialogues_fin():
	# Scene finale
	get_tree().change_scene_to_file("res://scenes/fin.tscn")
