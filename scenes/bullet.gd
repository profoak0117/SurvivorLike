extends AttackBase

@export var speed : int = 200

func _init():
	destroySelfOnHit = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	
	
func _on_kill_timer_timeout():
	queue_free()


func _on_hitbox_area_entered(area):
	super(area)
