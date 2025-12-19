## @class_doc
## @description Manages the in-game menu interactions, including accessing the store, changing wall colors, and finalizing room setups.
## @tags ui, menu, interaction

## @depends Mur: uses Interacts with wall objects to change colors.
## @depends Magasin: uses Controls the visibility and state of the store/magasin.
extends Control
class_name Menu

## @onready_doc
## @description Reference to the node containing wall objects.
## @tags nodes, scene_tree_referenc
@onready var murs: Mur = $"../murs"

## @func_doc
## @description Triggers the transition to the store (Magasin) view.
## Plays sound effects, stops the main background music, and makes the store interface visible.
## @param store: Node The store node to display.
## @param porte: Node The audio player for the door sound effect.
## @param magasin_background: Node The audio player for the store background music.
## @param talking_people: Node The audio player for the ambient crowd sound.
## @param main_background: Node The audio player for the main scene background music.
## @tags event_handler, audio, ui_transition
func _on_magasin_pressed(store: Node, porte: Node, magasinBackground: Node, talkingPeople: Node, mainBackground: Node) -> void: #lors du clique sur le btn magasin
	porte.play() #bruitage
	await get_tree().create_timer(1.20).timeout #petit time de pause
		#gestions des sons
	magasinBackground.play() 
	talkingPeople.play()
	mainBackground.stop()
	
	store.decoche_tout() #on decoche toutes les cases du magasin
	store.visible=true; #on met le magasin en mode visible
	store.set_process_input(true)

## @func_doc
## @description Updates the budget display label with the current budget value.
## @param budget: int/float The numeric value of the remaining budget.
## @tags ui, update
func change_budget(budget):
	$panel/label.text = "Le budget est de: " + str(budget)

## @func_doc
## @description Finalizes the current room setup and returns to the main hall scene.
## @tags navigation, scene_change
func _on_finaliser_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn") #retour à la piece principale

#########LES FCT DU CHANGEMENT DE COULEUR DU MUR###################

## @func_doc
## @description Populates and displays the wall color selection popup menu.
## @tags ui, menu, wall_customization
func _on_menu_mur_color_pressed() -> void:
	var menuMur: MenuButton = $panel/menuMurColor
	var popup = menuMur.get_popup()
	
	popup.clear()
	var i : int = 0
	for mur : Sprite2D in murs.get_children():
		popup.add_item(mur.name, i)
		i+=1

	if not popup.is_connected("id_pressed", Callable(self, "_on_mur_color_selected")):
		popup.connect("id_pressed", Callable(self, "_on_mur_color_selected"))

## @func_doc
## @description Handles the selection of a wall color from the popup menu.
## Changes the color of the specific wall based on the selected ID.
## @param id: int The ID of the selected menu item.
## @tags event_handler, wall_customization
func _on_mur_color_selected(id: int) -> void:
	var mur1 = murs.get_node("mur1")
	var mur2 = murs.get_node("mur2")
	var mur3 = murs.get_node("mur3")

	var num = id 
	match num:
		0:
			murs.change_couleur(mur1)
		1 :
			murs.change_couleur(mur2)
		2:
			murs.change_couleur(mur3)
