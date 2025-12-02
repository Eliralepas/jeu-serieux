extends checkBTN

class_name BasePiece

#les attributs que chaque piece doit avoir: 
#(adaptez les chemins si besoin

@onready var porte= $songs/porte
@onready var magasinBackground = $songs/magasinBackground
@onready var talkingPeople=$songs/talkingPeople
@onready var mainBackground=$songs/mainBackground

@onready var menu = $Menu #un menu pour poser/retirer des objets
@onready var store= $Store #chaque piece a un magasin

@onready var conteneur=$Menu/Control/Panel/VBoxContainer
@onready var objects := { #tous les elements possible dans la piece(donc achetable depuis le magasin)
	"nom": $cheminImage,
	"radiateur": $ListeObjets/radiateur
}

@onready var budget:= 500 #A lire depuis le Json
@onready var stock :Array= [] #Les objets qu'on a (soit des qu'on entre dans la piece soit qu'on achete du magasin)
						#JUSTE LE NOM


func _ready() -> void:
	setup();


func get_stock() ->Array:
	return stock

func get_objects() -> Dictionary:
	return objects
	#cette fonction pourra etre utiliser dans tous les ready
func setup() -> void:
	add_check_button(stock, objects, conteneur) #on lui donne ce qu'on a et TOUS les objets possibles
	connect_the_check_boxs(objects) #on lui donne tous les objets possible, elle gere pour trier
	$Menu._on_menu_mur_color_pressed()
	
	$Menu/Control/Panel/Label.text = str(budget) #cast int en str
	
		#on connecte les 2 btn du menu auc fct qui leurs sont attribuer
	$Menu/Control/Panel/btn_Magasin.connect("pressed", Callable(self, "_magasin_pressed"))
	$Menu/Control/Panel/btn_Finaliser.connect("pressed", Callable(self, "_finaliser_pressed"))
	
	
	

		#on connecte le petit menu mur a sa fct
	$Menu/Control/Panel/MenuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))

		#the magasin
	$Store/Btn_Acheter.connect("pressed", Callable(self, "_on_button_acheter"))
	$Store/Btn_Sortir.connect("pressed", Callable(self, "_on_btn_sortir"))


	#cette fonction est utile si on a un stock par defaut 
func default_stock(stk: Array)->void:
	stock=stk

func ajout_obj(obj: Dictionary) -> void:
	for key in obj.keys():
		stock.append(obj[key]) 
		
		
func _magasin_pressed():
	$Menu._on_magasin_pressed($Store,porte, magasinBackground, talkingPeople, mainBackground)

func _finaliser_pressed():
	$Menu._on_finaliser_pressed()

func reconnect_menu_buttons():
	var btnMag = $Menu/Control/Panel/btn_Magasin
	var btnFin = $Menu/Control/Panel/btn_Finaliser

	if not btnMag.is_connected("pressed", Callable(self, "_magasin_pressed")):
		btnMag.connect("pressed", Callable(self, "_magasin_pressed"))

	if not btnFin.is_connected("pressed", Callable(self, "_finaliser_pressed")):
		btnFin.connect("pressed", Callable(self, "_finaliser_pressed"))
		
func _on_button_acheter() :
	$Store._on_button_acheter_pressed()
	
func _on_btn_sortir() :
	$Store._on_btn_sortir_pressed()
