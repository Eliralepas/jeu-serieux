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

@onready var conteneur=$Menu/Panel/VBoxContainer
@onready var objects := { #tous les elements possible dans la piece(donc achetable depuis le magasin)
	#"nom": $cheminImage,
	"radiateur": $ListeObjets/radiateur,
	"cd":$ListeObjets/cd
}

@onready var budget:= 500 #A lire depuis le Json
@onready var stock :Array= [] #Les objets qu'on a (soit des qu'on entre dans la piece soit qu'on achete du magasin)
						#JUSTE LE NOM
						
@onready var reparer=false
@onready var prixReparation=30

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
	for obj : Object_piece in objects.values():
		obj.set_visibility(false)
	$Menu._on_menu_mur_color_pressed()
	
	$Menu/Panel/Label.text = str(budget) #cast int en str
	
		#on connecte les 2 btn du menu auc fct qui leurs sont attribuer
	$Menu/Panel/btn_Magasin.connect("pressed", Callable(self, "_magasin_pressed"))
	$Menu/Panel/btn_Finaliser.connect("pressed", Callable(self, "_finaliser_pressed"))
	
		#on connecte le petit menu mur a sa fct
	$Menu/Panel/MenuMurColor.get_popup().connect("id_pressed", Callable(self, "_on_mur_color_selected"))
	
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
	var btnMag = $Menu/Panel/btn_Magasin
	var btnFin = $Menu/Panel/btn_Finaliser

	if not btnMag.is_connected("pressed", Callable(self, "_magasin_pressed")):
		btnMag.connect("pressed", Callable(self, "_magasin_pressed"))

	if not btnFin.is_connected("pressed", Callable(self, "_finaliser_pressed")):
		btnFin.connect("pressed", Callable(self, "_finaliser_pressed"))
		
func _on_button_acheter() :
	$Store._on_button_acheter_pressed()
	
func _on_btn_sortir() :
	$Store._on_btn_sortir_pressed()


func _on_espace_borken_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and reparer==false:
		$ListeObjets/BrokenObject/BtnReparer.visible = true


func _on_btn_reparer_pressed() -> void:
	if reparer==false:
		if budget>prixReparation:
			budget=budget-prixReparation
			menu.change_budget(budget)
			$ListeObjets/BrokenObject/AnimatedSprite2D.play();
			reparer=true
			$ListeObjets/BrokenObject/BtnReparer.visible=false
		
		
