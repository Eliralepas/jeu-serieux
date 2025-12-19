## @class_doc
## @description Represents a UI frame for a store object, containing the object's image, a label, and a selection checkbox.
## Provides helper methods to access internal UI components.
## @tags ui, store, inventory
extends Control
class_name CadreObjet

## @func_doc
## @description Retrieves the VBoxContainer that organizes the visual elements of the frame.
## @return VBoxContainer The main container of the frame.
## @tags ui, getter
func getVBoxContainer() -> VBoxContainer :
	return get_node("vBoxContainer")

## @func_doc
## @description Retrieves the CheckButton used to select the object.
## @return CheckButton The selection checkbox.
## @tags ui, getter, input
func getCheckButton() -> CheckButton:
	return get_node("vBoxContainer/checkButton")

## @func_doc
## @description Retrieves the Label displaying the object's price or name.
## @return Label The text label component.
## @tags ui, getter
func getLabel() -> Label :
	return get_node("vBoxContainer/label")

## @func_doc
## @description Retrieves the TextureRect representing the object's image.
## @return TextureRect The image component.
## @tags ui, getter
func getObjet() -> TextureRect :
	return get_node("vBoxContainer/cadre/objet")

## @func_doc
## @description Retrieves the Sprite2D acting as the background frame or border.
## @return Sprite2D The frame sprite.
## @tags ui, getter
func getCadre() -> Sprite2D :
	return get_node("vBoxContainer/cadre")

## @func_doc
## @description Handles input events on the object's image area.
## Toggles the associated CheckButton when the object image is clicked.
## @param event: InputEvent The input event to process.
## @tags ui, input, event_handler
func _on_objet_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var check : Button = getCheckButton()
		check.button_pressed = not check.button_pressed
	pass # Replace with function body.
