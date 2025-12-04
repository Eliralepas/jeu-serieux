extends Stock

class_name checkBTN


	#fonction a appeler apres l'achat dans le magasin
	#ou au commencement du jeu pour mettre les objets par defauts
func add_check_button(stock:Array, objects:Dictionary, node:Control)->void:
	for item in stock: 
		var check = CheckButton.new()
		check.name=item
		check.text=item
		############## les couleurs ############
		check.add_theme_color_override("font_color", Color(0.0, 0.0, 0.5))          
		check.add_theme_color_override("font_color_pressed", Color(0.0, 0.0, 0.5))  
		check.add_theme_color_override("font_color_hover", Color(0.0, 0.0, 0.5))    
		check.add_theme_color_override("font_color_focus", Color(0.0, 0.0, 0.5))
		########################################
		
		################### la taille #################
		check.add_theme_font_size_override("font_size", 30)
		##############################################
		
		#lorsqu'on fini d'acheter le boutons deja coche le restera 
		var target = objects.get(check.name) #on recup l'objet dont la cle est le nom de la checkbox
		print (target) #pour débug
		if target and target.visible: #si ce node existe et qu'il est visible
			check.button_pressed = true

		node.add_child(check)
		
		
		
		#Vide les elem du menu
		# ! NE VIDE PAS LE STOCK!!!!! ((il faudrait appeler la fct dans baseStock)
		#A appeler avant le add_check_button pour ne pas avoir le meme btn 2 fois
func clear_check_boxes() -> void:
	var grille = $Menu.get_node("GrilleCheckBox")  # conteneur qui contient les checkbuttons
	if grille:
		for child in grille.get_children():
			child.queue_free()

		
		#Ajoute aux checkbutton du menu un event "_on_any_check_toggled" au moment du click
		#a appeler dans le ready ou apres avoir acheter un objet 
func connect_the_check_boxs(objects:Dictionary)->void:
	for button_name in objects.keys():
		var button_path = "Menu/Control/Panel/VBoxContainer/%s" % button_name
		if has_node(button_path):
			var button = get_node(button_path)
			button.connect("toggled", Callable(self, "_on_any_check_toggled").bind(objects, button_name))
		else:
			print("Bouton introuvable:", button_path)


func _on_any_check_toggled(toggled_on: bool, objects: Dictionary, button_name: String) -> void:
	print("Signal reçu:", button_name, toggled_on)
	var target = objects.get(button_name)
	if target:
		target.visible = toggled_on
