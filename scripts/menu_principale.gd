## @class_doc
## @description Manages the main menu of the game.
## Handles game initialization, save file creation/reset, volume control, and scene transitions.
## @tags ui, main_menu, system

## @depends JSON: uses Serializes game data for saving.
## @depends FileAccess: uses Handles file I/O for save games and credits.
extends Node2D

## @onready_doc
## @description Container for the menu buttons.
## @tags nodes, ui
@onready var Vbox : VBoxContainer = $image/vBoxContainer

## @const_doc
## @description The file path where the game save data is stored.
## @tags config, data
const FILE_PATH := "res://save/save_game.json"

## @onready_doc
## @description Reference to the credits control screen.
## @tags nodes, ui
@onready var credit: Control = $credit

## @var_doc
## @description Icon displayed when sound is muted or enabled.
## @tags resources, ui
var sound_off = preload("res://assets/autres/mute.png")
var sound_on = preload("res://assets/autres/noMute.png")

## @func_doc
## @description Called when the node enters the scene tree. Initialises the mute icon.
## @tags life_cycle, initialization
func _ready():
	update_icon()  # initialise l’icône au lancement

## @func_doc
## @description Starts a new game.
## Deletes existing save data, creates a new default save file, and changes to the hall scene.
## @tags event_handler, game_logic, save_system
func _on_button_jouer_pressed() -> void:
	if FileAccess.file_exists(FILE_PATH):
		# Supprime le fichier existant
		var dir := DirAccess.open("res://save")
		if dir:
			dir.remove(FILE_PATH)
	
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

## @func_doc
## @description Resumes the game by loading the hall scene without resetting data.
## @tags event_handler, scene_change
func _on_button_reprendre_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn")

## @func_doc
## @description Displays the credits screen.
## @tags event_handler, ui
func _on_button_credits_pressed() -> void:
	credit.visible = true

## @func_doc
## @description Quits the application.
## @tags event_handler, system
func _on_button_quitter_pressed() -> void:
	get_tree().quit()

## @func_doc
## @description Toggles the global audio mute state and updates the icon.
## @tags event_handler, audio
func _on_mute_button_pressed() -> void:
	var bus = AudioServer.get_bus_index("Master")
	var muted = AudioServer.is_bus_mute(bus)
	AudioServer.set_bus_mute(bus, !muted)
	update_icon()

## @func_doc
## @description Updates the visual state of the mute button based on the audio bus status.
## @tags ui, update, audio
func update_icon():
	var bus = AudioServer.get_bus_index("Master")
	if AudioServer.is_bus_mute(bus):
		$muteButton.icon = sound_off
	else:
		$muteButton.icon= sound_on
