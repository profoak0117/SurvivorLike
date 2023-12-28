extends Node2D

@onready var animationPlayer = $AnimationPlayer
@onready var attack = $Attack

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
	print("area entered")
	if area is Hitbox:
		print("is hitbox")
		if area.has_method("hit"):
			area.hit(attack)
			print("swiping hitbox")
