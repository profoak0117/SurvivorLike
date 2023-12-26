extends Node2D
class_name Health

@export var MAX_HEALTH: int = 10
@onready var health: int = MAX_HEALTH
signal HealthDepletedSignal()

func hit(attack: Attack):
	health -= attack.damage
	print(str(attack.damage) + " damage taken. New health: " + str(health))
	
	if health <= 0:
		HealthDepletedSignal.emit()
