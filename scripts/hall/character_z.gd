extends Node2D

@onready var first_time : bool = true

func _ready() -> void:
	if first_time:
		
		$"../DialogBox".visible = true
		#dialog
	pass
