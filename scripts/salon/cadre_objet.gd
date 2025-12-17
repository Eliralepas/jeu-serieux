extends Control
class_name CadreObjet

func getVBoxContainer() -> VBoxContainer :
	return get_node("vBoxContainer")

func getCheckButton() -> CheckButton:
	return get_node("vBoxContainer/checkButton")

func getLabel() -> Label :
	return get_node("vBoxContainer/label")

func getObjet() -> TextureRect :
	return get_node("vBoxContainer/cadre/objet")

func getCadre() -> Sprite2D :
	return get_node("vBoxContainer/cadre")

func _on_objet_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var check : Button = getCheckButton()
		check.button_pressed = not check.button_pressed
	pass # Replace with function body.
