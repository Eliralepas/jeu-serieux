## @class_doc
## @description Represents a broken object in the game world that can be repaired.
## Manages the repair cost and state.
## @tags gameplay, object, interaction
extends Node2D
## @onready_doc
## @description The button representing the broken object interaction.
## @tags nodes, ui
class_name ObjetCasse

## @onready_doc
## @description The button displayed to confirm repair action and check if it is repared
## @tags nodes, ui
@onready var objet_casse: Button = $objetCasse
@onready var btn_reparer: Button = $objetCasse/btnReparer

var repare : bool = false

## @var_doc
## @description Cost to repair the object.
## @tags config, economy
var _cout : int = 60

## @func_doc
## @description Sets the repair cost and updates the button label.
## @param c: int The new repair cost.
## @tags config, ui
func set_cout(c : int):
	_cout = c
	btn_reparer.text = "Réparer pour : " + str(_cout) + "$"

## @func_doc
## @description Initializes the repair button text.
## @tags life_cycle, initialization
func _ready() -> void:
	btn_reparer.text = "Réparer pour : " + str(_cout) + "$"

## @func_doc
## @description Checks if the object is already repaired.
## @return bool True if repaired, otherwise False.
## @tags state, getter
func est_repare() -> bool : 
	return repare

## @func_doc
## @description Marks the object as repaired.
## @tags state, setter
func set_repare() :
	repare = true

## @func_doc
## @description Toggles the visibility of the repair confirmation button when the object is clicked.
## @tags event_handler, ui
func _on_objet_casse_pressed() -> void:
	btn_reparer.visible = not btn_reparer.visible

## @func_doc
## @description Retrieves the repair cost.
## @return int The cost to repair.
## @tags state, getter
func get_cout() -> int :
	return _cout
