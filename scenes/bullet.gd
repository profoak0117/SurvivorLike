extends Node2D

@onready var attack = $Attack
@export var speed : int = 200
@export var damage : int = 10
var direction : Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
	
func _on_kill_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area is Hitbox:
		if area.has_method("hit"):
			area.hit(attack)
			print("hitting hitbox")
		queue_free()

func setBulletDirection(dir: Vector2):
	attack.knockbackDirection = dir
	direction = dir
