extends Area2D


func _on_area_entered(area: Area2D) -> void:
	print("Le PNJ déclenche un dialogue !")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Dialogue déclenché par clic sur le PNJ !") # Replace with function body.
