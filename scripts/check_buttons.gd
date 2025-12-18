extends Stock
class_name checkBtn

	#fonction a appeler apres l'achat dans le magasin
	#ou au commencement du jeu pour mettre les objets par defauts
func add_check_button(stock:Array, objects:Dictionary, node:Control)->void:
	for item in stock: 
		var check = CheckButton.new()
		check.name=item
		check.text=item
		############## les couleurs ############
		check.add_theme_color_override('font_color', Color.BLACK)
		check.add_theme_color_override('font_hover_color', Color.BLACK)
		check.add_theme_color_override('font_pressed_color', Color.BLACK)
		check.add_theme_color_override('font_focus_color', Color.BLACK)
		check.add_theme_color_override('font_disabled_color', Color.BLACK)
		check.add_theme_color_override('font_hover_pressed_color', Color.BLACK)
		########################################
		
		################### la taille #################
		check.add_theme_font_size_override("font_size", 30)
		##############################################
		
		print("Name salle : "+ node.get_parent().get_parent().get_parent().name)
		
		#lorsqu'on fini d'acheter le boutons deja coche le restera 
		var target : ObjectPiece = objects.get(check.name) #on recup l'objet dont la cle est le nom de la checkbox
		target.set_visibility(target.visible)
		
		check.toggled.connect(func(pressed: bool): 
			target.set_visibility(pressed)
		)
		node.add_child(check)
		
		
		
		#Vide les elem du menu
		# ! NE VIDE PAS LE STOCK!!!!! ((il faudrait appeler la fct dans baseStock)
		#A appeler avant le add_check_button pour ne pas avoir le meme btn 2 fois
func clear_check_boxes() -> void:
	var grille : VBoxContainer = $menu/panel/vBoxContainer  # conteneur qui contient les checkbuttons
	if grille:
		for child in grille.get_children():
			child.queue_free()

		
		#Ajoute aux checkbutton du menu un event "_on_any_check_toggled" au moment du click
		#a appeler dans le ready ou apres avoir acheter un objet 
func connect_the_check_boxs(objects:Dictionary)->void:
	for button_name in objects.keys():
		var button_path = "menu/panel/vBoxContainer/%s" % button_name
		if has_node(button_path):
			var button = get_node(button_path)
			button.connect("toggled", Callable(self, "_on_any_check_toggled").bind(objects, button_name))
			
			var target : ObjectPiece = objects.get(button_name) 
			target.set_visibility(false)
		else:
			print("Bouton introuvable:", button_path)


func _on_any_check_toggled(toggled_on: bool, objects: Dictionary, button_name: String) -> void:
	print("Signal reçu:", button_name, toggled_on)
	var target = objects.get(button_name)
	if target:
		target.visible = toggled_on
