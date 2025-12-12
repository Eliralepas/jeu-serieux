extends Control
class_name Cadre_objet

func getVBoxContainer() -> VBoxContainer :
	return get_node("VBoxContainer")

func getCheckButton() -> CheckButton:
	return get_node("VBoxContainer/CheckButton")

func getLabel() -> Label :
	return get_node("VBoxContainer/Label")

func getObjet() -> TextureRect :
	return get_node("VBoxContainer/Cadre/Objet")

func getCadre() -> Sprite2D :
	return get_node("VBoxContainer/Cadre")
