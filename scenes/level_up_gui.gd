extends CanvasLayer

@onready var button1 = $VBoxContainer/HBoxContainer/Button
@onready var button2 = $VBoxContainer/HBoxContainer/Button2
@onready var button3 = $VBoxContainer/HBoxContainer/Button3

signal optionSelectedSignal(index: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	button1.pressed.connect(handleButtonPressed.bind(1))
	button2.pressed.connect(handleButtonPressed.bind(2))
	button3.pressed.connect(handleButtonPressed.bind(3))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func handleButtonPressed(index: int):
	print(index)
	optionSelectedSignal.emit(index)
