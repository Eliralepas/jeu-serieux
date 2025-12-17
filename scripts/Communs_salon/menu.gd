extends Panel


signal magasin_pressed
signal finaliser_pressed


func add_elem(btn: CheckButton) -> void:
	if btn.get_type() == CheckButton:
		$vBoxContainer.add_child(btn)
		
		
func remove_elem(btn: CheckBox) ->void:
	if btn.get_type() == CheckButton:
		$vBoxContainer.remove_child(btn);
		


func _on_btn_magasin_pressed() -> void:
	print("Bouton magasin pressé")
	emit_signal("magasin_pressed")

func _on_btn_finaliser_pressed() -> void:
	print("Bouton finaliser pressé")

	emit_signal("finaliser_pressed")
