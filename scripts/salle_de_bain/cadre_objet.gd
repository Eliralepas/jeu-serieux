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

func _on_objet_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var check : Button = getCheckButton()
		check.button_pressed = not check.button_pressed
	pass # Replace with function body.
