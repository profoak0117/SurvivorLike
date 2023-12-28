extends Node

var PlayerPosition: Vector2 = Vector2.ZERO
var PlayerLevel: int = 1
var PlayerXP: int = 0
var XpNeededToLevelUp: int = 5

signal PlayerLeveledUpSignal

func incrementXP(xp: int):
	PlayerXP += xp
	if PlayerXP >= XpNeededToLevelUp:
		PlayerLevel += 1
		PlayerLeveledUpSignal.emit()
		XpNeededToLevelUp += PlayerLevel * 10 * 1.1
		print("Leveled up to level: " + str(PlayerLevel))
