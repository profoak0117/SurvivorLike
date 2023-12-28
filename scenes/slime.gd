extends EnemyBase

var hasCollidedWithPlayer: bool = false

func _ready():
	super()
	animationPlayer.play("idle")
	speed = 25

func _process(delta):
	if !hasCollidedWithPlayer and !isKnockedBack:
		direction = (Globals.PlayerPosition - position)
		velocity = direction.normalized() * speed
	move_and_slide()
	updateCollisions()
	
func updateCollisions():
	pass
	#hasCollidedWithPlayer = false
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var collider = collision.get_collider()
		#if collider.is_in_group("Player"):
			#velocity = (-1 * (Globals.PlayerPosition - position)).normalized() * collider.speed
			#hasCollidedWithPlayer = true
