extends Area2D
class_name Hitbox

signal HitSignal(attack: Attack)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit(attack: Attack):
	HitSignal.emit(attack)
	print("hitbox hit by attack")
