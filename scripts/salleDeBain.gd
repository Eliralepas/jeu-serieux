extends Node

# Fais glisser ton instance de Menu ici
@export var menu_instance_path: NodePath
@onready var menu_instance = get_node(menu_instance_path)

func _ready():
	# 1. Vider le menu (important si tu le re-remplis)
	menu_instance.clear_menu()
	
	# 2. Créer le contenu spécifique à SDB
	var bouton_douche = Button.new()
	bouton_douche.text = "Prendre une douche"
	
	var bouton_lavabo = Button.new()
	bouton_lavabo.text = "Se laver les mains"
	
	# 3. Ajouter le contenu au menu
	menu_instance.add_menu_item(bouton_douche)
	menu_instance.add_menu_item(bouton_lavabo)
