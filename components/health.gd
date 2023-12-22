extends Node2D
class_name Health

@export var MAX_HEALTH: int = 10
@onready var health: int = MAX_HEALTH

func hit(damage: int):
	health -= damage
	print(str(damage) + " damage taken. New health: " + str(health))
