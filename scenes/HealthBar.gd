extends TextureProgressBar

func _ready():
	Globals.PlayerHealthChangedSignal.connect(handleHealthChanged)
	resetHpBar()

func handleHealthChanged(health: int):
	value = health

func resetHpBar():
	min_value = 0
	max_value = Globals.PlayerHP
	value = max_value
