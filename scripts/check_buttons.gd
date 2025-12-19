## @class_doc
## @description Manages the creation and behavior of check buttons used for inventory items.
## Extends the Stock functionality to handle UI representations of stock items.
## @tags ui, inventory, interaction

## @depends ObjectPiece: uses Toggles visibility of scene objects based on button state.
extends Stock
class_name checkBtn

## @func_doc
## @description Creates CheckButtons for items in the stock and adds them to the UI.
## Connects buttons to their corresponding 3D/2D objects to toggle visibility.
## @param stock: Array List of item names currently owned.
## @param objects: Dictionary Mapping of item names to actual game objects (ObjectPiece).
## @param node: Control The parent container where buttons will be added.
## @tags ui, factory, connection
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
		
		
		
## @func_doc
## @description Removes all existing check buttons from the menu container.
## Should be called before repopulating the list to avoid duplicates.
## @tags ui, cleanup
func clear_check_boxes() -> void:
	var grille : VBoxContainer = $menu/panel/vBoxContainer  # conteneur qui contient les checkbuttons
	if grille:
		for child in grille.get_children():
			child.queue_free()

		
## @func_doc
## @description Re-establishes connections between existing menu check buttons and their corresponding objects.
## Used when reloading or updating the menu state.
## @param objects: Dictionary Mapping of item names to game objects.
## @tags connection, event_handler
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

## @func_doc
## @description Callback for when any inventory check button is toggled.
## Updates the visibility of the corresponding object.
## @param toggled_on: bool New state of the button.
## @param objects: Dictionary Reference to the object map.
## @param button_name: String Name of the button/object.
## @tags event_handler, logic
func _on_any_check_toggled(toggled_on: bool, objects: Dictionary, button_name: String) -> void:
	print("Signal reçu:", button_name, toggled_on)
	var target = objects.get(button_name)
	if target:
		target.visible = toggled_on
