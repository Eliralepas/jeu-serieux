extends Button

func _ready():
	self.text = "Décorer"
	self.pressed.connect(_button_pressed)

func _button_pressed():
	$"../Menu".visible = !$"../Menu".visible
