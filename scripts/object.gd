## @class_doc
## @description Represents a game object in the room.
## Manages lists of characters who like or dislike this object and updates their emotions when the object's visibility changes.
## @tags object, game_logic, interaction

## @depends Personnage: uses Updates emotions of associated characters.
extends Sprite2D
class_name ObjectPiece

# pour CHAQUE objet qu'on peut placer ou non
# on a deux listes de personnages (aime et aime_pas)
# l'objet quand elle va etre elle va notifier les personnages pour qu'il change d'emotions
var aime: Array[Personnage]
var aimepas: Array[Personnage]

## @func_doc
## @description Sets the visibility of the object and updates character emotions accordingly.
## @param value: bool True to make visible.
## @tags logic, visual, setter
func set_visibility(value : bool) :
	visible = value
	set_content(value)

## @func_doc
## @description Notifies associated characters to update their emotion state.
## @param value: bool True if the object is present (characters react).
## @tags logic, communication
func set_content(value : bool) :
	for aime_p : Personnage in aime :
		aime_p.visible_emotion(value)
	for aimepas_p : Personnage in aimepas :
		aimepas_p.visible_emotion(!value) 
