extends Node2D

class_name Menu

	#quand le btn "magasin" est clickBaseSalle
func _on_magasin_pressed(store: Node, porte: Node, magasinBackground: Node, talkingPeople: Node, mainBackground: Node) -> void: #lors du clique sur le btn magasin
	print("7 elem menu")
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
	$Control/Panel/Label.text = "Le budget est de: " + str(budget)

	#quand le btn "finaliser" est click
func _on_finaliser_pressed() -> void:
	#on genereras un json
	get_tree().change_scene_to_file("res://scenes/menu.tscn") #retour a la piece principale




#########LES FCT DU CHANGEMENT DE COULEUR DU MUR###################
	#modification de la couleur des mur
func _on_menu_mur_color_pressed() -> void:
	var menuMur: MenuButton = $Control/Panel/MenuMurColor
	var popup = menuMur.get_popup()

	popup.clear()
	popup.add_item("bleu", 0)
	popup.add_item("rouge", 1)
	popup.add_item("vert", 2)

	if not popup.is_connected("id_pressed", Callable(self, "_on_mur_color_selected")):
		popup.connect("id_pressed", Callable(self, "_on_mur_color_selected"))

	
func _on_mur_color_selected(id: int) -> void:
	print("Couleur choisie:", id)
	var bleu = get_parent().get_node("Murs/MurBleu")
	var rouge = get_parent().get_node("Murs/MurRouge")
	var vert = get_parent().get_node("Murs/MurVert")

	var num = id 
	match num:
		0:
			bleu.visible=true
			rouge.visible=false
			vert.visible=false
		1 :
			bleu.visible=false
			rouge.visible=true
			vert.visible=false
		2:
			bleu.visible=false
			rouge.visible=false
			vert.visible=true


	
func couleur_mur(num : int) -> void: 
	var bleu=$Murs/MurBleu
	var rouge=$Murs/MurRouge
	var vert=$Murs/MurVert

	match num:
		0:
			bleu.visible=true
			rouge.visible=false
			vert.visible=false
		1 :
			bleu.visible=false
			rouge.visible=true
			vert.visible=false
		2:
			bleu.visible=false
			rouge.visible=false
			vert.visible=true
