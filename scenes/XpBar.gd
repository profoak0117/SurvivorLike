extends TextureProgressBar

func _ready():
	Globals.XpChangedSignal.connect(handleXpChanged)
	Globals.PlayerLeveledUpSignal.connect(handlePlayerLeveledUp)
	resetXpBar()

func handleXpChanged(playerXp: int):
	value = playerXp
	
func handlePlayerLeveledUp():
	resetXpBar()

func resetXpBar():
	min_value = Globals.PlayerXP
	max_value = Globals.XpNeededToLevelUp
	value = min_value
