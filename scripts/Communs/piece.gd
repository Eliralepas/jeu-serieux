#extends Node2D #pour avoir toutes les fonctions sur le stock
extends checkBTN

class_name BasePiece

#les attributs que chaque piece doit avoir: 
#(adaptez les chemins si besoin


@onready var menu = $Menu #un menu pour poser/retirer des objets
@onready var store= $Store #chaque piece a un magasin

@onready var objects := { #tous les elements possible dans la piece(donc achetable depuis le magasin)
	"nom": $cheminImage
}

@onready var budget:= 500 #A lire depuis le Json
@onready var stock = [] #Les objets qu'on a (soit des qu'on entre dans la piece soit qu'on achete du magasin)
						#JUSTE LE NOM

	#cette fonction pourra etre utiliser dans tous les ready
func setup() -> void:
	clear_check_boxes()
	add_check_button(stock, objects) #on lui donne ce qu'on a et TOUS les objets possibles
	connect_the_check_boxs(objects) #on lui donne tous les objets possible, elle gere pour trier
	
	$Menu/Panel/Label.text = str(budget) #cast int en str
	
		#on connecte les 2 btn du menu auc fct qui leurs sont attribuer
	$Menu/Panel.connect("magasin_pressed", Callable(self, "_on_magasin_pressed"))
	$Menu/Panel.connect("finaliser_pressed", Callable(self, "_on_finaliser_pressed"))
	

		#on connecte le petit menu mur a sa fct
	$Menu/Panel/MenuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))



	#cette fonction est utile si on a un stock par defaut 
func default_stock(stk: Array)->void:
	stock=stk

func ajout_obj(obj: Dictionary) -> void:
	for key in obj.keys():
		objects[key] = obj[key]  # ajoute ou remplace la cle dans le dictionnaire
