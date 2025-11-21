extends Node

@onready var porte:= $songs/porte

	#quand le btn "magasin" est click
func _on_magasin_pressed(store: Node) -> void: #lors du clique sur le btn magasin
	porte.play() #bruitage
	await get_tree().create_timer(1.20).timeout #petit time de pause
		#gestions des sons
	$songs/magasinBackground.play() 
	$songs/talkingPeople.play()
	$songs/mainBackground.stop()
	
	store.decoche_tout() #on decoche toutes les cases du magasin
	store.visible=true; #on met le magasin en mode visible



	#quand le btn "finaliser" est click
func _on_finaliser_pressed() -> void:
	#on genereras un json
	get_tree().change_scene_to_file("res://scenes/piece_princiaple.tscn") #retour a la piece principale




#########LES FCT DU CHANGEMENT DE COULEUR DU MUR###################
	#modification de la couleur des mur
func _on_menu_mur_color_pressed() -> void:
	var menuMur = $MenuMurColor
	menuMur.get_popup().clear() #afin de ne pas repeter les item a chaque clique
	menuMur.get_popup().add_item("bleu",0)
	menuMur.get_popup().add_item("rouge",1)
	menuMur.get_popup().add_item("vert",2)
	
func _on_mur_color_selected(id: int) -> void:
	couleur_mur(id) 

	
func couleur_mur(num : int) -> void: 
	var bleu=$Mur_Couleurs/Mur_Bleu
	var rouge=$Mur_Couleurs/Mur_Rouge
	var vert=$Mur_Couleurs/Mur_Vert

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
