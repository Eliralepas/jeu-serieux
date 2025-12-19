## @class_doc
## @description Manages the wall visuals and color validation logic for a room.
## @tags visual, game_logic, customization
extends Node2D
class_name Mur

var bonne_couleur : String = "vert"
@onready var couleur_choisie : Sprite2D = $mur1
var murs : Dictionary ={ } 

## @func_doc
## @description Populates the dictionary of wall sprites.
## @param murs_: Dictionary Mapping of color names to Sprite2D nodes.
## @tags setup, configuration
func set_murs(murs_ : Dictionary):
	murs = murs_

## @func_doc
## @description Sets the target "correct" color for the level.
## @param couleur: String The name of the correct color.
## @tags configuration, scoring
func set_bonne_couleur(couleur : String) : 
	bonne_couleur = couleur

## @func_doc
## @description Changes the currently visible wall color.
## @param couleur: Sprite2D The sprite node of the new color to display.
## @tags visual, interaction
func change_couleur(couleur : Sprite2D) : 
	couleur_choisie.visible = false
	
	couleur_choisie = couleur
	couleur_choisie.visible = true
	

## @func_doc
## @description Checks if the currently selected wall color matches the target "correct" color.
## @return bool True if the correct color is visible.
## @tags scoring, logic
func bonne_couleur_choisie() ->bool :
	return murs[bonne_couleur].visible
