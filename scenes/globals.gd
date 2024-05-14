extends Node

#Position
var PlayerPosition: Vector2 = Vector2.ZERO

#Health
var MAX_HEALTH: int = 10
var PlayerHP: int = 10
signal PlayerHealthChangedSignal(playerHealth: int)

#Xp
var PlayerLevel: int = 1
var PlayerXP: int = 0
var XpNeededToLevelUp: int = 5
signal PlayerLeveledUpSignal
signal XpChangedSignal(playerXp: int)

func incrementXP(xp: int):
	PlayerXP += xp
	if PlayerXP >= XpNeededToLevelUp:
		PlayerLevel += 1
		XpNeededToLevelUp += PlayerLevel * 10 * 1.1
		PlayerLeveledUpSignal.emit()
		print("Leveled up to level: " + str(PlayerLevel))
	XpChangedSignal.emit(PlayerXP)

func changeHP(hpChanged: int):
	PlayerHP + hpChanged
	PlayerHealthChangedSignal.emit(PlayerHP)
