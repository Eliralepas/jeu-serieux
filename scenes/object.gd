extends Sprite2D
class_name Object_piece

var aime: Array[Personnage]
var aimepas: Array[Personnage]

func set_visibility(value : bool) :
	visible = value
	set_content(value)

func set_content(value : bool) :
	for aime_p : Personnage in aime :
		aime_p.visible_emotion(value)
	for aimepas_p : Personnage in aimepas :
		aimepas_p.visible_emotion(!value) 
