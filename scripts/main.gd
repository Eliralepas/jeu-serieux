extends Node2D
@onready var rideaux = $A
@onready var Armoire2 = $B


func _on_check_rideaux_toggled(toggled_on: bool) -> void:
	$A.visible = toggled_on
