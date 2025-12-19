## @class_doc
## @description Controls the visual state and interaction of a room selection button.
## Handles locking/unlocking animations and scene transition on click.
## @tags ui, navigation, animation
extends Control
class_name SalleEtat

@onready var animation_player: AnimationPlayer = $room/animationLock
@onready var room: TextureButton = $room

## @func_doc
## @description Initializes the button state to transparent and default cursor.
## @tags life_cycle, initialization
func _ready() -> void:
	animation_player.play("transparence")
	room.mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass

## @func_doc
## @description Unlocks the room, playing the unlock animation and changing the cursor.
## @tags state, visual
func unlock() -> void:
	animation_player.play("deverouiller")
	room.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

## @func_doc
## @description Locks the room, playing the lock animation and resetting the cursor.
## @tags state, visual
func lock() -> void:
	animation_player.play("verouiller")
	room.mouse_default_cursor_shape = Control.CURSOR_ARROW

## @func_doc
## @description Handles the room button press.
## Constructs the scene path based on the node name and transitions if the scene exists.
## @tags event_handler, navigation
func _on_room_pressed() -> void:
	var scene_path = "res://scenes/salles/" + name.to_lower() + ".tscn"
	print(scene_path)

	if FileAccess.file_exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		push_warning("⚠️ La scène n'existe pas : " + scene_path)
