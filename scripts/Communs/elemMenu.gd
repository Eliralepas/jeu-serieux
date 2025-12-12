extends Control

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
	$Panel/Label.text = "Le budget est de: " + str(budget)

	#quand le btn "finaliser" est click
func _on_finaliser_pressed() -> void:
	#on genereras un json
	get_tree().change_scene_to_file("res://scenes/menu.tscn") #retour a la piece principale

#########LES FCT DU CHANGEMENT DE COULEUR DU MUR###################
	#modification de la couleur des mur
func _on_menu_mur_color_pressed() -> void:
	var menuMur: MenuButton = $Panel/MenuMurColor
	var popup = menuMur.get_popup()

	popup.clear()
	popup.add_item("beige", 0)
	popup.add_item("red", 1)
	popup.add_item("green", 2)

	if not popup.is_connected("id_pressed", Callable(self, "_on_mur_color_selected")):
		popup.connect("id_pressed", Callable(self, "_on_mur_color_selected"))

	
func _on_mur_color_selected(id: int) -> void:
	print("Couleur choisie:", id)
	var beige = get_parent().get_node("Wall_Colors/beige_wall")
	var red = get_parent().get_node("Wall_Colors/red_wall")
	var green = get_parent().get_node("Wall_Colors/green_wall")

	var num = id 
	match num:
		0:
			beige.visible=true
			red.visible=false
			green.visible=false
		1 :
			beige.visible=false
			red.visible=true
			green.visible=false
		2:
			beige.visible=false
			red.visible=false
			green.visible=true



func couleur_mur(num : int) -> void: 
	var beige=$Wall_Colors/beige_wall
	var red=$Wall_Colors/red_wall
	var green=$Wall_Colors/green_wall

	match num:
		0:
			beige.visible=true
			red.visible=false
			green.visible=false
		1 :
			beige.visible=false
			red.visible=true
			green.visible=false
		2:
			beige.visible=false
			red.visible=false
			green.visible=true
