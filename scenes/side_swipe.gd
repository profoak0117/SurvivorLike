extends AttackBase

@onready var animationPlayer = $AnimationPlayer

func _init():
	followPlayer = true

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("attack")
	animationPlayer.animation_finished.connect(attackDone)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func attackDone(animation):
	if animation == "attack":
		queue_free()


func _on_hitbox_area_entered(area):
	super(area)

