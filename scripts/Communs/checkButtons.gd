extends Stock

class_name checkBTN


	#fonction a appeler apres l'achat dans le magasin
	#ou au commencement du jeu pour mettre les objets par defauts
func add_check_button(stock:Array, objects:Dictionary)->void:
	for item in stock: 
		var check = CheckButton.new()
		check.name="Check"+item
		check.text=item
		############## les couleurs ############
		check.add_theme_color_override("font_color", Color(0.0, 0.0, 0.5))           # Normal
		check.add_theme_color_override("font_color_pressed", Color(0.0, 0.0, 0.5))   # When pressed
		check.add_theme_color_override("font_color_hover", Color(0.0, 0.0, 0.5))     # When hovered
		check.add_theme_color_override("font_color_focus", Color(0.0, 0.0, 0.5))
		########################################
		
		################### la taille #################
		check.add_theme_font_size_override("font_size", 30)
		##############################################
		
		#lorsqu'on fini d'acheter le boutons deja coche le restera 
		var target = objects.get(check.name) #on recup l'objet dont la cle est le nom de la checkbox
		if target and target.visible: #si ce node existe et qu'il est visible
			check.button_pressed = true

		$Menu/VboxContainer.add_child(check)
		
		
		
		#Vide les elem du menu
		# ! NE VIDE PAS LE STOCK!!!!! ((il faudrait appeler la fct dans baseStock)
		#A appeler avant le add_check_button pour ne pas avoir le meme btn 2 fois
func clear_check_boxes() -> void:
	for child in $Menu.get_children():
		child.queue_free()
		
		
		
		#Ajoute aux checkbutton du menu un event "_on_any_check_toggled" au moment du click
		#a appeler dans le ready ou apres avoir acheter un objet 
func connect_the_check_boxs(objects:Dictionary)->void:
	for button_name in objects.keys():
		var button_path = "Menu/GrilleCheckBox/%s" % button_name  # crée le chemin en texte
		if has_node(button_path):  # vérifie que le bouton existe
			var button = get_node(button_path)
			button.connect("toggled", Callable(self, "_on_any_check_toggled").bind(button_name))
			
			
	#le event a connecter au check_buttons
	#a chaque changement d'etat du buton on met la visibilite de l'objet que ce checkbutton doit gerer dans le meme etat
func _on_any_check_toggled(objects:Dictionary, toggled_on: bool, button_name: String) -> void:
	var target = objects.get(button_name) #recup objet emeteur du signal
	if target:
		target.visible = toggled_on #on met la visibilite selon comment est l'etant du btn clicke
