extends Node2D

@onready var label = $Label
@onready var area = $Area2D
@onready var h_flow_container: HFlowContainer = $HFlowContainer




			#les differentes phrases
var dialogues = [
	"Qu'est-ce que tu veux ?",
	"Me dévalise pas ! Pas plus de deux articles.",
	"Accélère, j'ai d'autres clients !" # dernière phrase normale
]

var objets = [
	"objet", "objet", "o", "o", "o","objet", "objet", "o", "o", "o","objet", "objet", "o", "o", "o","objet", "objet", "o", "o", "o"]


var index = 0 #pour avoir le nb de clicks

func _ready(): #quand la scene demarre
	label.text = dialogues[index] #on met dans le label la phrase a l'indice 0
	area.input_event.connect(_on_area_input_event)
	# on "connecte" le signal input_event du Area2D à la fonction _on_area_input_event()
	#   ça veut dire : "quand quelqu’un clique dans la zone (CollisionShape2D), donc fait un event
	#      appelle automatiquement la fonction _on_area_input_event()"

	for obj in objets:
		var ctrl = Control.new()
		var sprite = Sprite2D.new()
		# On peut charger une texture depuis un fichier
		sprite.texture = load("res://images/cadreObjets.png")
		sprite.scale = Vector2(3, 3)  # double la taille

		# Optionnel : définir la taille ou l'échelle
		
		# Ajouter le sprite comme enfant de l'HBoxContainer
		ctrl.add_child(sprite)
		h_flow_container.add_child(ctrl)
		
		print("itération")




func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed: #si l'evenemt est un clique
		index += 1 #l'indice augmente de 1

		#phrase secrete
		if index == 10:
			label.text = "T'as fini ?!"
			return
			
		if index == 20:
			label.text = "Juste vas t'en..."
			return

		if index == 30:
			label.text = "DEGAGEEEEEE !"
			label.add_theme_font_size_override("font_size", 60)
			return




		# Plus de 3 clics → reste sur la dernière phrase
		if index > 2:
			label.text = dialogues[2]
			label.add_theme_font_size_override("font_size", 30)

			
			#comportement normal
		else:
			label.text = dialogues[index]
