extends Node2D

# =================================================================
# CES VARIABLES VONT APPARAÎTRE DANS L'INSPECTEUR GRÂCE À @export
# =================================================================
@export var menu_items: Array[Sprite2D] = []
@export var button_scene: PackedScene 
# =================================================================

# ASSURE-TOI QUE CE CHEMIN EST CORRECT !
# C'est le chemin depuis ton nœud "Menu" jusqu'au VBoxContainer
@onready var vbox_container = $ScrollContainer/VBoxContainer

func _ready():
	generate_menu()

func generate_menu():
	# 1. Nettoyer l'ancien contenu
	for child in vbox_container.get_children():
		child.queue_free()
		
	# 2. Construire le nouveau contenu
	for Sprite in menu_items:
		# Vérifie si une scène de bouton a été fournie
		if button_scene:
			var new_button = button_scene.instantiate()
			new_button.text = Sprite
			# Tu peux connecter des signaux ici si besoin
			vbox_container.add_child(new_button)
		else:
			# Solution de rechange si tu ne fournis pas de scène
			var new_label = Label.new()
			new_label.text = "Sprite"
			vbox_container.add_child(new_label)
