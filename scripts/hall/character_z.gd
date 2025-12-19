## @class_doc
## @description Simple script to handle the initialization of Character Z's dialogue visibility.
## @tags character, logic, dialogue
extends Node2D

@onready var first_time : bool = true

## @func_doc
## @description Displays the dialogue box if it is the first time running.
## @tags life_cycle, logic
func _ready() -> void:
	if first_time:
		
		$"../dialogBox".visible = true
		#dialog
	pass
