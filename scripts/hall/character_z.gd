extends Node2D

@onready var firt_time : bool = true

func _ready() -> void:
	if firt_time:
		$"../Control".visible = true
		#dialog
	pass
