extends Control

class_name Menu

@onready var murs: Mur = $"../murs"

	#quand le btn "magasin" est clickBaseSalle
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

func change_budget(budget):
	$panel/label.text = "Le budget est de: " + str(budget)

	#quand le btn "finaliser" est click
func _on_finaliser_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/hall/hall.tscn") #retour à la piece principale

#########LES FCT DU CHANGEMENT DE COULEUR DU MUR###################
	#modification de la couleur des mur
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
