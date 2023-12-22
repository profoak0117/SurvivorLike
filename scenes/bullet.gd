extends Node2D

@export var speed : int = 200
@export var damage : int = 10
var direction : Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
	
func _on_kill_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		if area.has_method("hit"):
			area.hit(damage)
		queue_free()
