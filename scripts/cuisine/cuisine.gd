extends Node2D

@onready var menu: Sprite2D = $Menu
@onready var v_box_container: VBoxContainer =  menu.get_node("VBoxContainer")
@onready var objects := {
	"Table": $Base/ListeObjet/Table
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button_name in objects.keys():
		var target_node : Object_piece = objects[button_name]
		
		var check := CheckBox.new()
		check.text = button_name
		check.add_theme_color_override('font_color', Color.BLACK)
		check.add_theme_color_override('font_hover_color', Color.BLACK)
		check.add_theme_color_override('font_pressed_color', Color.BLACK)
		check.add_theme_color_override('font_focus_color', Color.BLACK)
		check.add_theme_color_override('font_disabled_color', Color.BLACK)
		check.add_theme_color_override('font_hover_pressed_color', Color.BLACK)
		check.button_pressed = target_node.visible
		target_node.set_visibility(target_node.visible)
		
		v_box_container.add_child(check)
		
		check.toggled.connect(func(pressed: bool): 
			target_node.set_visibility(pressed)
		)
