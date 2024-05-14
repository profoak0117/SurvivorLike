extends EnemyBase

var hasCollidedWithPlayer: bool = false

func _init():
	speed = 25

func _ready():
	super()
	animationPlayer.play("idle")

func _process(delta):
	if !isKnockedBack:
		direction = (Globals.PlayerPosition - position)
		velocity = direction.normalized() * speed
	move_and_slide()
