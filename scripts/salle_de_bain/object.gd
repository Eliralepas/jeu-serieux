extends Sprite2D
class_name Object_piece

# pour CHAQUE objet qu'on peut placer ou non
# on a deux listes de personnages (aime et aime_pas)
# l'objet quand elle va etre elle va notifier les personnages pour qu'il change d'emotions
var aime: Array[Personnage]
var aimepas: Array[Personnage]

func set_visibility(value : bool) :
	visible = value
	set_content(value)

# cette fonction notifie ses personnages s'il apparait ou non
func set_content(value : bool) :
	for aime_p : Personnage in aime :
		aime_p.visible_emotion(value)
	for aimepas_p : Personnage in aimepas :
		aimepas_p.visible_emotion(!value) 
